# message-delivery-monitor

[message-delivery-monitor](https://github.com/qlik-trial/message-delivery-monitor) is responsible for measuring delivery and latency of NATS/NATS-Streaming.

## Introduction

This chart bootstraps a message-delivery-monitor deployment on a [Kubernetes](http://kubernetes.io) cluster using the
[Helm](https://helm.sh) package manager.

## Installing the chart

To install the chart with the release name `message-delivery-monitor`:

```console
helm install --name message-delivery-monitor qlik/message-delivery-monitor
```

The command deploys message-delivery-monitor on the Kubernetes cluster in the default configuration.
The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `message-delivery-monitor` deployment:

```console
helm delete message-delivery-monitor
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the data-engineering-exporter chart and their default values.

| Parameter                        | Description                                                        | Default                                               |
| -------------------------------- | ------------------------------------------------------------------ | ------------------------------------------------------|
| `image.registry`                 | Image registry                                                     | `qliktech-docker.jfrog.io`                            |
| `image.repository`               | Image repository                                                   | `message-delivery-monitor`                            |
| `image.tag`                      | Image version                                                      | `0.1.2`                                               |
| `image.pullPolicy`               | Image pull policy<sup>\*</sup>                                     | `IfNotPresent`                                        |
| `imagePullSecrets`               | A list of secret names for accessing private image registries      | `[{name: "artifactory-docker-secret"}]`               |
| `logLevel`                       | Level of logging                                                   | `info`                                                |
| `nats.server`                    | Nats server address                                                | `nats://{{ .Release.Name }}-nats-client:4222`         |
| `nats.auth.enabled`              | Enabled authentication to NATS                                     | `false`                                               |
| `nats.auth.user`                 | Username to authenticate to NATS                                   | `nil`                                                 |
| `nats.auth.password`             | Password to authenticate to NATS                                   | `nil`                                                 |
| `nats.auth.secretName`           | Read user/passowrd from a this K8s secret with this name           | `{{ .Release.Name }}-message-delivery-monitor-secret` |
| `nats.auth.secretClientUser`     | Key to read from a K8s secret key to retrieve a username           | `"client-user"`                                       |
| `nats.auth.secretClientPassword` | Key to read from a K8s secret key to retrieve a password           | `"client-password"`                                   |
| `stan.clusterID`                 | NATS Streaming cluster ID                                          | `{{ .Release.Name }}-nats-streaming-cluster`          |
| `stan.monitorChannel`            | NATS Streaming channel to monitor on                               | `monitor-channel`                                     |
| `resources`                      | CPU/Memory resource requests/limits                                | {}                                                    |
| `service.type`                   | Service type                                                       | `ClusterIP`                                           |
| `service.port`                   | message-delivery-monitor listen port                               | `8080`                                                |
| `metrics.prometheus.enabled`     | Whether Prometheus metrics are enabled                             | `true`                                                |

(\*) If setting `image.tag` to `latest`, it is recommended to change `image.pullPolicy` to `Always`

### Setting Parameters

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart.
For example,

```console
helm install --name message-delivery-monitor -f values.yaml qlik/message-delivery-monitor
```

> **Tip**: You can use the default [values.yaml](values.yaml)
