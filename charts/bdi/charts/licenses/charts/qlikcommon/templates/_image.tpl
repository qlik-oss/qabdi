{{/* Return the proper collections image name */}}
{{- define "common.image" -}}
  {{/* docker.io is the default registry - e.g. "qlik/myimage" resolves to "docker.io/qlik/myimage" */}}
  {{ $image := .Values.image }}
  {{- if .container  }}{{- if .container.image }}
  {{ $image = .container.image }}
  {{- end -}}{{- end -}}
  {{- $registry := default "docker.io" (default .Values.image.registry $image.registry) -}}
  {{- $repository := $image.repository -}}
  {{/* omitting the tag assumes "latest" */}}
  {{- $tag := (default .Values.image.tag $image.tag) | toString -}}
  {{- if .Values.global }}
    {{- if .Values.global.imageRegistry }}
      {{- printf "%s/%s:%s" .Values.global.imageRegistry $repository $tag -}}
    {{- else -}}
      {{- printf "%s/%s:%s" $registry $repository $tag -}}
    {{- end -}}
  {{- else -}}
    {{- printf "%s/%s:%s" $registry $repository $tag -}}
  {{- end -}}
{{- end -}}