# licenses

[licenses](https://github.com/qlik-trial/licenses) is the service responsible for the licenses resource (and `/v1/licenses`).

## Introduction

This chart bootstraps a licenses deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install --name my-release qlik/licenses
```

The command deploys licenses on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the licenses chart and their default values.

| Parameter                    | Description                                                                                            | Default                                                                                |
| ---------------------------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| `global.imageRegistry`       | The global image registry (overrides default `imagesRegistry`)                                         | `nil`                                                                                  |
| `imageRegistry`              | The default registry where the repository is pulled from.                                              | `qliktech-docker.jfrog.io`                                                             |
| `image.repository`           | image                                                                                                  | `licenses`                                                                             |
| `image.tag`                  | image version                                                                                          | `3.21.0`                                                                               |
| `image.pullPolicy`           | image pull policy                                                                                      | `Always` if `image.tag` is `latest`, else `IfNotPresent`                               |
| `imagePullSecrets`           | A list of secret names for accessing private image registries                                          | `[{name: "artifactory-docker-secret"}]`                                                |
| `replicaCount`               | Number of licenses replicas                                                                            | `1`                                                                                    |
| `podAnnotations`             | Annotations to be added to the pods                                                                    | `{}`                                                                                   |
| `service.type`               | Service type                                                                                           | `ClusterIP`                                                                            |
| `service.port`               | licenses listen port                                                                                   | `9200`                                                                                 |
| `ingress.annotations`        | additional ingress annotations                                                                         | `[]`                                                                                   |
| `ingress.class`              | the `kubernetes.io/ingress.class` to use                                                               | `nginx`                                                                                |
| `ingress.authURL`            | The URL to use for nginx's `auth-url` configuration to authenticate `/api` requests                    | `http://{.Release.Name}-edge-auth.{.Release.Namespace}.svc.cluster.local:8080/v1/auth` |
| `ingress.annotations`        | Additional Ingress annotations                                                                         | `[]`                                                                                   |
| `proxy.uri`                  | The URI to the proxy (scheme://host:port) if present                                                   | `nil`                                                                                  |
| `proxy.authMode`             | The tunneling proxy authentication mode, empty implies no authentication. Available modes: basic\|ntlm  | `nil`                                                                                  |
| `proxy.user`                 | The tunneling proxy user                                                                               | `nil`                                                                                  |
| `proxy.password`             | The tunneling proxy password                                                                           | `nil`                                                                                  |
| `proxy.domain`               | The tunneling proxy NTLM domain (only used with NTLM authentication mode)                              | `nil`                                                                                  |
| `metrics.prometheus.enabled` | whether prometheus metrics are enabled                                                                 | `true`                                                                                 |
| `mongodb.enabled`            | Enable MongoDB as a chart dependency                                                                   | `true`                                                                                 |
| `mongodb.image.tag`          | MongoDB image tag                                                                                      | `3.6.6-debian-9`                                                                       |
| `mongodb.usePassword`        | Enable password authentication                                                                         | `false`                                                                                |
| `mongodb.uri`                | If the MongoDB chart isn't used, specify the URI path to mongo                                         |                                                                                        |
| `mongodb.uriSecretName`      | name of secret to mount for mongo URI. The secret must have the `mongodb-uri` key                      | `{release.Name}-mongoconfig`                                                           |
| `jwks.uri`                   | URI where the JWKS to validate JWTs is located                                                         | `http://{.Release.Name}-keys:8080/v1/keys/qlik.api.internal`                           |
| `features.uri`               | URI for features resource                                                                              | `http://{.Release.Name}-feature-flags:8080/v1/features`                                |
| `features.cache.enabled`     | If true, enable the Feature Flags cache                                                                | false                                                                                  |
| `serial.number`              | License serial number                                                                                  | not set                                                                                |
| `control.number`             | License control number                                                                                 | not set                                                                                |
| `license.key`                | Signed license key                                                                                     | not set                                                                                |
| `tenant.id`                  | Tenant ID for the license if specified                                                                 | not set                                                                                |
| `log.level`                  | Log level: `all`/`debug`/`warn`/`error`/`none`/`info`                                                  | `info` when not set                                                                    |
| `testmode.enabled`           | Test mode                                                                                              | not set                                                                                |
| `qcs.enabled`                | Running in Cloud Services                                                                              | false                                                                                  |
| `pds.enabled`                | Enables PDS                                                                                            | true                                                                                   |
| `pds.uri`                    | URI for policy decision service                                                                        | `http://{.Release.Name}-policy-decisions:5080`                                         |
| `tokenAuth.enabled`          | Enables creation of auth token                                                                         | false                                                                                  |
| `tokenAuth.privateKey`       | Private key used to sign auth token                                                                    | a default token                                                                        |
| `tokenAuth.kid`              | Key ID corresponding to `tokenAuth.privateKey`                                                         | key ID to default token                                                                |
| `tokenAuth.url`              | URL to exchange private token to internal token                                                        | `http://{.Release.Name}-edge-auth:8080/v1/internal-tokens`                             |
| `nats.enabled`               | Enables sending events to NATS                                                                         | false                                                                                  |
| `nats.podLabel.key`          | Pod label key required to allow communication with NATS                                                | `{.Release.Name}-nats-client`                                                          |
| `nats.podLabel.value`        | Pod label value required to allow communication with NATS                                              | true                                                                                   |
| `nats.servers`               | Comma seperated list of NATS servers                                                                   | `nats://{ .Release.Name }-nats-client:4222`                                            |
| `nats.connectAttempts`       | Number of connection attempts to create initial NATS connection                                        | 3                                                                                      |
| `nats.clusterName`           | NATS Cluster Name                                                                                      | not set                                                                                |
| `nats.group`                 | NATS Group                                                                                             | not set                                                                                |
| `tracing.enabled`            | Enable tracing                                                                                         | false                                                                                  |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
helm install --name my-release -f values.yaml qlik/licenses
```

> **Tip**: You can use the default [values.yaml](values.yaml)
