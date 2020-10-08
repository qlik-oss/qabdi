# NATS

[NATS](https://nats.io/) is an open-source, cloud-native messaging system. It provides a lightweight server that is written in the Go programming language.

## TL;DR

```bash
$ helm install qlik/nats
```

## Introduction

This chart bootstraps a [NATS](https://github.com/bitnami/bitnami-docker-nats) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

Bitnami charts can be used with [Kubeapps](https://kubeapps.com/) for deployment and management of Helm Charts in clusters.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `nats`:

```bash
$ helm install --name nats qlik/nats
```

The command deploys NATS on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `nats` deployment:

```bash
$ helm delete nats --purge
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the NATS chart and their default values.

| Parameter                            | Description                                                                                  | Default                                                       |
| ------------------------------------ | -------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| `global.imageRegistry`               | Global Docker image registry                                                                 | `nil`                                                         |
| `image.registry`                     | NATS image registry                                                                          | `qliktech-docker.jfrog.io`                                    |
| `image.repository`                   | NATS Image name                                                                              | `qnatsd`                                                      |
| `image.tag`                          | NATS Image tag                                                                               | `0.3.2`                                                       |
| `image.pullPolicy`                   | Image pull policy                                                                            | `IfNotPresent`                                                |
| `image.pullSecrets`                  | Specify image pull secrets                                                                   | `artifactory-docker-secret`                                   |
| `auth.enabled`                       | Switch to enable/disable client authentication                                               | `false`                                                       |
| `auth.user`                          | Client authentication user                                                                   | `"delivery-monitor"`                                          |
| `auth.password`                      | Client authentication password                                                               | `password`                                                    |
| `auth.token`                         | Client authentication token                                                                  | `nil`                                                         |
| `auth.users`                         | Client authentication users                                                                  | `[]` See [Rotation](#how-to-rotate)                           |
| `auth.users[].user`                  | Client authentication user                                                                   | `"nats_client"`                                               |
| `auth.users[].password`              | Client authentication password                                                               | `T0pS3cr3t`                                                   |
| `clusterAuth.enabled`                | Switch to enable/disable cluster authentication                                              | `false`                                                        |
| `clusterAuth.user`                   | Cluster authentication user                                                                  | `nats_cluster`                                                |
| `clusterAuth.password`               | Cluster authentication password                                                              | `random alhpanumeric string (10)`                             |
| `clusterAuth.token`                  | Cluster authentication token                                                                 | `nil`                                                         |
| `debug.enabled`                      | Switch to enable/disable debug on logging                                                    | `false`                                                       |
| `debug.trace`                        | Switch to enable/disable trace debug level on logging                                        | `false`                                                       |
| `debug.logtime`                      | Switch to enable/disable logtime on logging                                                  | `false`                                                       |
| `maxConnections`                     | Max. number of client connections                                                            | `nil`                                                         |
| `maxControlLine`                     | Max. protocol control line                                                                   | `nil`                                                         |
| `maxPayload`                         | Max. payload                                                                                 | `nil`                                                         |
| `writeDeadline`                      | Duration the server can block on a socket write to a client                                  | `nil`                                                         |
| `replicaCount`                       | Number of NATS nodes                                                                         | `1`                                                           |
| `securityContext.enabled`            | Enable security context                                                                      | `true`                                                        |
| `securityContext.fsGroup`            | Group ID for the container                                                                   | `1001`                                                        |
| `securityContext.runAsUser`          | User ID for the container                                                                    | `1001`                                                        |
| `statefulset.updateStrategy`         | Statefulsets Update strategy                                                                 | `RollingUpdate`                                               |
| `statefulset.rollingUpdatePartition` | Partition for Rolling Update strategy                                                        | `nil`                                                         |
| `podLabels`                          | Additional labels to be added to pods                                                        | {}                                                            |
| `podAnnotations`                     | Annotations to be added to pods                                                              | {}                                                            |
| `nodeSelector`                       | Node labels for pod assignment                                                               | `nil`                                                         |
| `schedulerName`                      | Name of an alternate                                                                         | `nil`                                                         |
| `antiAffinity`                       | Anti-affinity for pod assignment                                                             | `soft`                                                        |
| `tolerations`                        | Toleration labels for pod assignment                                                         | `nil`                                                         |
| `resources`                          | CPU/Memory resource requests/limits                                                          | {}                                                            |
| `extraArgs`                          | Optional flags for NATS                                                                      | `See [values.yaml](./values.yaml)`                            |
| `livenessProbe.enabled`              | enable liveness probe                                                                        | `true`                                                        |
| `readinessProbe.enabled`             | enable readiness probe                                                                       | `true`                                                        |
| `livenessProbe.initialDelaySeconds`  | Delay before liveness probe is initiated                                                     | `30`                                                          |
| `livenessProbe.periodSeconds`        | How often to perform the probe                                                               | `10`                                                          |
| `livenessProbe.timeoutSeconds`       | When the probe times out                                                                     | `5`                                                           |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the probe to be considered successful after having failed. | `1`                                                           |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the probe to be considered failed after having succeeded.   | `6`                                                           |
| `readinessProbe.initialDelaySeconds` | Delay before readiness probe is initiated                                                    | `5`                                                           |
| `readinessProbe.periodSeconds`       | How often to perform the probe                                                               | `10`                                                          |
| `readinessProbe.timeoutSeconds`      | When the probe times out                                                                     | `5`                                                           |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the probe to be considered failed after having succeeded.   | `6`                                                           |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the probe to be considered successful after having failed. | `1`                                                           |
| `client.service.type`                | Kubernetes Service type (NATS client)                                                        | `ClusterIP`                                                   |
| `client.service.port`                | NATS client port                                                                             | `4222`                                                        |
| `client.service.nodePort`            | Port to bind to for NodePort service type (NATS client)                                      | `nil`                                                         |
| `client.service.annotations`         | Annotations for NATS client service                                                          | {}                                                            |
| `client.service.loadBalancerIP`      | loadBalancerIP if NATS client service type is `LoadBalancer`                                 | `nil`                                                         |
| `cluster.service.type`               | Kubernetes Service type (NATS cluster)                                                       | `ClusterIP`                                                   |
| `cluster.service.port`               | NATS cluster port                                                                            | `6222`                                                        |
| `cluster.service.nodePort`           | Port to bind to for NodePort service type (NATS cluster)                                     | `nil`                                                         |
| `cluster.service.annotations`        | Annotations for NATS cluster service                                                         | {}                                                            |
| `cluster.service.loadBalancerIP`     | loadBalancerIP if NATS cluster service type is `LoadBalancer`                                | `nil`                                                         |
| `cluster.noAdvertise`                | Do not advertise known cluster IPs to clients                                                | `false`                                                       |
| `monitoring.service.type`            | Kubernetes Service type (NATS monitoring)                                                    | `ClusterIP`                                                   |
| `monitoring.service.port`            | NATS monitoring port                                                                         | `8222`                                                        |
| `monitoring.service.nodePort`        | Port to bind to for NodePort service type (NATS monitoring)                                  | `nil`                                                         |
| `monitoring.service.annotations`     | Annotations for NATS monitoring service                                                      | {}                                                            |
| `monitoring.service.loadBalancerIP`  | loadBalancerIP if NATS monitoring service type is `LoadBalancer`                             | `nil`                                                         |
| `ingress.enabled`                    | Enable ingress controller resource                                                           | `false`                                                       |
| `ingress.hosts[0].name`              | Hostname for NATS monitoring                                                                 | `nats.local`                                                  |
| `ingress.hosts[0].path`              | Path within the url structure                                                                | `/`                                                           |
| `ingress.hosts[0].tls`               | Utilize TLS backend in ingress                                                               | `false`                                                       |
| `ingress.hosts[0].tlsSecret`         | TLS Secret (certificates)                                                                    | `nats.local-tls-secret`                                       |
| `ingress.hosts[0].annotations`       | Annotations for this host's ingress record                                                   | `[]`                                                          |
| `ingress.secrets[0].name`            | TLS Secret Name                                                                              | `nil`                                                         |
| `ingress.secrets[0].certificate`     | TLS Secret Certificate                                                                       | `nil`                                                         |
| `ingress.secrets[0].key`             | TLS Secret Key                                                                               | `nil`                                                         |
| `networkPolicy.enabled`              | Enable custom network policy for NATS messaging system                                       | `false`                                                       |
| `networkPolicy.allowExternal`        | Allow external connections                                                                   | `true`                                                        |
| `networkPolicy.keys.release`         | keys service release name for egress rules                                                   | `{{ .Release.Name }}`                                         |
| `metrics.enabled`                    | Enable Prometheus metrics via exporter side-car                                              | `false`                                                       |
| `metrics.image.registry`             | Prometheus metrics exporter image registry                                                   | `qliktech-docker.jfrog.io`                                    |
| `metrics.image.repository`           | Prometheus metrics exporter image name                                                       | `prometheus-nats-exporter`                                    |
| `metrics.image.tag`                  | Prometheus metrics exporter image tag                                                        | `0.3.0`                                                       |
| `metrics.image.pullPolicy`           | Prometheus metrics image pull policy                                                         | `IfNotPresent`                                                |
| `metrics.image.pullSecrets`          | Prometheus metrics image pull secrets                                                        | `artifactory-docker-secret`                                   |
| `metrics.port`                       | Prometheus metrics exporter port                                                             | `7777`                                                        |
| `metrics.podAnnotations`             | Prometheus metrics exporter annotations                                                      | `prometheus.io/scrape: "false"`, `prometheus.io/port: "7777"` |
| `metrics.resources`                  | Prometheus metrics exporter resource requests/limit                                          | {}                                                            |
| `sidecars`                           | Attach additional containers to the pod                                                      | `nil`                                                         |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,


```bash
$ helm install --name nats \
  --set auth.enabled=true,auth.user=my-user,auth.password=T0pS3cr3t \
    qlik/nats
```

The above command enables NATS client authentication with `my-user` as user and `T0pS3cr3t` as password credentials.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name nats -f values.yaml qlik/nats
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Sidecars

If you have a need for additional containers to run within the same pod as NATS (e.g. an additional metrics or logging exporter), you can do so via the `sidecars` config parameter. Simply define your container according to the Kubernetes container spec.

```yaml
sidecars:
- name: your-image-name
  image: your-image
  imagePullPolicy: Always
  ports:
  - name: portname
   containerPort: 1234
```

## Production settings and horizontal scaling

The [values-production.yaml](values-production.yaml) file consists a configuration to deploy a scalable and high-available NATS deployment for production environments. We recommend that you base your production configuration on this template and adjust the parameters appropriately.

```console
$ curl -O https://raw.githubusercontent.com/kubernetes/charts/master/qlik/nats/values-production.yaml
$ helm install --name nats -f ./values-production.yaml qlik/nats
```

To horizontally scale this chart, run the following command to scale the number of nodes in your NATS replica set.

```console
$ kubectl scale statefulset nats --replicas=3
```

## Upgrading

Backwards compatibility is not guaranteed unless you modify the labels used on the chart's deployments.
Use the workaround below to upgrade from versions previous to 1.0.0. The following example assumes that the release name is nats:

```console
$ kubectl delete statefulset nats --cascade=false

```

### Network Plugin to enable Network Policies in Kubernetes cluster

This chart include options to enable [Network policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) for the created
`nats` and `nats-streaming` clusters.

Network policies are implemented by the network plugin, so the Kubernetes cluster must be configured with a networking solution which supports NetworkPolicy -
simply creating the resource without a controller to implement it will have no effect.

For local development, please refer to [Setting Up a Minikube Cluster - Configuring Network Plugin to support Network Policies](https://github.com/qlik-trial/elastic-charts/blob/master/docs/prerequisites/minikube-cluster.md#configuring-network-plugin-to-support-network-policies)
for detailed instructions.

### Secrets

For deploying this chart to **stage**/**prod**, you need the following secrets written to **vault**.

*The passwords should not start with a number!*

| Secret                                                         | Key     | Purpose                             |
| -------------------------------------------------------------- | ------- | ----------------------------------- |
| `/secret/{environment}/messaging/{region}/natsClientPassword`  | `value` | password for client authentication  |
| `/secret/{environment}/messaging/{region}/natsClusterPassword` | `value` | password for cluster authentication |

## Connecting to NATS / NATS Streaming

### From the command line:
#### Port-forward NATS Client Service:
```sh
  > kubectl port-forward messaging-nats-0 4222
```
#### Connect via `telnet`:
```sh
  > telnet localhost 4222
```
#### Connect with no auth:
```sh
    CONNECT {}
```
#### Connect with auth:
```sh
    CONNECT {"user":"my-user","pass":"T0pS3cr3t"}
```
#### Subscribing to channel, publishing to a channel, and receiving the published message:
```sh
    SUB foo 1
    +OK
    PUB foo 11
    Hello World
    +OK
    MSG foo 1 11
    Hello World
```

### Using [go-nats](https://github.com/nats-io/go-nats/) and [go-nats-streaming](https://github.com/nats-io/go-nats-streaming) clients:
```golang
package main

import (
    "log"

    "github.com/nats-io/go-nats"
    "github.com/nats-io/go-nats-streaming"
)

func main() {
    nc, err := nats.Connect("nats://nats_client:asdf@localhost:4222")
    if err != nil {
        log.Fatal(err)
    }
    sc, err := stan.Connect("messaging-nats-streaming-cluster", "client-123", stan.NatsConn(nc))
    if err != nil {
        log.Fatal(err)
    }
    sc.Publish("hello", []byte("msg1"))

    sc.Subscribe("hello", func(m *stan.Msg) {
        log.Printf("[Received] %+v", m)
    }, stan.StartWithLastReceived())

    sc.Publish("hello", []byte("msg2"))

    select{}
}
```

### With Network Policies enabled

To connect to `NATS` as a client with Network Policies enabled , the pod in which the service client is in must have the label
`{{ .Release.Name }}-nats-client=true`.

Otherwise, if enabled, the `ingress` `Network Policy` for `NATS` will block incoming traffic from any pod without the appropriate label.

`Network Policy` is enabled in `stage` and `production` environments.


### JWT Authentication

NATS has been configured to allow authentication using service-to-service(S2S) JWTs, but in order to be authenticated, a service must be whitelisted.
The `nats.auth.jwtUsers` value can be used to provide a whitelist of users that should be authenticated using a S2S JWT.
**Note** when using a S2S JWT both the NATS username and JWT `subject` must match

Adding a new service to the whitelist is as simple as updating `nats.auth.jwtUsers` value as such:
```yaml
nats:
  auth:
    jwtUsers:
    - user: "my-service"
    - user: "my-service"`
    ...etc
```

### Authorization

The above method of adding a JWT authentication whitelist also allows for setting authorization rules.
NATS [authorization rules](https://nats.io/documentation/managing_the_server/authorization/) can be configured on a per subject basis.

The following is an example of adding publish/subscribe authorization rules
```yaml
nats:
  auth:
    jwtUsers:
    - user: "my-service"
      stanPermissions:
        publish:
          - "events.mysubject.>" # service can publish to any subject that starts with `events.mysubject.`
          - "system-events.mysubject" # service can publish to `system-events.mysubject` subject
        subscribe:
          - "events.somesubject" # service can subscribe `events.somesubject` subject
      natsPermissions:
        publish:
          - "events.mysubject1" # service can publish to `events.mysubject1` subject
        subscribe:
          - "events.somesubject1" # service can subscribe `events.somesubject1` subject
```
Wildcard support works as follow:

The dot character `.` is the token separator.

The asterisk character `*` is a token wildcard match.
`e.g foo.* matches foo.bar, foo.baz, but not foo.bar.baz.`

The greater-than symbol `>` is a full wildcard match.
`e.g. foo.> matches foo.bar, foo.baz, foo.bar.baz, foo.bar.1, etc.`