# NATS Streaming Clustering Helm Chart

Sets up a [NATS](http://nats.io/) Streaming server cluster with Raft based replication.

## Getting started

This chart relies on an already available NATS Service to which the
NATS Streaming nodes that will form a clusters can connect to.
You can install the NATS Operator and then use it to create a NATS cluster
via the following:

```console
$ kubectl apply -f https://raw.githubusercontent.com/nats-io/nats-operator/master/example/deployment-rbac.yaml
$ kubectl apply -f https://raw.githubusercontent.com/nats-io/nats-operator/master/example/example-nats-cluster.yaml
```

This will create a NATS cluster on the `nats-io` namespace.  Then, to
install a NATS Streaming cluster the URL to the NATS cluster can be
specified as follows (using `my-release` for a name label for the
cluster):

```console
$ git clone https://github.com/wallyqs/nats-streaming-cluster-chart nats-streaming-cluster
$ helm install nats-streaming-cluster -n my-release  --set natsUrl=nats://nats.nats-io.svc.cluster.local:4222
```

This will create 3 follower nodes plus an extra Pod which is
configured to be in bootstrapping mode, which will start as the leader
of the Raft group as soon as it joins.

```console
$ kubectl get pods --namespace default -l "app=nats-streaming-cluster,release=my-release"
NAME                                          READY     STATUS    RESTARTS   AGE
my-release-nats-streaming-cluster-0           1/1       Running   0          30s
my-release-nats-streaming-cluster-1           1/1       Running   0          23s
my-release-nats-streaming-cluster-2           1/1       Running   0          17s
my-release-nats-streaming-cluster-bootstrap   1/1       Running   0          30s
```

Note that in case the bootstrapping Pod fails then it will not be
recreated and instead one of the extra follower Pods will take over
the leadership.  The follower Pods are part of a Deployment so those
in case of failure they will be recreated.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the
chart and deletes the release.

## Configuration

| Parameter                            | Description                                                                                  | Default                                |
| ------------------------------------ | -------------------------------------------------------------------------------------------- | -------------------------------------- |
| `global.imageRegistry`               | Global Docker image registry                                                                 | `nil`                                  |
| `image.registry`                     | NATS Streaming image registry                                                                | `qliktech-docker.jfrog.io`             |
| `image.repository`                   | NATS Streaming Image name                                                                    | `nats-streaming`                       |
| `image.tag`                          | NATS Streaming Image tag                                                                     | ` 0.14.2`                              |
| `image.pullPolicy`                   | Image pull policy                                                                            | `IfNotPresent`                         |
| `image.pullSecrets`                  | Specify image pull secrets                                                                   | `artifactory-docker-secret`            |
| `auth.enabled`                       | Switch to enable/disable client authentication                                               | `false`                                |
| `auth.user`                          | Client authentication user                                                                   | `nats_cluster`                         |
| `auth.password`                      | Client authentication password                                                               | `random alhpanumeric string (10)`      |
| `auth.token`                         | Client authentication token                                                                  | `nil`                                  |
| `auth.secretName`                    | Client authentication secret name                                                            | `"{{ .Release.Name }}-nats-secret"`            |
| `nats.auth.secretClientUser`         | Key to read from a K8s secret key to retrieve a username                                     | `"client-user"`                                |
| `auth.secretClientPassword`          | secretKey for nats client authentication                                                     | `client-password`                              |
| `hbInterval`                         | Interval at which server sends heartbeat to a client                                         | `10s`                                          |
| `hbTimeout`                          | How long server waits for a heartbeat response                                               | `10s`                                          |
| `hbFailCount`                        | Number of failed heartbeats before server closes the client connection                       | `5`                                            |
| `clusterID`                          | NATS Streaming Cluster Name ID                                                               | `"{{ .Release.Name }}-nats-streaming-cluster"` |
| `natsSvc`                            | External NATS Server URL                                                                     | `"nats://{{ .Release.Name }}-nats-client:4222"`|
| `maxChannels`                        | Max # of channels                                                                            | `100`                                  |
| `maxSubs`                            | Max # of subscriptions per channel                                                           | `1000`                                 |
| `maxMsgs`                            | Max # of messages per channel                                                                | `"1000000"`                            |
| `maxBytes`                           | Max messages total size per channel                                                          | `900mb`                                |
| `maxAge`                             | Max duration a message can be stored                                                         | `""2h"`                                |
| `maxMsgs`                            | Max # of messages per channel                                                                | `1000000`                              |
| `debug`                              | Enable debugging                                                                             | `true`                                 |
| `trace`                              | Enable detailed tracing                                                                      | `false`                                |
| `clustered`                          | Run NATS Streaming in clustered mode (incompatible with ftGroup value)                       | `false`                                |
| `cluster_raft_logging`               | Used for raft related debugging                                                              | `false`                                |
| `ftGroup`                            | Enable Fault Tolerance mode with this group name (incompatible with clustered value)         | `nil`                                  |
| `store`                              | Storage options (Support values are `memory` and `file`)                                     | `file`                                 |
| `replicaCount`                       | Number of NATS Streaming nodes                                                               | `3`                                    |
| `securityContext.enabled`            | Enable security context                                                                      | `false`                                |
| `securityContext.fsGroup`            | Group ID for the container                                                                   | `1001`                                 |
| `securityContext.runAsUser`          | User ID for the container                                                                    | `1001`                                 |
| `statefulset.updateStrategy`         | Statefulsets Update strategy                                                                 | `RollingUpdate`                        |
| `statefulset.rollingUpdatePartition` | Partition for Rolling Update strategy                                                        | `nil`                                  |
| `podLabels`                          | Additional labels to be added to pods                                                        | {}                                     |
| `podAnnotations`                     | Annotations to be added to pods                                                              | {}                                     |
| `nodeSelector`                       | Node labels for pod assignment                                                               | `nil`                                  |
| `schedulerName`                      | Name of an alternate                                                                         | `nil`                                  |
| `antiAffinity`                       | Anti-affinity for pod assignment                                                             | `soft`                                 |
| `tolerations`                        | Toleration labels for pod assignment                                                         | `nil`                                  |
| `resources`                          | CPU/Memory resource requests/limits                                                          | {}                                     |
| `livenessProbe.initialDelaySeconds`  | Delay before liveness probe is initiated                                                     | `30`                                   |
| `livenessProbe.periodSeconds`        | How often to perform the probe                                                               | `10`                                   |
| `livenessProbe.timeoutSeconds`       | When the probe times out                                                                     | `5`                                    |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the probe to be considered successful after having failed. | `1`                                    |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the probe to be considered failed after having succeeded.   | `6`                                    |
| `readinessProbe.initialDelaySeconds` | Delay before readiness probe is initiated                                                    | `30`                                   |
| `readinessProbe.periodSeconds`       | How often to perform the probe                                                               | `10`                                   |
| `readinessProbe.timeoutSeconds`      | When the probe times out                                                                     | `5`                                    |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the probe to be considered failed after having succeeded.   | `6`                                    |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the probe to be considered successful after having failed. | `1`                                    |
| `monitoring.service.type`            | Kubernetes Service type (NATS Streaming monitoring)                                          | `ClusterIP`                            |
| `monitoring.service.port`            | NATS Streaming monitoring port                                                               | `8222`                                 |
| `monitoring.service.nodePort`        | Port to bind to for NodePort service type (NATS Streaming monitoring)                        | `nil`                                  |
| `monitoring.service.annotations`     | Annotations for NATS Streaming monitoring service                                            | {}                                     |
| `monitoring.service.loadBalancerIP`  | loadBalancerIP if NATS Streaming monitoring service type is `LoadBalancer`                   | `nil`                                  |
| `networkPolicy.enabled`              | Enable NetworkPolicy                                                                         | `false`                                |
| `sidecars`                           | Attach additional containers to the pod.                                                     | `nil`                                  |

### File Specific Persistence Configuration

| Parameter                         | Description                        | Default          |
| --------------------------------- | ---------------------------------- | ---------------- |
| `file.compactEnabled` | Enable compaction                  | true             |
| `file.bufferSize`     | File buffer size (in bytes)        | "2097152"  (2MB) |
| `file.crc`            | Enable file CRC-32 checksum        | true             |
| `file.sync`           | Enable File.Sync on Flush          | true             |
| `file.fdsLimit`       | Max File Descriptor limit (approx) | 0 (unlimited)    |

### Storage Specific Persistence Configuration

| Parameter                                            | Description                                                                                                                                  | Default       |
| ---------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| `persistence.enabled`                         | Use specified storage class for volume claim (emptyDir is used if disabled)                                                                  | `false`       |
| `persistence.storageClass`                    | Storage class of backing persistent volume claim                                                                                             | `nil`         |
| `persistence.size`                            | Persistence volume size                                                                                                                      | `nil`         |
| `persistence.internalStorageClass.enabled`    | Use an internal StorageClass                                                                                                                 | `false`       |
| `persistence.internalStorageClass.definition` | Definition of the internal StorageClass. Configuration includes provider and parameters. Only needed if the internal StorageClass is enabled | `{}`          |

*Additional configuration parameters not typically used may be found in [values.yaml](values.yaml).*

## Authentication

It's important to know that when using NATS Streaming, a NATS connection is also required and that it is the NATS connection that handles authentication and authorization not the NATS Streaming connnection.

# NATS to NATS-Streaming password rotation

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