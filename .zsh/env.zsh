export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/snap/bin
export PATH="$HOME/.local/bin:$PATH"

# SSH tunnel alias
ssht() { ssh -N -L "${2}:localhost:${2}" "${1}"; }
