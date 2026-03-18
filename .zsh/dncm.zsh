# kubectl aliases and completions
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
  alias k='kubectl'
  complete -F __start_kubectl k
fi

alias calm0="kubectl exec -it -n ntnx-ncm-self-service ncm-calm-0 -- bash"
alias calm1="kubectl exec -it -n ntnx-ncm-self-service ncm-calm-1 -- bash"
alias calm2="kubectl exec -it -n ntnx-ncm-self-service ncm-calm-2 -- bash"
alias eps0="kubectl exec -it -n ntnx-ncm-common ncm-epsilon-0 -- bash"
alias eps1="kubectl exec -it -n ntnx-ncm-common ncm-epsilon-1 -- bash"
alias eps2="kubectl exec -it -n ntnx-ncm-common ncm-epsilon-2 -- bash"
alias dm0="kubectl exec -it -n domain-manager domain-manager-0 -- bash"
alias dm1="kubectl exec -it -n domain-manager domain-manager-1 -- bash"
alias logs="kubectl exec -it -n ntnx-system fluentd-aggregator-0 -- sh -c 'cd /fluentd/data/logs && exec sh'"
alias ssidf="kubectl port-forward -n ntnx-ncm-datastore svc/ss-idf 12027:2027"
alias dmidf="kubectl port-forward -n domain-manager svc/idf 12027:2027"
alias sspg="kubectl port-forward service/ncm-ss-cnpg-rw 5433:5432 -n ntnx-ncm-datastore"
alias iampg="kubectl port-forward service/nc-pg-rw 5432:5432 -n nc-system"
alias iamsecret="kubectl edit secret -n nc-system nc-pg-app"
alias pf_zaffi="kubectl port-forward service/ncm-epsilon 4120:4120 -n ntnx-ncm-common"

psql_iam() {
    # Extract and decode JDBC URI
    local uri
    uri=$(kubectl get secret -n nc-system nc-pg-app -o json \
          | jq -r '.data["jdbc-uri"] | @base64d')

    # Extract user and password (works regardless of order)
    local user pass
    user=$(echo "$uri" | grep -oP 'user=\K[^&]+')
    pass=$(echo "$uri" | grep -oP 'password=\K[^&]+')

    # Build PostgreSQL URI with localhost and iam
    local pg_uri="postgresql://$user:$pass@localhost:5432/iam"

    # Call psql with any extra arguments
    psql "$pg_uri" "$@"
}
