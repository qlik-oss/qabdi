{{- define "common.networkpolicy.podSelection" -}}
  {{- $root := index . 0 -}}
  {{- $key := index . 1 -}}
  {{- $value := index . 2 -}}
  {{- $appRelease :=  $root.Release.Name -}}
  {{- $appNamespace := $root.Release.Namespace -}}
  {{- $appLabel := "" -}}
  {{- $additionalPodLabels :=  "" -}}
  {{- if contains "redis" $key -}}
  {{- $appLabel = printf "%s" ( tpl $value $root ) | regexFind "//.*:" | trimAll ":" | trimAll "/" | replace (printf "%s-" $appRelease)  "" | replace  "-master"  "" }}
  {{- else }}
  {{- $appLabel = printf "%s" (kebabcase $key) | replace "-uri"  "" }}
  {{- end }}
  {{- $appPort := printf "%s" ( tpl $value $root ) | regexFind ":[0-9][0-9][0-9][0-9]+" | trimAll ":" }}
  {{- if $root.Values.networkPolicy.podSelections }}{{- if index $root.Values.networkPolicy.podSelections $appLabel  }}
  {{- $appRelease = index $root.Values.networkPolicy.podSelections $appLabel  "release" | default $appRelease }}
  {{- $appNamespace = index $root.Values.networkPolicy.podSelections $appLabel  "namespace" | default $appNamespace }}
  {{- $additionalPodLabels = index $root.Values.networkPolicy.podSelections $appLabel  "additionalPodLabels" | default $additionalPodLabels }}
  {{- end }}{{- end }}
  - to:
    - podSelector:
        matchLabels:
          app: {{ $appLabel }}
          release: {{ $appRelease | quote }}
          {{- if $additionalPodLabels -}}
          {{- range $key, $val := $additionalPodLabels }}
          {{ $key }}: {{ $val | quote }}
          {{- end}}
          {{- end}}
      namespaceSelector:
        matchLabels:
          name: {{ $appNamespace | quote }}
    ports:
      - protocol: TCP
        port: {{ $appPort }}
{{- end -}}

{{- define "common.networkpolicy.blockedCidr" -}}
{{- $root := . -}}
{{ $root = unset $root "defaultBlockedCidrs" }}
{{ $root = unset $root "allBlockedCidrs" }}

{{- if $root.Values.networkPolicy }}{{- if $root.Values.networkPolicy.ipBlock }}
{{- $allBlockedCidrs := list }}

{{- if $root.Values.networkPolicy.ipBlock.blockedCidrs.defaultBlock }}
{{- $defaultBlockedCidrs := list "100.64.0.0/10" "10.0.0.0/8" "169.254.0.0/16" "172.16.0.0/12" "192.168.0.0/16" "127.0.0.0/8" "0.0.0.0/32" }}
{{ $root = set $root "defaultBlockedCidrs" $defaultBlockedCidrs }}
{{- $allBlockedCidrs = $defaultBlockedCidrs }}
{{- end }}

{{ range $root.Values.networkPolicy.ipBlock.blockedCidrs.additionalBlockedCidrs }}
{{ $allBlockedCidrs = append $allBlockedCidrs . }}
{{- end }}

{{ $root = set $root "allBlockedCidrs" $allBlockedCidrs }}
{{- end }}{{- end }}
{{- end -}}
