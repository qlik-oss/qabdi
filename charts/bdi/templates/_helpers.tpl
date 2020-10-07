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
{{- $name := default "licenses" .Values.licenses.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name -}}
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
{{- printf "%s-%s" .Release.Name $name -}}
{{- end -}}

{{- define "bdi.sourcecloudgw.fullname" -}}
{{- $name := default "sourcecloudgw" .Values.sourcecloudgw.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name -}}
{{- end -}}

{{- define "bdi.outputcloudgw.fullname" -}}
{{- $name := default "outputcloudgw" .Values.outputcloudgw.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name -}}
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

{{- define "bdi.brokerservice.logging.fullname" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) "brokerservice-logging-cm" -}}
{{- end -}}

{{- define "bdi.qsl.config.fullname" -}}
{{- printf "%s-%s" (include "bdi.fullname" .) "qsl-cm" -}}
{{- end -}}

{{- define "bdi.merge.configvalues" -}}
    {{- $deflines := splitList "\n" .Defaults -}}
    {{- $merged := dict -}}
    {{- range $deflines -}}
        {{- if not (. | trim | empty) -}}
            {{- $kv := . | splitn ":" 2 -}}
            {{- $_ := set $merged ($kv._0 | trim) ($kv._1 | trim  ) -}}
        {{- end -}}
    {{- end -}}
    {{- if .Values -}}
        {{- $merged := mergeOverwrite $merged .Values -}}
    {{- end -}}
    {{- if $merged -}}
        {{- range $key, $val := $merged -}}
            {{- if hasPrefix "\"" ($val | toString) -}}
                {{- $_ := set $merged $key ($val | trimall "\"") -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}
{{ toJson $merged }}
{{- end -}}

{{- define "bdi.indexing.loggingsettings" }}
data:
  loggingsettings.json: |-
    {
        "log_level" : {{ .CompConfig.logLevel | default .Values.indexingcommon.config.logLevel | default 3  }},
        "log_pattern" : "{{ .CompConfig.logPattern | default .Values.indexingcommon.config.logPattern | default "[%C-%m-%dT%H:%M:%S:%e]-[%^%n-%l%$]-[%t] %v" }}",
        "log_to_console" : {{ .CompConfig.logToConsole | default .Values.indexingcommon.config.logToConsole | default true }},

        {{- if hasKey .CompConfig "pathForLogFiles" }}
        "output_path" : "{{ .CompConfig.pathForLogFiles }}/{{ .CompName }}",
        {{ else }}
        {{ if hasKey .Values.indexingcommon.config "pathForLogFiles" }}
        "output_path" : "{{ .Values.indexingcommon.config.pathForLogFiles }}/{{ .CompName }}",
        {{ else }}
        "output_path" : "",
        {{ end -}} {{ end -}}
        "max_log_file_size_in_kb" : {{ .CompConfig.maxLogFileSizeInKB | default .Values.indexingcommon.config.maxLogFileSizeInKB | default 5120 }},
        "max_log_files_to_keep" : {{ .CompConfig.maxLogFilesToKeep | default .Values.indexingcommon.config.maxLogFilesToKeep | default 1 }},

        "debug_log_level" : {{ .CompConfig.debugLogLevel | default .Values.indexingcommon.config.debugLogLevel | default 0  }},
        "debug_log_filter" : "{{ .CompConfig.debugLogFilter | default .Values.indexingcommon.config.debugLogFilter | default "all_!audit_!periodic_!progress" }}",
        "show_debug_filter" : {{ .CompConfig.debugShowFilter | default .Values.indexingcommon.config.debugShowFilter | default false }},

        "trace_log_level" : {{ .CompConfig.traceLogLevel | default .Values.indexingcommon.config.traceLogLevel | default 0  }},
        "trace_log_filter" : "{{ .CompConfig.traceLogFilter | default .Values.indexingcommon.config.traceLogFilter | default "all_!audit_!periodic_!progress" }}",
        "show_trace_log_filter" : {{ .CompConfig.traceShowFilter | default .Values.indexingcommon.config.traceShowFilter | default false }},

        "dt_detailed_func_name" : {{ .CompConfig.dtLogDetailedFuncName | default .Values.indexingcommon.config.dtLogDetailedFuncName | default 1 }},

        "use_logger_assert" : {{ .CompConfig.useLoggerAssert | default .Values.indexingcommon.config.useLoggerAssert | default 0  }}
    }
{{- end }}

{{- define "bdi.qsl.commonprobes" }}
livenessProbe:
  exec:
    command: ["/bin/grpc_health_probe", "-addr=:{{ .PortNum }}", "-service=liveness"]
  initialDelaySeconds: 15
  periodSeconds: 8
  timeoutSeconds: 4
readinessProbe:
  exec:
    command: ["/bin/grpc_health_probe", "-addr=:{{ .PortNum }}", "-service=readiness"]
  initialDelaySeconds: 15
  periodSeconds: 10
  timeoutSeconds: 5
{{- end }}

{{- define "bdi.cloudSync.exportSettings" -}}
{{- if .Values.sourcecloudgw.enabled }}
- name: SOURCE_GW_KEY
  value: {{ .Values.sourcecloudgw.accessKey | quote }}
- name: SOURCE_GW_SECRET
  value: {{ .Values.sourcecloudgw.secretKey | quote }}
{{- end }}
{{- if .Values.outputcloudgw.enabled }}
- name: OUTPUT_GW_KEY
  value: {{ .Values.outputcloudgw.accessKey | quote }}
- name: OUTPUT_GW_SECRET
  value: {{ .Values.outputcloudgw.secretKey | quote }}
{{- end }}
{{- if .Values.cloudSync }}
{{- if .Values.cloudSync.checkCRCFileSizeLimit }}
- name: CLOUD_SYNC_CHECK_CRC_FILE_SIZE_LIMIT
  value: {{ .Values.cloudSync.checkCRCFileSizeLimit | quote }}
{{- end }}
{{- if .Values.cloudSync.maxRetries }}
- name: CLOUD_SYNC_MAX_RETRIES
  value: {{ .Values.cloudSync.maxRetries | quote }}
{{- end }}
{{- if .Values.cloudSync.maxSleepForSeconds }}
- name: CLOUD_SYNC_MAX_SLEEP_FOR_SECONDS
  value: {{ .Values.cloudSync.maxSleepForSeconds | quote }}
{{- end }}
{{- if .Values.cloudSync.waitIntervalInc }}
- name: CLOUD_SYNC_WAIT_INTERVAL_INC
  value: {{ .Values.cloudSync.waitIntervalInc | quote }}
{{- end }}
{{- end }}
{{- end -}}
