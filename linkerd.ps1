linkerd check --pre

linkerd install --crds | kubectl apply -f -

linkerd install | kubectl apply -f -

kubectl get -n capyfile-production deploy -o yaml | linkerd inject - | kubectl apply -f -

linkerd -n capyfile-production check --proxy

linkerd viz install | kubectl apply -f -

linkerd check

# linkerd viz dashboard

# kubectl -n capyfile-production port-forward services/authentication-service 8080:8080