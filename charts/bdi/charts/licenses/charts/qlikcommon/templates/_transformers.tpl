{{- define "common.transformers" -}}
{{- $fullname := include "common.fullname" . -}}
{{- $root := . -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- $release := .Release.Name -}}
{{- $commonSecretList := list "mongodbUri" "redisUri" "redisPassword" -}}
{{ $secrets := .Values.secrets}}
{{- if .container  }}{{- if .container.secrets }}
{{ $secrets = .container.secrets}}
{{- end -}}{{- end -}}
{{- if $secrets -}}
{{- range $key, $value := $secrets.stringData }}
{{- if has $key $commonSecretList -}}{{- if not (contains $name $release) }}
{{- $fullname = $release -}}
{{- end }}{{- end }}
- {{ template "common.envvar.value" (list (print $key "_FILE" | snakecase | upper) ( print "/run/secrets/qlik.com/" $fullname ( print "/" $key ) )) }}
{{- $fullname = include "common.fullname" $root -}}
{{- end }}
{{- range $key, $value := $secrets.data }}
{{- if has $key $commonSecretList -}}{{- if not (contains $name $release) }}
{{- $fullname = $release -}}
{{- end }}{{- end }}
- {{ template "common.envvar.value" (list (print $key "_FILE" | snakecase | upper) ( print "/run/secrets/qlik.com/" $fullname ( print "/" $key ) )) }}
{{- $fullname = include "common.fullname" $root -}}
{{- end }}
{{- end }}
{{ $configs := .Values.configs}}
{{- if .container  }}{{- if .container.configs }}
{{ $configs = .container.configs}}
{{- end -}}{{- end -}}
{{- if $configs -}}
{{- range $key, $value := $configs.data }}
- {{ template "common.envvar.configmap" (list (print $key | snakecase | upper) $fullname $key  ) }}
{{- end }}
{{- range $key, $value := $configs }}
{{- if ne $key "data" }}
- {{ template "common.envvar.value" (list (print $key | snakecase | upper) $value ) }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}
