# licenses

[licenses](https://github.com/qlik-trial/licenses) is the service responsible for the licenses resource (and `/v1/licenses`).

## Introduction

This chart bootstraps a licenses deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Installing the Chart

To install the chart with the release name `licenses`:

```console
helm install --name licenses qlik/licenses
```

The command deploys licenses on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `licenses` deployment:

```console
helm delete licenses
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the licenses chart and their default values.

| Parameter                    | Description                                                                                            | Default                                                                                |
| ---------------------------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| `global.imageRegistry`       | The global image registry (overrides default `imagesRegistry`)                                         | `nil`                                                                                  |
| `imageRegistry`              | The default registry where the repository is pulled from.                                              | `qliktech-docker.jfrog.io`                                                             |
| `image.repository`           | image                                                                                                  | `licenses`                                                                             |
| `image.tag`                  | image version                                                                                          | `3.29.0`                                                                               |
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
| `proxyUri`                   | The URI to the proxy (scheme://host:port) if present                                                   | `nil`                                                                                  |
| `proxyAuthMode`              | The tunneling proxy authentication mode, empty implies no authentication. Available modes: basic\|ntlm | `nil`                                                                                  |
| `proxyUser`                  | The tunneling proxy user                                                                               | `nil`                                                                                  |
| `proxyPassword`              | The tunneling proxy password                                                                           | `nil`                                                                                  |
| `proxyDomain`                | The tunneling proxy NTLM domain (only used with NTLM authentication mode)                              | `nil`                                                                                  |
| `metrics.prometheus.enabled` | whether prometheus metrics are enabled                                                                 | `true`                                                                                 |
| `mongodb.enabled`            | Enable MongoDB as a chart dependency                                                                   | `true`                                                                                 |
| `mongodb.image.tag`          | MongoDB image tag                                                                                      | `3.6.6-debian-9`                                                                       |
| `mongodb.usePassword`        | Enable password authentication                                                                         | `false`                                                                                |
| `mongodbUri`                 | If the MongoDB chart isn't used, specify the URI path to mongo                                         |                                                                                        |
| `mongodb.uriSecretName`      | name of secret to mount for mongo URI. The secret must have the `mongodb-uri` key                      | `{release.Name}-mongoconfig`                                                           |
| `keysUri`                    | URI where the JWKS to validate JWTs is located                                                         | `http://{.Release.Name}-keys:8080/v1/keys/qlik.api.internal`                           |
| `featureFlagsUri`            | URI for features resource                                                                              | `http://{.Release.Name}-feature-flags:8080/v1/features`                                |
| `featureFlagsCache`          | If true, enable the Feature Flags cache                                                                | false                                                                                  |
| `licenseKey`                 | Signed license key                                                                                     | not set                                                                                |
| `tenantId`                   | Tenant ID for the license if specified                                                                 | not set                                                                                |
| `logLevel`                   | Log level: `all`/`debug`/`warn`/`error`/`none`/`info`                                                  | `info` when not set                                                                    |
| `testmodeEnabled`            | Test mode                                                                                              | not set                                                                                |
| `isQcs`                      | Running in Cloud Services                                                                              | false                                                                                  |
| `policyDecisionsEnabled`     | Enables PDS                                                                                            | true                                                                                   |
| `policyDecisionsUri`         | URI for policy decision service                                                                        | `http://{.Release.Name}-policy-decisions:5080`                                         |
| `tokenAuthEnabled`           | Enables creation of auth token                                                                         | false                                                                                  |
| `tokenAuthPrivateKey`        | Private key used to sign auth token                                                                    | a default token                                                                        |
| `tokenAuthPrivateKeyId`      | Key ID corresponding to `tokenAuth.privateKey`                                                         | key ID to default token                                                                |
| `tokenAuthUrl`               | URL to exchange private token to internal token                                                        | `http://{.Release.Name}-edge-auth:8080/v1/internal-tokens`                             |
| `natsEnabled`                | Enables sending events to NATS                                                                         | false                                                                                  |
| `nats.podLabel.key`          | Pod label key required to allow communication with NATS                                                | `{.Release.Name}-nats-client`                                                          |
| `nats.podLabel.value`        | Pod label value required to allow communication with NATS                                              | true                                                                                   |
| `natsUri`                    | Comma seperated list of NATS servers                                                                   | `nats://{ .Release.Name }-nats-client:4222`                                            |
| `natsConnectAttempts`        | Number of connection attempts to create initial NATS connection                                        | 3                                                                                      |
| `natsStreamingClusterId`     | NATS Cluster Name                                                                                      | not set                                                                                |
| `nats.group`                 | NATS Group                                                                                             | not set                                                                                |
| `tracingEnabled`             | Enable tracing                                                                                         | false                                                                                  |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
helm install --name licenses -f values.yaml qlik/licenses
```

> **Tip**: You can use the default [values.yaml](values.yaml)
