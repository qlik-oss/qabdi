# bdi-mc

This is the management console of BDI

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install --name my-release .
```

The command deploys bdi management console on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the chart and their default values.

| Parameter               | Description                           | Default                                                    |
| ----------------------- | ----------------------------------    | ---------------------------------------------------------- |
| `image.registry` | image registry | `qliktech-docker.jfrog.io`|
| `image.repository` | image name | `bdi-mc`|
| `image.tag` | image version | `1.2.0` |
| `image.pullPolicy` | image pull policy | `Always` if `imageTag` is `latest`, else `IfNotPresent` |
| `image.privileged` | Enable `privileged` mode for all pods | `false` |
| `imagePullSecrets` | A list of secret names for accessing private image registries | `[{name: "artifactory-docker-secret"}]` |
| `replicaCount` | Number of management console replicas | `1` |
| `resources` | Management console resource limits | `{}` |
| `additionalAffinities` | Additional affinities to apply to management console pods. | `{}` |
| `annotations` | Management console deployment annotations | `{}` |
| `nodeSelector` | Node selector for the management console pods | `{}` |
| `tolerations` | Tolerations for the management console pods | `{}` |
| `service.type` | Management console service type | `ClusterIP` |
| `ingress.enabled` | Enable Management console Ingress | `true` |
| `ingress.annotations` | Management console Ingress annotations | `{}` |
| `ingress.hosts` | Management console Ingress Hostnames | `[]` |
| `ingress.tls` | Management console Ingress TLS configuration | `[]` |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml .
```

> **Tip**: You can use the default [values.yaml](values.yaml)
