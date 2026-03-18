# kubectl aliases and completions
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
  alias k='kubectl'
  complete -F __start_kubectl k
fi
