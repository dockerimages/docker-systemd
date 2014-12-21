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
`````

need CAP_SYS_ADMIN capability

Looking at what I had done to prevent this in virt-sandbox-service, I saw that I needed to remove unit file links from the /lib/systemd/system/*wants/ and  /etc/systemd/system/*wants/ directories within a systemd based docker container.  Removing these links got me to a systemd container image that would only run systemd and journald.

# example nginx img using systemd to start :D
`````
docker build -t dockerimages/docker-nginx-systemd - <<EOF
FROM dockerimages/docker-systemd
RUN apt-get install -y nginx; apt-get clean; systemctl enable nginx.service
EXPOSE 80
CMD [“/lib/systemd/systemd”]
EOF
`````

or simply directly :D
`````
docker run –privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 dockerimages/docker-nginx-systemd
`````

thats it have fun with systemd
