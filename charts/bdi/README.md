# bdi

QBDI is the Qlik Big Data Index.

## Introduction

This chart bootstraps the BDI application on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install --name my-release .
```

The command deploys bdi on the Kubernetes cluster in the default configuration.

### Using a Local Chart Instead of qlik/bdi

Sometimes you may have a local copy of a chart that you want to deploy (chart install) BDI with.  To do this you first need to pull in the dependencies for BDI deployment onto disk within your local chart.
For example, assume you want to deploy using the local BDI Chart located in <your-oxpecker-k8s-repo>/helm/bdi, you would first need to execute:
```console
$ helm dependency update helm/bdi
```

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
| `acceptLicense` | Accept the Qlik User License Agreement (QULA) | `false` |
| `brokerservice.enabled` | Enable the broker service (needed for cloud sync) | `false` |
| `brokerservice.containerPort` | Broker service (container) port | `8082` |
| `brokerservice.hostPort` | Port to expose on the host (node) where broker service runs | `8082` |
| `enableCrashDumpUpload` | Enable crash dump handling including upload to dump server | `false` |
| `image.registry` | image registry | `qliktech-docker.jfrog.io`|
| `image.repository` | image name | `bdiproduct`|
| `image.tag` | image version | `6.78.0` |
| `image.pullPolicy` | image pull policy | `Always` if `imageTag` is `latest`, else `IfNotPresent` |
| `image.privileged` | Enable `privileged` mode for all pods | `false` |
| `imagePullSecrets` | A list of secret names for accessing private image registries | `[{name: "artifactory-docker-secret"}]` |
| `licenses.license.key` | QBDI license key | `""` |
| `indexer.replicaCount` | Number of indexer replicas | `1` |
| `indexer.resources` | Indexer resource limits | `{}` |
| `indexer.additionalAffinities` | Additional affinities to apply to indexer pods. | `{}` |
| `indexer.annotations` | Indexer deployment annotations | `{}` |
| `indexer.nodeSelector` | Node selector for the indexer pods | `{}` |
| `indexer.tolerations` | Tolerations for the indexer pods | `{}` |
| `indexer.updateStrategy` | Strategy for StatefulSet updates | `RollingUpdate` |
| `indexer.podManagementPolicy` | Pod Management strategy | `Parallel` |
| `indexingmanager.replicaCount` | Number of indexing manager replicas | `1` |
| `indexingmanager.resources` | Indexing Manager resource limits | `{}` |
| `indexingmanager.additionalAffinities` | Additional affinities to apply to indexing manager pods. | `{}` |
| `indexingmanager.annotations` | Indexing Manager deployment annotations | `{}` |
| `indexingmanager.nodeSelector` |  Node selector for the indexing manager pods | `{}` |
| `indexingmanager.tolerations` | Tolerations for the indexing manager pods | `{}` |
| `indexingmanager.service.type` | Indexing Manager service type | `ClusterIP` |
| `indexingmanager.ingress.enabled` | Enable Indexing Manager Ingress | `false` |
| `indexingmanager.ingress.annotations` | Indexing Manager Ingress annotations | `{}` |
| `indexingmanager.ingress.hosts` | Indexing Manager Ingress Hostnames | `[]` |
| `indexingmanager.ingress.tls` | Indexing Manager Ingress TLS configuration | `[]` |
| `managementconsole.replicaCount` | Number of management console replicas | `1` |
| `managementconsole.resources` | Management console resource limits | `{}` |
| `managementconsole.additionalAffinities` | Additional affinities to apply to management console pods. | `{}` |
| `managementconsole.annotations` | Management console deployment annotations | `{}` |
| `managementconsole.nodeSelector` | Node selector for the management console pods | `{}` |
| `managementconsole.tolerations` | Tolerations for the management console pods | `{}` |
| `managementconsole.service.type` | Management console service type | `ClusterIP` |
| `managementconsole.ingress.enabled` | Enable Management console Ingress | `false` |
| `managementconsole.ingress.annotations` | Management console Ingress annotations | `{}` |
| `managementconsole.ingress.hosts` | Management console Ingress Hostnames | `[]` |
| `managementconsole.ingress.tls` | Management console Ingress TLS configuration | `[]` |
| `outputcloudgw.enabled` | Enable syncing output to the cloud | `false` |
| `outputcloudgw.mountPath` | Output mount path to the cloud | `/output` |
| `outputcloudgw.persistence.size` | Output cloud data persistence volume size | `10Gi` |
| `outputcloudgw.s3gateway.enabled` | Output S3 Gateway type  | `false` |
| `outputcloudgw.azuregateway.enabled` | Output Azure Gateway type  | `false` |
| `qslexecutor.replicaCount` | Number of QSL executer replicas | `1` |
| `qslexecutor.resources` | QSL executer resource limits | `{}` |
| `qslexecutor.additionalAffinities` | Additional affinities to apply to QSL executer pods. | `{}` |
| `qslexecutor.annotations` | QSL executer deployment annotations | `{}` |
| `qslexecutor.nodeSelector` | Node selector for the QSL executer pods | `{}` |
| `qslexecutor.tolerations` | Tolerations for the QSL executer pods | `{}` |
| `qslexecutor.service.type` | QSL executer service type | `ClusterIP` |
| `qslmanager.replicaCount` | Number of QSL manager replicas | `1` |
| `qslmanager.resources` | QSL manager resource limits | `{}` |
| `qslmanager.additionalAffinities` | Additional affinities to apply to QSL manager pods. | `{}` |
| `qslmanager.annotations` | QSL manager deployment annotations | `{}` |
| `qslmanager.nodeSelector` | Node selector for the QSL manager pods | `{}` |
| `qslmanager.tolerations` | Tolerations for the QSL manager pods | `{}` |
| `qslmanager.service.type` | QSL manager service type | `ClusterIP` |
| `qslmanager.service.annotations` | QSL manager service annotations | `{}` |
| `qslmanager.ingress.enabled` | Enable QSL manager Ingress | `false` |
| `qslmanager.ingress.annotations` | QSL manager Ingress annotations | `{}` |
| `qslmanager.ingress.hosts` | QSL manager Ingress Hostnames | `[]` |
| `qslmanager.ingress.tls` | QSL manager Ingress TLS configuration | `[]` |
| `qslworker.replicaCount` | Number of QSL worker replicas | `1` |
| `qslworker.resources` | QSL worker resource limits | `{}` |
| `qslworker.additionalAffinities` | Additional affinities to apply to QSL worker pods. | `{}` |
| `qslworker.annotations` | QSL worker deployment annotations | `{}` |
| `qslworker.nodeSelector` | Node selector for the QSL worker pods | `{}` |
| `qslworker.tolerations` | Tolerations for the QSL worker pods | `{}` |
| `qslworker.updateStrategy` | Strategy for StatefulSet updates | `RollingUpdate` |
| `qslworker.podManagementPolicy` | Pod Management strategy | `Parallel` |
| `restapi.replicaCount` | Number of REST API replicas | `1` |
| `restapi.resources` | REST API resource limits | `{}` |
| `restapi.additionalAffinities` | Additional affinities to apply to REST API pods. | `{}` |
| `restapi.annotations` | REST API deployment annotations | `{}` |
| `restapi.nodeSelector` | Node selector for the REST API pods | `{}` |
| `restapi.tolerations` | Tolerations for the REST API pods | `{}` |
| `restapi.service.type` | REST API service type | `ClusterIP` |
| `restapi.service.annotations` | REST API service annotations | `{}` |
| `restapi.tls.enabled` | Enable TLS for the REST service | `false` |
| `restapi.tls.certificate` | REST API certificate for TLS | *See [values.yaml](values.yaml)* |
| `restapi.tls.key` | REST API key for TLS | *See [values.yaml](values.yaml)* |
| `sourcecloudgw.enabled` | Enable syncing source data from the cloud | `false` |
| `sourcecloudgw.mountPath` | Source mount path to the cloud | `/data` |
| `sourcecloudgw.persistence.size` | Source cloud data persistence volume size | `10Gi` |
| `sourcecloudgw.s3gateway.enabled` | Source S3 Gateway type  | `false` |
| `sourcecloudgw.azuregateway.enabled` | Source Azure Gateway type  | `false` |
| `symbolserver.replicaCount` | Number of symbol server replicas | `1` |
| `symbolserver.resources` | Symbol server resource limits | `{}` |
| `symbolserver.additionalAffinities` | Additional affinities to apply to symbol server pods. | `{}` |
| `symbolserver.annotations` | Symbol server deployment annotations | `{}` |
| `symbolserver.nodeSelector` | Node selector for the symbol server pods | `{}` |
| `symbolserver.tolerations` | Tolerations for the symbol server pods | `{}` |
| `symbolserver.updateStrategy` | Strategy for StatefulSet updates | `RollingUpdate` |
| `symbolserver.podManagementPolicy` | Pod Management strategy | `Parallel` |
| `data.path` | Data volume mounth path | `/home/data` |
| `data.persistence.enabled` | Enable persistence for config using Persistent Volume Claims | `true` |
| `data.persistence.folder` | When PVC is disabled, this is the local host path mounted as volume | `/tmp` |
| `data.persistence.storageClass` | Storage class of backing persistent volume claim | `nil` |
| `data.persistence.accessMode` | Persistence access mode | `ReadOnlyMany` |
| `data.persistence.size` | Source data persistence volume size | `10Gi` |
| `data.persistence.mode` | Volume mode | `nil` |
| `data.persistence.existingClaim` | If defined, PersistentVolumeClaim is not created and uses this claim | `nil` |
| `data.persistence.volume.enabled` | Enable the creation of a static PersistentVolume | `false` |
| `data.persistence.volume.reclaimPolicy` | PersistentVolume reclaim policy | `nil` |
| `data.persistence.volume.mountOptions` | PersistentVolume mount options | `nil` |
| `data.persistence.volume.plugin` | PersistentVolume type | `nil` |
| `output.path` | Output files volume mounth path | `/home/output` |
| `output.persistence.enabled` | Enable persistence for config using Persistent Volume Claims | `true` |
| `output.persistence.folder` | When PVC is disabled, this is the local host path mounted as volume | `/tmp` |
| `output.persistence.storageClass` | Storage class of backing persistent volume claim | `nil` |
| `output.persistence.accessMode` | Persistence access mode | `ReadWriteMany` |
| `output.persistence.size` | Output persistence volume size | `10Gi` |
| `output.persistence.mode` | Volume mode | `nil` |
| `output.persistence.existingClaim` | If defined, PersistentVolumeClaim is not created and uses this claim | `nil` |
| `output.persistence.volume.enabled` | Enable the creation of a static PersistentVolume | `false` |
| `output.persistence.volume.reclaimPolicy` | PersistentVolume reclaim policy | `nil` |
| `output.persistence.volume.mountOptions` | PersistentVolume mount options | `nil` |
| `output.persistence.volume.plugin` | PersistentVolume type | `nil` |
| `nginx-ingress.enabled` | Enable nginx-ingress | `false` |
| `google.credentials` | Google credentials JSON file | `""` |
| `google.projectId` | Google project ID | `""` |
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml .
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Docker Registry Secrets

To use these charts locally you have to add a Helm repository. Bintray.io hosts Qlik's charts.

> ⚠️ **Note:**
>
> You must be using Helm [2.9](https://github.com/kubernetes/helm/releases/tag/v2.9.0) or greater to use Artifactory.

Retrieve your username and password (an API key) from [Bintray](https://bintray.com). The API key is found from the [Edit Profile page](https://bintray.com/profile/edit)

Add the `qlik` repo with your credentials:

```console
$ helm repo add qlik https://qlik.bintray.com/qabdicharts --username <username> --password <api-key>
"qlik" has been added to your repositories
```

You can search the repository for what charts are available:

```console
$ helm search qlik/bdi
NAME            CHART VERSION   APP VERSION     DESCRIPTION
qlik/bdi        0.1.3           0.17.0          Big Data Index
```

## Example

_Extrapolated from the [Docker example](https://github.com/qlik-trial/oxpecker-indexlet/tree/master/deploy/docker#example)_

> ⚠️ **Note:**
>
> You must have a working Kubernetes cluster with Helm installed to follow this example.

Make sure you have your docker-registry secrets setup, see section Docker Registry Secrets above.

Install the Helm chart to your Kubernetes cluster:

```console
$ helm install --name bdi .
```

Wait for the `bdi-bastion` (or `releasename-bastion`) to become ready:

```console
$ kubectl get po bdi-bastion

NAME          READY     STATUS    RESTARTS   AGE
bdi-bastion   1/1       Running   0          17s
```

Copy the data that you want to index to the data volume:

```console
$ kubectl cp <your-data-path> bdi-bastion:/home/data/
```

> ⚠️ **Note:**
>
> Data path can be changed in the [values.yaml file](#configuration) via `data.path`

`exec` into the Bastion pod and start a shell:

```console
$ kubectl exec -it bdi-bastion -- /bin/bash
root@bdi-bastion:/#
```

Start the indexers, managers and QSL environments inside of the shell:

```console
root@bdi-bastion:/# /home/ubuntu/dist/runtime/scripts/indexer/start_indexing_env.sh
root@bdi-bastion:/# /home/ubuntu/dist/runtime/scripts/indexer/task_manager.sh
root@bdi-bastion:/# /home/ubuntu/dist/runtime/scripts/qsl_processor/start_qsl_env.sh -u 127.0.0.1
```
