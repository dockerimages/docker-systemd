systemd
=======

This is a Ubuntu Baseimage Running SystemD Init System inside a container it can idealy be applyed over any other ubuntu or fedora img
````
$ docker run -it --privileged=true -v /sys/fs/cgroup:/sys/fs/cgroup:ro 444c127c995b /lib/systemd/systemd   systemd.unit=emergency.service
systemd 218 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
Detected virtualization 'docker'.
Detected architecture 'x86-64'.

Welcome to Ubuntu Vivid Vervet (development branch)!

Set hostname to <502ec40509a5>.
[  OK  ] Created slice Root Slice.
[  OK  ] Created slice System Slice.
         Starting Emergency Shell...
[  OK  ] Started Emergency Shell.
Startup finished in 5ms.
Welcome to emergency mode! After logging in, type "journalctl -xb" to view
system logs, "systemctl reboot" to reboot, "systemctl default" or ^D to
try again to boot into default mode.
root@502ec40509a5:~# exit
