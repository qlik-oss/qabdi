{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "bdi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bdi.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "bdi.indexingmanager.fullname" -}}
{{- $name := default "indexingmanager" .Values.indexingmanager.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.indexer.fullname" -}}
{{- $name := default "indexer" .Values.indexer.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.qslworker.fullname" -}}
{{- $name := default "qslworker" .Values.qslworker.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.qslexecutor.fullname" -}}
{{- $name := default "qslexecutor" .Values.qslexecutor.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.qslmanager.fullname" -}}
{{- $name := default "qslmanager" .Values.qslmanager.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.symbolserver.fullname" -}}
{{- $name := default "symbolserver" .Values.symbolserver.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.cache.fullname" -}}
{{- $name := default "cache" .Values.indexingmanager.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.cluster.fullname" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) "cluster" -}}
{{- end -}}

{{- define "bdi.data.fullname" -}}
{{- $name := default "data" .Values.data.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.output.fullname" -}}
{{- $name := default "output" .Values.output.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.license.fullname" -}}
{{- $name := default "license" .Values.license.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.license.required" -}}
{{- if ne (.Values.acceptLicense | toString) "true" -}}
{{- $license := .Files.Get "LICENSE.txt" -}}
{{- $message := "\nError: Must accept QULA to deploy QBDI. Please read the Qlik User License Agreement carefully.\n\nTo accept, during the command `helm install` or `helm upgrade`:\n\n  --set acceptLicense=true\n\nor modify your yaml overrides that are passed in with the `-f` flag:\n\n  acceptLicense: true" -}}
{{- required (printf "\n%s%s\n" $license $message) nil -}}
{{- end -}}
{{- end -}}

{{- define "bdi.restapi.fullname" -}}
{{- $name := default "restapi" .Values.restapi.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.managementconsole.fullname" -}}
{{- $name := default "managementconsole" .Values.managementconsole.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.sourcecloudgw.fullname" -}}
{{- $name := default "sourcecloudgw" .Values.sourcecloudgw.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.outputcloudgw.fullname" -}}
{{- $name := default "outputcloudgw" .Values.outputcloudgw.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.brokerservice.fullname" -}}
{{- $name := default "brokerservice" .Values.brokerservice.nameOverride -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{/*
Create a default fully qualified redis-ha name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "bdi.redis.fullname" -}}
{{- $redis := index .Values "redis-ha" -}}
{{- $name := default "redis-ha" $redis.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bdi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "bdi.registry.fullname" -}}
{{- $name := default "registry" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.persistence.fullname" -}}
{{- $name := default "persistence" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) $name -}}
{{- end -}}

{{- define "bdi.indexer.config.fullname" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) "indexer-cm" -}}
{{- end -}}

{{- define "bdi.indexer.logging.fullname" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) "indexer-logging-cm" -}}
{{- end -}}

{{- define "bdi.indexingmanager.logging.fullname" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) "indexingmanager-logging-cm" -}}
{{- end -}}

{{- define "bdi.persistence.logging.fullname" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) "persistence-logging-cm" -}}
{{- end -}}

{{- define "bdi.registry.logging.fullname" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) "registry-logging-cm" -}}
{{- end -}}

{{- define "bdi.symbolserver.logging.fullname" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) "symbolserver-logging-cm" -}}
{{- end -}}

{{- define "bdi.qsl.config.fullname" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) "qsl-cm" -}}
{{- end -}}
