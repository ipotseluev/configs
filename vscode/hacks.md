
## How to execute with sudo remote debug session (it's not working)

I used debug extension vadimcn.vscode-lldb

1. Replace lldb executable with the script which raises priviledges
```
# Might be different in your case
ADAPTER_DIR=.vscode-server/extensions/vadimcn.vscode-lldb-1.9.0/adapter/
cd ${ADAPTER_DIR}
mv codelldb codelldb-real
echo "sudo pkexec $(readlink -f $(dirname $0))/codelldb-real \"$@\"" > codelldb
```

2. Enable passwordless sudo for pkexec (see https://askubuntu.com/questions/159007/how-do-i-run-specific-sudo-commands-without-a-password)
```
sudo visudo
# Add the following string:
# sam ipotseluev-hetzner = (root) NOPASSWD: /usr/bin/pkexec
```
