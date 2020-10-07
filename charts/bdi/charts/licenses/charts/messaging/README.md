# messaging

This charts provides **messaging system** (a.k.a. message queue, message bus, etc.) capabilities for services.
Currently, [NATS](https://www.nats.io) and [NATS Streaming](https://nats.io/documentation/streaming/nats-streaming-intro/)
are included in this chart, but in the future, other message systems like RabbitMQ can also be added.

## Installing the Chart

To install the chart with the release name `messaging`:

```console
helm install --name messaging qlik/messaging
```

## Uninstalling the Chart

To uninstall/delete the `messaging` deployment:

```console
helm delete messaging
```

## Configuration

### NATS

| Parameter                         | Description                                 | Default                               |
| --------------------------------- | ------------------------------------------- | ------------------------------------- |
| `nats.enabled`                    | enable NATS messaging system                | `true`                                |
| `nats.image.registry`             | NATS image registry                         | `qliktech-docker.jfrog.io`            |
| `nats.image.repository`           | NATS Image name                             | `qnatsd`                              |
| `nats.image.tag`                  | NATS Image tag                              | `0.3.2`                               |
| `nats.image.pullPolicy`           | pull policy for nats docker image           | `IfNotPresent`                        |
| `nats.image.pullSecrets`          | specify image pull secrets                  | `artifactory-docker-secret`           |
| `nats.replicaCount`               | number of nats replicas                     | `1`                                   |
| `nats.antiAffinity`               | anti-affinity for nats pod assignment       | `soft`                                |
| `nats.auth.enabled`               | enable authentication for nats clients      | `true`                                |
| `nats.auth.user`                  | username for nats client authentication     | `nats_client`                         |
| `nats.auth.password`              | password for nats client authentication     | `T0pS3cr3t`                           |
| `auth.users`                      | Client authentication users                 | `[]` See [Rotation](#how-to-rotate)   |
| `auth.users[].user`               | Client authentication user                  | `nil`                                 |
| `auth.users[].password`           | Client authentication password              | `nil`                                 |
| `nats.auth.jwtUsers`              | array of jwt authenticated users            | See [Authentication](#authentication) |
| `nats.clusterAuth.enabled`        | enable authentication for nats clustering   | `false`                               |
| `nats.clusterAuth.user`           | username for nats clustering authentication | `nats_cluster`                        |
| `nats.clusterAuth.password`       | password for nats clustering authentication | random string                         |
| `nats.statefulset.updateStrategy` | update strategy for nats statefulsets       | `RollingUpdate`                            |
| `nats.client.service.type`        | nats-client service type                    | `ClusterIP`                           |
| `nats.client.service.port`        | nats-client service port                    | `4222`                                |
| `nats.cluster.service.type`       | nats-cluster service type                   | `ClusterIP`                           |
| `nats.cluster.service.port`       | nats-cluster service port                   | `6222`                                |
| `nats.monitoring.service.type`    | nats-monitoring service type                | `ClusterIP`                           |
| `nats.monitoring.service.port`    | nats-monitoring service port                | `8222`                                |
| `nats.livenessProbe.enabled`      | enable liveness probe                       | `true`                                |
| `nats.readinessProbe.enabled`     | enable readiness probe                      | `true`                                |
| `nats.resources`                  | CPU and memory requests and limits for nats | `{}`                                  |
| `extraArgs`                       | Optional flags for NATS                     | See [values.yaml](./values.yaml)      |

### NATS Streaming

| Parameter                                                           | Description                                                                                                                                  | Default                                       |
| ------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| `nats-streaming.enabled`                                            | enable NATS messaging system                                                                                                                 | `false`                                       |
| `nats-streaming.image.registry`                                     | NATS streaming image registry                                                                                                                | `qliktech-docker.jfrog.io`                    |
| `nats-streaming.image.repository`                                   | NATS streaming image name                                                                                                                    | `nats-streaming`                              |
| `nats-streaming.image.tag`                                          | NATS Streaming image tag                                                                                                                     | `0.14.1`                                      |
| `nats-streaming.image.pullPolicy`                                   | pull policy for nats docker image                                                                                                            | `IfNotPresent`                                |
| `nats-streaming.image.pullSecrets`                                  | specify image pull secrets                                                                                                                   | `artifactory-registry-secret`                 |
| `nats-streaming.replicaCount`                                       | number of nats replicas                                                                                                                      | `3`                                           |
| `nats-streaming.antiAffinity`                                       | anti-affinity for nats pod assignment                                                                                                        | `soft`                                        |
| `nats-streaming.auth.enabled`                                       | enable authentication for nats clients                                                                                                       | `true`                                        |
| `nats-streaming.auth.user`                                          | username for nats client authentication                                                                                                      | `nats_client`                                 |
| `nats-streaming.auth.password`                                      | password for nats client authentication                                                                                                      | `nil` (Uses Secret below for password)        |
| `nats-streaming.auth.secretName`                                    | secretName for nats client authentication                                                                                                    | `{{ .Release.Name }}-nats-secret`             |
| `nats-streaming.auth.secretKey`                                     | secretKey for nats client authentication                                                                                                     | `client-password`                             |
| `nats-streaming.statefulset.updateStrategy`                         | update strategy for nats statefulsets                                                                                                        | `onDelete`                                    |
| `nats-streaming.monitoring.service.type`                            | nats-streaming-monitoring service type                                                                                                       | `ClusterIP`                                   |
| `nats-streaming.monitoring.service.port`                            | nats-streaming-monitoring service port                                                                                                       | `8222`                                        |
| `nats-streaming.livenessProbe.enabled`                              | enable liveness probe                                                                                                                        | `true`                                        |
| `nats-streaming.readinessProbe.enabled`                             | enable readiness probe                                                                                                                       | `true`                                        |
| `nats-streaming.resources`                                          | CPU and memory requests and limits for nats                                                                                                  | `{}`                                          |
| `nats-streaming.clusterID`                                          | nats streaming cluster name id                                                                                                               | `{{ .Release.Name }}-nats-streaming-cluster`  |
| `nats-streaming.natsSvc`                                            | external nats server url                                                                                                                     | `nats://{{ .Release.Name }}-nats-client:4222` |
| `nats-streaming.hbInterval`                                         | Interval at which server sends heartbeat to a client                                                                                         | `10s`                                         |
| `nats-streaming.hbTimeout`                                          | How long server waits for a heartbeat response                                                                                               | `10s`                                         |
| `nats-streaming.hbFailCount`                                        | Number of failed heartbeats before server closes the client connection                                                                       | `5`                                           |
| `clustered`                                                         | Run NATS Streaming in clustered mode (incompatible with ftGroup value)                                                                       | `false`                                       |
| `cluster_raft_logging`                                              | Used for raft related debugging                                                                                                              | `false`                                       |
| `ftGroup`                                                           | Enable Fault Tolerance mode with this group name (incompatible with clustered value)                                                         | `nil`                                         |
| `store`                                                             | Storage options (Support values are `memory` and `file`)                                                                                     | `file`                                        |
| `nats-streaming.persistence.enabled`                                | Use specified storage class for volume claim (emptyDir is used if disabled)                                                                  | `false`                                       |
| `nats-streaming.persistence.storageClass`                           | Storage class of backing persistent volume claim                                                                                             | `nil`                                         |
| `nats-streaming.persistence.size`                                   | Persistence volume size                                                                                                                      | `nil`                                         |
| `nats-streaming.persistence.internalStorageClass.enabled`           | Use an internal StorageClass                                                                                                                 | `false`                                       |
| `nats-streaming.persistence.internalStorageClass.definition`        | Definition of the internal StorageClass. Configuration includes provider and parameters. Only needed if the internal StorageClass is enabled | `{}`                                          |

### Network Policy for NATS and NATS Streaming

| Parameter                              | Description                                                      | Default               |
| -------------------------------------- | ---------------------------------------------------------------- | --------------------- |
| `nats.networkPolicy.enabled`           | enable custom network policy for NATS messaging system           | `false`               |
| `nats.networkPolicy.nats.enabled`      | enable custom network policy for NATS messaging system           | `false`               |
| `nats.networkPolicy.keys.release`      | keys service release name for egress rules                       | `{{ .Release.Name }}` |
| `nats-streaming.networkPolicy.enabled` | enable custom network policy for NATS Streaming messaging system | `false`               | 
| `nats-streaming.networkPolicy.nats-streaming.enabled` | enable custom network policy for NATS Streaming messaging system | `false`| 

## Requirements

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

## Authentication

It's important to know that when using NATS Streaming, a NATS connection is also required and that it is the NATS connection that handles authentication and authorization not the NATS Streaming connnection.

### NATS to NATS-Streaming password rotation

The nats chart supports an array of users (`nats.auth.users`) used for authenticating NATS-Streaming to NATS. NATS-Streaming will use the first entry in the array to authenticate to NATS. Any additional entries can still be used to authenticate against.

#### How to rotate

In this example we have a deployed cluster with a NATS-Streaming that is authenticated using user `user1` with password `password1` from the following config. We want to update this to use `password2`.
```yaml
auth:
  users:
  - user: user1
    password: password1
```

1) Add new user/password to the first entry in the array, but leave the old entry as *second* in the list. Then `helm update` your release.
```yaml
auth:
  users:
  - user: user2
    password: password2
  - user: user1
    password: password1
```
2) NATS will now have both user/passwords configured, but NATS-Streaming will still be using the original entry to authenticate. NATS-Streaming servers will need to be restarted to pickup the new password from the first entry in `nats.auth-users`.
```sh
kubectl delete pod {Release.Name}-nats-streaming-2 #wait for new pod to become ready
kubectl delete pod {Release.Name}-nats-streaming-1 #wait for new pod to become ready
kubectl delete pod {Release.Name}-nats-streaming-0 #wait for new pod to become ready
```
3) Finally remove the old user from the `nats.auth.users` array and `helm update` to remove authentication for the old user.
```yaml
auth:
  users:
  - user: user2
    password: password2
```

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
