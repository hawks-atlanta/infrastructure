# Production

terraform -chdir=environments/production init
terraform -chdir=environments/production apply -var "kubeconfig_path=$ENV:KUBECONFIG"