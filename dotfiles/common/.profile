export SSH_AUTH_SOCK=~/.ssh/ssh-agent.$HOSTNAME.sock
rm $SSH_AUTH_SOCK
ssh-add -l 2>/dev/null >/dev/null
if [ $? -ge 2 ]; then
    ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null
fi
