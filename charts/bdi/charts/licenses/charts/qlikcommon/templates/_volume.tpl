{{- define "common.volume.configmap" -}}
{{- $name := index . 0 -}}
{{- $volume := index . 1 -}}

name: {{ $name }}
configMap:
{{- if kindIs "map" $volume }}
  name: {{ $volume.configMapName }}
  {{- if $volume.items }}
  items:
  {{- range $volume.items }}
  - key: {{ .key }}
    path: {{ .path }}
  {{- end }}
  {{- end }}
{{- else }}
  name: {{ $volume }}-configs
{{- end }}
{{- end -}}


{{- define "common.volume.secret" -}}
{{- $name := index . 0 -}}
{{- $volume := index . 1 -}}

name: {{ $name }}
secret:
{{- if kindIs "map" $volume }}
  secretName: {{ $volume.secretName }}
  {{- if $volume.items }}
  items:
  {{- range $volume.items }}
  - key: {{ .key }}
    path: {{ .path }}
  {{- end }}
  {{- end }}
{{- else }}
  secretName: {{ $volume }}-secrets
{{- end }}
{{- end }}

{{- define "common.volume.pvc" -}}
{{- $name := index . 0 -}}
{{- $claimName := index . 1 -}}
{{- $existingClaim := index . 2 -}}

name: {{ $name }}
persistentVolumeClaim:
  claimName: {{ $existingClaim | default $claimName }}
{{- end -}}

{{- define "common.volume.emptydir" -}}
{{- $name := index . 0 -}}

name: {{ $name }}
emptyDir: {}
{{- end -}}

{{- define "common.volume.hostpath" -}}
{{- $name := index . 0 -}}
{{- $volume := index . 1 -}}

name: {{ $name }}
hostPath:
  path: {{ $volume.path }}
  type: {{ $volume.type }}
{{- end -}}

{{- define "common.volume.mount" -}}
{{- $volume := index . 0 -}}
{{- $mountPath := index . 1 -}}
{{- if kindIs "slice" $mountPath.mountPath }}
{{- range $mountPath.mountPath }}
- name: {{ $volume }}
  mountPath: {{ default "/tmp" . | quote }}
  readOnly: {{ default false $mountPath.readOnly }}
{{- end -}}
{{- else -}}
- name: {{ $volume }}
  mountPath: {{ default "/tmp" $mountPath.mountPath | quote }}
  readOnly: {{ default false $mountPath.readOnly }}
{{- end -}}
{{- end -}}
