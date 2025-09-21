resource "kubectl_manifest" "db_service" {
  depends_on = [kubectl_manifest.db_deployment]
  yaml_body  = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: postgres-db-service
  namespace: lanchonete-db
spec:
  selector:
    app: postgres-db
  ports:
    - protocol: TCP
      port: 5432
      targetPort: 5432

YAML
}