# Azure DevOps Pipeline Reference Library

A comprehensive collection of **100 Azure DevOps YAML pipelines** covering every concept
from the simplest "Hello World" to enterprise-grade, highly complex orchestration patterns.

---

## Structure

```
pipelines/
├── 01-100 pipeline YAML files (see table below)
└── templates/
    ├── steps-build.yml           Reusable step template
    ├── job-deploy.yml            Reusable job template
    ├── stage-build.yml           Reusable stage template
    ├── base-governance.yml       Extends governance template
    └── vars-environments.yml     Environment variable template
```

---

## Complexity Tiers

| Tier | Pipelines | Description |
|------|-----------|-------------|
| Simple | 01–20 | Core concepts – triggers, variables, templates, conditions, matrix |
| Simple/Medium | 21–30 | Language-specific CI – Node.js, Python, Java, Docker, Terraform |
| Medium | 31–50 | Advanced integrations – SonarQube, K8s, Helm, DB migrations, security |
| Complex | 51–70 | Blue-green, microservices, GitOps, ML, chaos, DAST, iOS, compliance |
| Highly Complex | 71–100 | Enterprise: multi-tenant, platform engineering, SLSA, multi-cloud, IoT |

---

## Full Pipeline Index

### Simple (01–20)

| # | File | Topic | Key Concepts |
|---|------|-------|-------------|
| 01 | [01-basic-ci.yml](01-basic-ci.yml) | Basic CI | trigger, pool, steps, script, PublishTestResults |
| 02 | [02-multi-stage.yml](02-multi-stage.yml) | Multi-Stage Pipeline | stages, dependsOn, output variables, stageDependencies |
| 03 | [03-variables.yml](03-variables.yml) | Variables | inline, groups, secrets, ##vso, counter |
| 04 | [04-templates.yml](04-templates.yml) | Templates | step/job/stage templates, parameters, stepList, each |
| 05 | [05-conditions.yml](05-conditions.yml) | Conditions | succeeded/failed/always/canceled, eq/ne/and/or/in |
| 06 | [06-matrix-strategy.yml](06-matrix-strategy.yml) | Matrix Strategy | cross-platform, multi-TFM, maxParallel |
| 07 | [07-artifacts-caching.yml](07-artifacts-caching.yml) | Artifacts & Caching | PublishPipelineArtifact, Cache@2 |
| 08 | [08-deployment-environments.yml](08-deployment-environments.yml) | Deployment Jobs | runOnce, rolling, canary, lifecycle hooks |
| 09 | [09-parameters.yml](09-parameters.yml) | Parameters | all types – string, bool, number, object, stepList |
| 10 | [10-triggers.yml](10-triggers.yml) | All Triggers | CI/PR/schedule/pipeline resource/tag/batch |
| 11 | [11-container-jobs.yml](11-container-jobs.yml) | Container Jobs | job/step containers, service sidecars |
| 12 | [12-resources.yml](12-resources.yml) | Resources | repos/containers/pipelines/packages/webhooks |
| 13 | [13-hello-world.yml](13-hello-world.yml) | Hello World | absolute minimum pipeline |
| 14 | [14-windows-powershell.yml](14-windows-powershell.yml) | Windows/PowerShell | PowerShell@2, pwsh, CMD |
| 15 | [15-macos-agent.yml](15-macos-agent.yml) | macOS Agent | macOS-latest, Homebrew, Xcode |
| 16 | [16-bash-advanced.yml](16-bash-advanced.yml) | Advanced Bash | strict mode, heredoc, exit codes, workingDirectory |
| 17 | [17-timeout-retry.yml](17-timeout-retry.yml) | Timeout & Retry | timeoutInMinutes, retryCountOnTaskFailure |
| 18 | [18-file-operations.yml](18-file-operations.yml) | File Operations | CopyFiles, ArchiveFiles, ExtractFiles, DeleteFiles |
| 19 | [19-agentless-approval.yml](19-agentless-approval.yml) | Agentless Jobs | ManualValidation@0, InvokeRestAPI@1, pool:server |
| 20 | [20-workspace-clean.yml](20-workspace-clean.yml) | Workspace Management | workspace.clean, fetchDepth, lfs, submodules |

### Simple/Medium (21–30)

| # | File | Topic | Key Concepts |
|---|------|-------|-------------|
| 21 | [21-nodejs-full.yml](21-nodejs-full.yml) | Node.js Full CI | NodeTool, npm ci, ESLint, Jest, coverage, audit |
| 22 | [22-python-full.yml](22-python-full.yml) | Python Full CI | pip cache, black, flake8, mypy, bandit, pytest, wheel |
| 23 | [23-java-maven.yml](23-java-maven.yml) | Java Maven | JavaToolInstaller, Maven@4, JaCoCo, Surefire |
| 24 | [24-docker-build-push.yml](24-docker-build-push.yml) | Docker Build & Push | buildAndPush, ACR, Trivy scan |
| 25 | [25-azure-cli-bicep.yml](25-azure-cli-bicep.yml) | Azure CLI + Bicep | AzureCLI@2, what-if, deploy, tag resources |
| 26 | [26-terraform.yml](26-terraform.yml) | Terraform | TerraformTaskV4, init/validate/plan/apply/destroy |
| 27 | [27-nuget-publish.yml](27-nuget-publish.yml) | NuGet Publish | pack, version, push Azure Artifacts, symbols |
| 28 | [28-webapp-slot-swap.yml](28-webapp-slot-swap.yml) | Web App Slot Swap | AzureWebApp@1, slot deploy, swap, smoke test |
| 29 | [29-fan-out-fan-in.yml](29-fan-out-fan-in.yml) | Fan-Out / Fan-In | parallel jobs, aggregator, multiple dependsOn |
| 30 | [30-semantic-versioning.yml](30-semantic-versioning.yml) | Semantic Versioning | GitVersion, SemVer, AssemblyInfo, git tag |

### Medium (31–50)

| # | File | Topic | Key Concepts |
|---|------|-------|-------------|
| 31 | [31-sonarqube.yml](31-sonarqube.yml) | SonarCloud | SonarCloudPrepare/Analyze/Publish, quality gate |
| 32 | [32-kubernetes-deploy.yml](32-kubernetes-deploy.yml) | AKS Deploy | KubernetesManifest@1, imagePullSecret, rollout |
| 33 | [33-helm-deploy.yml](33-helm-deploy.yml) | Helm Deploy | lint, template, package, upgrade, OCI push |
| 34 | [34-database-migrations.yml](34-database-migrations.yml) | DB Migrations | EF Core, Flyway, SQL/Postgres service containers |
| 35 | [35-extends-governance.yml](35-extends-governance.yml) | Extends Governance | extends keyword, required templates, policy |
| 36 | [36-load-testing.yml](36-load-testing.yml) | Load Testing | k6, JMeter, thresholds, HTML reports |
| 37 | [37-azure-functions.yml](37-azure-functions.yml) | Azure Functions | AzureFunctionApp@2, slot swap |
| 38 | [38-monorepo-path-filter.yml](38-monorepo-path-filter.yml) | Monorepo | git diff detection, selective builds, path filters |
| 39 | [39-cross-project-artifacts.yml](39-cross-project-artifacts.yml) | Cross-Project | pipeline resources, cross-project artifacts |
| 40 | [40-notifications.yml](40-notifications.yml) | Notifications | Teams Adaptive Card, Slack, webhooks |
| 41 | [41-owasp-dependency-check.yml](41-owasp-dependency-check.yml) | SCA / SBOM | OWASP Dependency-Check, Snyk, CycloneDX |
| 42 | [42-dast-zap.yml](42-dast-zap.yml) | DAST | OWASP ZAP baseline + API scan |
| 43 | [43-go-crosscompile.yml](43-go-crosscompile.yml) | Go Cross-Compile | go vet, golangci-lint, 5-platform matrix |
| 44 | [44-rust-build.yml](44-rust-build.yml) | Rust | cargo fmt/clippy/test/tarpaulin, cross-compile |
| 45 | [45-android-build.yml](45-android-build.yml) | Android | Gradle, keystore signing, AndroidSigning@3 |
| 46 | [46-iac-compliance.yml](46-iac-compliance.yml) | IaC Compliance | Checkov, tfsec, kube-score, SARIF |
| 47 | [47-self-hosted-agent.yml](47-self-hosted-agent.yml) | Self-Hosted Agents | pool name, demands, capabilities |
| 48 | [48-variable-template-envs.yml](48-variable-template-envs.yml) | Variable Templates | env-specific vars via if/elseif/else |
| 49 | [49-multi-env-promotion.yml](49-multi-env-promotion.yml) | Multi-Env Promotion | dev→staging→prod, rollback job |
| 50 | [50-java-gradle.yml](50-java-gradle.yml) | Java Gradle | multi-module, JaCoCo merge, Gradle cache |

### Complex (51–70)

| # | File | Topic | Key Concepts |
|---|------|-------|-------------|
| 51 | [51-blue-green.yml](51-blue-green.yml) | Blue-Green Deploy | AKS service patch, traffic switch, auto-rollback |
| 52 | [52-microservices.yml](52-microservices.yml) | Microservices | each-generated parallel builds, sequential deploys |
| 53 | [53-gitops-argocd.yml](53-gitops-argocd.yml) | GitOps / ArgoCD | image promotion via git commit, ArgoCD sync |
| 54 | [54-ml-training.yml](54-ml-training.yml) | Azure ML | training job, model registration, endpoint |
| 55 | [55-multi-region.yml](55-multi-region.yml) | Multi-Region | parallel deploys, Traffic Manager weight |
| 56 | [56-container-full-lifecycle.yml](56-container-full-lifecycle.yml) | Container Lifecycle | BuildKit, Trivy, Grype, Syft, Cosign |
| 57 | [57-orchestrator.yml](57-orchestrator.yml) | Orchestrator | ADO REST API to queue downstream pipelines |
| 58 | [58-iac-full-lifecycle.yml](58-iac-full-lifecycle.yml) | IaC Lifecycle | Bicep + ARM TTK + Pester + drift detection |
| 59 | [59-data-engineering.yml](59-data-engineering.yml) | Data Engineering | ADF deploy, Databricks, data quality |
| 60 | [60-full-security.yml](60-full-security.yml) | Full Security | Gitleaks + Semgrep + Grype + ZAP + gate |
| 61 | [61-ios-xcode.yml](61-ios-xcode.yml) | iOS Xcode | P12/provisioning, IPA build, TestFlight |
| 62 | [62-integration-service-bus.yml](62-integration-service-bus.yml) | Service Bus | ephemeral SB namespace, integration tests |
| 63 | [63-feature-flags.yml](63-feature-flags.yml) | Feature Flags | App Config, % rollout, monitoring, promote |
| 64 | [64-compliance-audit.yml](64-compliance-audit.yml) | Compliance | Azure Policy, license check, SBOM, audit |
| 65 | [65-dotnet-maui.yml](65-dotnet-maui.yml) | .NET MAUI | Android/Windows/macOS, store upload |
| 66 | [66-chaos-engineering.yml](66-chaos-engineering.yml) | Chaos Engineering | Azure Chaos Studio, hypothesis, recovery |
| 67 | [67-release-notes.yml](67-release-notes.yml) | Release Notes | conventional-changelog, JIRA, GitHub Release |
| 68 | [68-scheduled-cleanup.yml](68-scheduled-cleanup.yml) | Scheduled Cleanup | ACR pruning, stale branch report, dry-run |
| 69 | [69-nodejs-custom-task.yml](69-nodejs-custom-task.yml) | Custom Task | ##vso logging commands, setvariable, build tags |
| 70 | [70-enterprise-approval.yml](70-enterprise-approval.yml) | Enterprise Approval | ServiceNow ITSM, business hours gate, multi-level |

### Highly Complex (71–100)

| # | File | Topic | Key Concepts |
|---|------|-------|-------------|
| 71 | [71-enterprise-full.yml](71-enterprise-full.yml) | Enterprise Full | 7-phase: SAST+SCA+build+test+container+deploy+notify |
| 72 | [72-multi-tenant-saas.yml](72-multi-tenant-saas.yml) | Multi-Tenant SaaS | each-generated per-tenant deploy, migration |
| 73 | [73-aks-advanced.yml](73-aks-advanced.yml) | AKS Advanced | HPA, PDB, NetworkPolicy, KEDA, resource quotas |
| 74 | [74-event-driven-architecture.yml](74-event-driven-architecture.yml) | Event-Driven | Event Grid, Service Bus, Functions, dead-letter |
| 75 | [75-observability-stack.yml](75-observability-stack.yml) | Observability | OpenTelemetry, Prometheus, Grafana, SLO alerts |
| 76 | [76-multi-cloud-deploy.yml](76-multi-cloud-deploy.yml) | Multi-Cloud | Azure + AWS parallel deploy, Traffic Manager DNS |
| 77 | [77-dapr-microservices.yml](77-dapr-microservices.yml) | Dapr Mesh | Dapr components, pub/sub, bindings, resiliency |
| 78 | [78-pipeline-generator.yml](78-pipeline-generator.yml) | Pipeline Generator | Dynamic YAML gen, ADO REST API register/queue |
| 79 | [79-database-dr-validation.yml](79-database-dr-validation.yml) | DB DR Validation | PITR restore, RPO/RTO measurement, integrity checks |
| 80 | [80-hotfix-emergency.yml](80-hotfix-emergency.yml) | Hotfix Fast-Path | Expedited gate, PagerDuty, auto rollback, retrospective |
| 81 | [81-ml-champion-challenger.yml](81-ml-champion-challenger.yml) | ML Champion/Challenger | AzureML A/B test, metric-based promotion |
| 82 | [82-kubernetes-operator.yml](82-kubernetes-operator.yml) | K8s Operator | CRD lifecycle, RBAC, webhook certs, e2e tests |
| 83 | [83-container-apps-blue-green.yml](83-container-apps-blue-green.yml) | ACA Blue-Green | Container Apps revisions, traffic split, rollback |
| 84 | [84-apim-deploy.yml](84-apim-deploy.yml) | APIM Deploy | Policy XML, OpenAPI import, named values, products |
| 85 | [85-static-web-apps.yml](85-static-web-apps.yml) | Static Web Apps | SWA deploy, PR previews, CDN purge, Lighthouse CI |
| 86 | [86-multi-region-active-active.yml](86-multi-region-active-active.yml) | Active-Active | Front Door, per-region zero-downtime, WAF validation |
| 87 | [87-platform-engineering.yml](87-platform-engineering.yml) | Platform Engineering | Golden path templates, Backstage catalog, OCI push |
| 88 | [88-power-platform-alm.yml](88-power-platform-alm.yml) | Power Platform ALM | pac CLI, MTAR export/import, solution checker |
| 89 | [89-playwright-synthetic.yml](89-playwright-synthetic.yml) | Playwright Synthetic | Multi-browser matrix, scheduled monitor, App Insights |
| 90 | [90-cost-optimization.yml](90-cost-optimization.yml) | Cost Optimization | Azure Advisor, orphaned resources, budget alerts |
| 91 | [91-iot-edge-deploy.yml](91-iot-edge-deploy.yml) | IoT Edge | Module build, deployment manifest, device groups |
| 92 | [92-sap-btp-deploy.yml](92-sap-btp-deploy.yml) | SAP BTP | Cloud Foundry CF CLI, MTA build, iFlow deploy |
| 93 | [93-gaming-backend.yml](93-gaming-backend.yml) | Gaming Backend | Unity CI, PlayFab catalog, Agones Fleet, Addressables |
| 94 | [94-zero-trust-security.yml](94-zero-trust-security.yml) | Zero-Trust Security | Entra ID audit, RBAC least privilege, NSG scan |
| 95 | [95-data-platform-lakehouse.yml](95-data-platform-lakehouse.yml) | Data Lakehouse | Synapse pipelines, Databricks jobs, Great Expectations |
| 96 | [96-gitops-drift-detection.yml](96-gitops-drift-detection.yml) | GitOps Drift | Flux v2, kubeconform, OPA, auto-reconcile, alert |
| 97 | [97-slsa-supply-chain.yml](97-slsa-supply-chain.yml) | SLSA Supply Chain | Cosign sign, SBOM, Grype VEX, Rekor attestation |
| 98 | [98-gitflow-release-automation.yml](98-gitflow-release-automation.yml) | GitFlow Release | Auto version bump, changelog, NuGet/NPM publish |
| 99 | [99-compliance-audit-report.yml](99-compliance-audit-report.yml) | Compliance Audit | SOC2/ISO27001, RBAC, encryption, patch compliance |
| 100 | [100-ultimate-reference.yml](100-ultimate-reference.yml) | **Ultimate Reference** | **Every ADO pipeline concept in one comprehensive file** |

---

## Templates

| File | Purpose |
|------|---------|
| [templates/steps-build.yml](templates/steps-build.yml) | Reusable step template – restore, build, test, publish |
| [templates/job-deploy.yml](templates/job-deploy.yml) | Reusable job template with stepList injection |
| [templates/stage-build.yml](templates/stage-build.yml) | Reusable stage template wrapping the step template |
| [templates/base-governance.yml](templates/base-governance.yml) | Extends base – mandatory security, audit, compliance |
| [templates/vars-environments.yml](templates/vars-environments.yml) | Variable template – env-specific compile-time vars |

---

## Key Concepts Quick-Reference

| Concept | See Pipelines |
|---------|--------------|
| `extends` / required templates | 35, 71, 100 |
| `${{ each }}` dynamic generation | 52, 72, 77, 78, 100 |
| Output variables across stages | 02, 55, 83, 86, 100 |
| `pool: server` agentless jobs | 19, 70 |
| `strategy: canary` | 08, 51, 100 |
| `strategy: rolling` | 08, 100 |
| Service containers (sidecars) | 11, 34, 62, 89 |
| OIDC / Workload Identity Federation | 94 |
| SLSA provenance + Cosign signing | 56, 97 |
| ADO REST API usage | 57, 78, 98 |
| `schedules` (cron triggers) | 68, 79, 89, 90, 96, 99 |
| Multi-cloud (Azure + AWS) | 76 |
| GitOps / ArgoCD / Flux | 53, 96 |
| Power Platform (pac CLI) | 88 |
| SAP BTP / Cloud Foundry | 92 |
| Unity / Gaming backend | 93 |
| ML champion/challenger | 54, 81 |
| Chaos Engineering | 66 |
| Cost optimization | 90 |
| `lockBehavior: sequential` | 100 |

---

## Getting Started

1. Browse the index above and open any `.yml` file
2. Each file has a detailed header comment explaining all concepts covered
3. Files are self-contained — copy-paste the sections you need
4. Adapt variable group names, service connections, and resource names to your environment
5. Start at [01-basic-ci.yml](01-basic-ci.yml) (simplest) or [100-ultimate-reference.yml](100-ultimate-reference.yml) (everything at once)

---

*100 pipelines · 5 templates · Comprehensive ADO YAML reference library*
