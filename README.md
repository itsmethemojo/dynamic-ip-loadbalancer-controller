# dynamic-ip-loadbalancer-controller

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

a lightweigt kubernetes component for keeping the external-ip of your loadbalancer services up-to-date when running a kubernetes cluster at home behind a router with a dynamic ip

# additional links

* [Chart on Artifact HUB](https://artifacthub.io/packages/helm/itsmethemojo/dynamic-ip-loadbalancer-controller)

## update docs

```
docker run --rm -v $(pwd):/app -w/app jnorwood/helm-docs -t helm-docs-template.gotmpl
```

## Source Code

* <https://github.com/itsmethemojo/dynamic-ip-loadbalancer-controller>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://itsmethemojo.github.io/helm-charts/ | app(basic-web-app) | 1.2.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.command[0] | string | `"bash"` |  |
| app.command[1] | string | `"/scripts/update_ip.sh"` |  |
| app.env.DETERMINE_EXERNAL_IP_INTERVALL | string | `"450"` | intervall the current external ip is fetched via https://ifconfig.me/ip |
| app.env.KUBECTL_BINARY_ARCH | string | `"amd64"` | architecture kubectl binary to be downloaded when starting the container, https://dl.k8s.io/release/v$KUBECTL_BINARY_VERSION/bin/linux/$KUBECTL_BINARY_ARCH/kubectl |
| app.env.KUBECTL_BINARY_VERSION | string | `"1.33.3"` | version of kubectl binary to be downloaded when sarting the container, https://dl.k8s.io/release/v$KUBECTL_BINARY_VERSION/bin/linux/$KUBECTL_BINARY_ARCH/kubectl |
| app.extraVolumeMounts[0].mountPath | string | `"/scripts"` |  |
| app.extraVolumeMounts[0].name | string | `"scripts"` |  |
| app.extraVolumes[0].configMap.name | string | `"external-ip-updater"` |  |
| app.extraVolumes[0].name | string | `"scripts"` |  |
| app.image.repository | string | `"buildpack-deps"` |  |
| app.image.tag | string | `"curl"` |  |
| app.livenessProbe | string | `""` |  |
| app.readinessProbe | string | `""` |  |
| app.service.enabled | bool | `false` |  |
| app.serviceAccount.create | bool | `false` |  |
| app.serviceAccount.name | string | `"external-ip-updater"` |  |