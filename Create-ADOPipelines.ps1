# ============================================================
# Create-ADOPipelines.ps1
# Creates ADO pipeline definitions for all nd_*.yml files
# using the Azure DevOps REST API and a PAT token.
# ============================================================

param(
    [string] $OrgUrl          = "",
    [string] $Project         = "",
    [string] $RepoName        = "",
    [string] $Pat             = "",
    [string] $PipelinesFolder = "/pipelines",
    [string] $AdoPipelineFolder = "\\nd-pipelines",
    [string] $Branch          = "main",
    [string] $DryRun          = "false"
)

$ErrorActionPreference = "Stop"

# Validate required params
if (-not $OrgUrl)    { throw "-OrgUrl is required.  e.g. https://dev.azure.com/myorg" }
if (-not $Project)   { throw "-Project is required." }
if (-not $RepoName)  { throw "-RepoName is required." }
if (-not $Pat)       { throw "-Pat is required." }

$isDryRun = ($DryRun -eq "true" -or $DryRun -eq "1" -or $DryRun -eq "yes")

# ── Auth header ───────────────────────────────────────────────
$base64Pat = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$Pat"))
$headers = @{
    Authorization  = "Basic $base64Pat"
    "Content-Type" = "application/json"
}

$apiVersion = "api-version=7.1"
$baseUrl    = "$($OrgUrl.TrimEnd('/'))/$([uri]::EscapeDataString($Project))/_apis"

# ── Step 1: Resolve repository ID ────────────────────────────
Write-Host "`n[1/3] Resolving repository '$RepoName'..." -ForegroundColor Cyan

$repoUrl  = "$baseUrl/git/repositories/$([uri]::EscapeDataString($RepoName))?$apiVersion"
$repoInfo = Invoke-RestMethod -Uri $repoUrl -Headers $headers -Method Get
$repoId   = $repoInfo.id

Write-Host "      Repository ID: $repoId" -ForegroundColor Green

# ── Step 2: Collect nd_*.yml files ───────────────────────────
$scriptDir     = $PSScriptRoot
$pipelinesDir  = Join-Path $scriptDir "pipelines"
$ndFiles       = Get-ChildItem -Path $pipelinesDir -Filter "nd_*.yml" | Sort-Object Name

if ($ndFiles.Count -eq 0) {
    Write-Warning "No nd_*.yml files found in '$pipelinesDir'. Exiting."
    exit 0
}

Write-Host "`n[2/3] Found $($ndFiles.Count) nd_*.yml pipeline(s):" -ForegroundColor Cyan
$ndFiles | ForEach-Object { Write-Host "      - $($_.Name)" }

# ── Step 3: Create each pipeline ─────────────────────────────
Write-Host "`n[3/3] Creating ADO pipelines..." -ForegroundColor Cyan

$createUrl = "$baseUrl/pipelines?$apiVersion"
$results   = [System.Collections.Generic.List[PSObject]]::new()

foreach ($file in $ndFiles) {
    # Derive a human-friendly name:
    #   nd_01-basic-ci.yml  ->  01 Basic CI
    $baseName     = $file.BaseName                          # nd_01-basic-ci
    $stripped     = $baseName -replace '^nd_', ''          # 01-basic-ci
    $titleWords   = ($stripped -replace '-', ' ') -split ' ' |
                        ForEach-Object { $_.Substring(0,1).ToUpper() + $_.Substring(1) }
    $pipelineName = $titleWords -join ' '                  # 01 Basic Ci  (ADO will display it)

    $yamlPath = "$PipelinesFolder/$($file.Name)"           # /pipelines/nd_01-basic-ci.yml

    $body = @{
        name   = $pipelineName
        folder = $AdoPipelineFolder
        configuration = @{
            type = "yaml"
            path = $yamlPath
            repository = @{
                id            = $repoId
                type          = "azureReposGit"
                defaultBranch = "refs/heads/$Branch"
            }
        }
    } | ConvertTo-Json -Depth 10

    if ($isDryRun) {
        Write-Host "  [DryRun] Would create: '$pipelineName'  ->  $yamlPath" -ForegroundColor Yellow
        $results.Add([PSCustomObject]@{
            File   = $file.Name
            Name   = $pipelineName
            Status = "DryRun"
            Id     = "-"
            Url    = "-"
        })
        continue
    }

    try {
        $response = Invoke-RestMethod -Uri $createUrl -Headers $headers -Method Post -Body $body
        Write-Host "  [OK] '$pipelineName'  (id=$($response.id))" -ForegroundColor Green
        $results.Add([PSCustomObject]@{
            File   = $file.Name
            Name   = $pipelineName
            Status = "Created"
            Id     = $response.id
            Url    = $response._links.web.href
        })
    }
    catch {
        $errMsg = $_.Exception.Message
        # 409 = pipeline already exists
        if ($_.Exception.Response.StatusCode -eq 409) {
            Write-Host "  [SKIP] '$pipelineName' already exists." -ForegroundColor Yellow
            $results.Add([PSCustomObject]@{
                File   = $file.Name
                Name   = $pipelineName
                Status = "AlreadyExists"
                Id     = "-"
                Url    = "-"
            })
        }
        else {
            Write-Host "  [FAIL] '$pipelineName': $errMsg" -ForegroundColor Red
            $results.Add([PSCustomObject]@{
                File   = $file.Name
                Name   = $pipelineName
                Status = "Failed: $errMsg"
                Id     = "-"
                Url    = "-"
            })
        }
    }
}

# ── Summary ───────────────────────────────────────────────────
Write-Host "`n===== Summary =====" -ForegroundColor Cyan
$results | Format-Table -AutoSize

$created = @($results | Where-Object Status -eq "Created").Count
$skipped = @($results | Where-Object Status -eq "AlreadyExists").Count
$failed  = @($results | Where-Object { $_.Status -like "Failed*" }).Count
$dryrun  = @($results | Where-Object Status -eq "DryRun").Count

Write-Host "Created: $created  |  Already existed: $skipped  |  Failed: $failed  |  DryRun: $dryrun`n" -ForegroundColor Cyan
