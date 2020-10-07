{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "nats-streaming.name" -}}
{{- "nats-streaming" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "nats-streaming.fullname" -}}
{{- $name := "nats-streaming" -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "nats-streaming.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper NATS Streaming image name
*/}}
{{- define "nats-streaming-cluster.image" -}}
{{- $registryName := .Values.image.registry -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := .Values.image.tag | toString -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 doesn't support it, so we need to implement this if-else logic.
Also, we can't use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
    {{- if .Values.global.imageRegistry }}
        {{- printf "%s/%s:%s" .Values.global.imageRegistry $repositoryName $tag -}}
    {{- else -}}
        {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
    {{- end -}}
{{- else -}}
    {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
Create a NATS Streaming cluster peers list string based on fullname, namespace, # of servers
in a format like "host-1,host-2,host-3"
*/}}
{{- define "nats-streaming-cluster.peers" -}}
{{- $name := include "nats-streaming.fullname" . -}}
{{- $nats_streaming_cluster := dict "peers" (list) -}}
{{- range $idx, $v := until (int .Values.replicaCount) }}
{{- $noop := printf "%s-%d" $name $idx | append $nats_streaming_cluster.peers | set $nats_streaming_cluster "peers" -}}
{{- end }}
{{- printf "%s" (join "," $nats_streaming_cluster.peers) -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for networkpolicy.
*/}}
{{- define "networkPolicy.apiVersion" -}}
{{- if semverCompare ">=1.4-0, <1.7-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper image name (for the metrics image)
*/}}
{{- define "metrics.image" -}}
{{- $registryName :=  .Values.metrics.image.registry -}}
{{- $repositoryName := .Values.metrics.image.repository -}}
{{- $tag := .Values.metrics.image.tag | toString -}}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end -}}


{{/* Return nats-streaming storage class name */}}
{{- define "nats-streaming.StorageClassName" -}}
{{- if .Values.persistence.storageClass }}
  {{- if (eq "-" .Values.persistence.storageClass) -}}
storageClassName: ""
  {{- else -}}
storageClassName: {{ .Values.persistence.storageClass }}
  {{- end -}}
{{- else -}}
  {{- if .Values.global }}
    {{- if .Values.global.persistence }}
      {{- if .Values.global.persistence.storageClass }}
        {{- if (eq "-" .Values.global.persistence.storageClass) -}}
storageClassName: ""
        {{- else -}}
storageClassName: {{ .Values.global.persistence.storageClass }}
       {{- end -}}
     {{- end -}}
   {{- end -}}
 {{- end -}}
{{- end -}}
{{- end -}}

{{- define "nats.name" -}}
{{- "nats" -}}
{{- end -}}

{{- define "nats.fullname" -}}
{{- $name := "nats" -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
