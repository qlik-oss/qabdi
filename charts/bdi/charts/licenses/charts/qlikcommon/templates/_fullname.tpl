{{- /*
fullname defines a suitably unique name for a resource by combining
the release name and the chart name.

The prevailing wisdom is that names should only contain a-z, 0-9 plus dot (.) and dash (-), and should
not exceed 63 characters.

Parameters:

- .Values.fullnameOverride: Replaces the computed name with this given name
- .Values.fullnamePrefix: Prefix
- .Values.global.fullnamePrefix: Global prefix
- .Values.fullnameSuffix: Suffix
- .Values.global.fullnameSuffix: Global suffix

The applied order is: "global prefix + prefix + name + suffix + global suffix"

Usage: 'name: "{{- template "common.fullname" . -}}"'
*/ -}}
{{- define "common.fullname" -}}
  {{- $global := default (dict) .Values.global -}}
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

{{- /*
common.fullname.unique adds a random suffix to the unique name.

This takes the same parameters as common.fullname

*/ -}}
{{- define "common.fullname.unique" -}}
  {{ template "common.fullname" . }}-{{ randAlphaNum 7 | lower }}
{{- end }}
