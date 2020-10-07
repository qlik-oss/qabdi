{{- define "common.ca-certificates.volume" -}}
{{- if .Values.certs }}
{{- if .Values.global }}{{- if .Values.global.certs }}
{{- if .Values.global.certs.volume }}
- name: ca-certificates
  {{- if .Values.global.certs.volume.hostPath }}
  hostPath:
    path: {{ .Values.global.certs.volume.hostPath }}
    type: Directory
  {{- end }}
  {{- if .Values.global.certs.volume.existingVolumeClaim }}
  persistentVolumeClaim:
    claimName: {{ .Values.global.certs.volume.existingVolumeClaim  }}
  {{- end }}
{{- else }}
- name: ca-certificates
  persistentVolumeClaim:
    claimName: {{ .Release.Name }}-certs-pvc
{{- end -}}
{{- end -}}{{- end -}}
{{- end -}}
{{- end -}}

{{- define "common.ca-certificates.volumeMount" -}}
{{- if .Values.certs }}
{{- if .Values.global }}{{- if .Values.global.certs }}
- name: ca-certificates
  mountPath: {{ default "/etc/ssl/certs" .Values.certs.mountPath | quote }}
  readOnly: true
{{- end -}}
{{- end -}}{{- end -}}
{{- end -}}