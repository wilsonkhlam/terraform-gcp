#/bin/sh
ssh -N -i ../private/vnc_ssh.key -L 5901:127.0.0.1:5901 vncadmin@$1
