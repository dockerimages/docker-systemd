systemd
=======

This is a Ubuntu Baseimage Running SystemD Init System inside a container it can idealy be applyed over any other ubuntu or fedora img

         $ docker run -it --cap-add SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro 444c127c995b /lib/systemd/systemd   systemd.unit=emergency.service
         
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

need CAP_SYS_ADMIN capability you can add --privileged true or as in the example above --caps-add SYS_ADMIN

Looking at what I had done to prevent this in virt-sandbox-service, I saw that I needed to remove unit file links from the /lib/systemd/system/*wants/ and  /etc/systemd/system/*wants/ directories within a systemd based docker container.  Removing these links got me to a systemd container image that would only run systemd and journald.



         $ docker run -it --cap-add SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro dockerimages/docker-systemd " "
         systemd 218 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
         Detected virtualization 'docker'.
         Detected architecture 'x86-64'.
         
         Welcome to Ubuntu Vivid Vervet (development branch)!
         Set hostname to <779527c86cc8>.
         Cannot add dependency job for unit display-manager.service, ignoring: Unit display-manager.service failed to load: No such file or directory.
         [  OK  ] Created slice Root Slice.
         [  OK  ] Listening on Delayed Shutdown Socket.
         [  OK  ] Listening on Journal Socket (/dev/log).
         [  OK  ] Listening on Journal Audit Socket.
         [  OK  ] Listening on Journal Socket.
         [  OK  ] Reached target Paths.
         [  OK  ] Reached target Sockets.
         [  OK  ] Reached target Swap.
         [  OK  ] Created slice System Slice.
         Starting (null)...
         [  OK  ] Reached target Slices.
         [ INFO ] Update UTMP about System Boot/Shutdown is not active.
         [DEPEND] Dependency failed for Update UTMP about System Runlevel Changes.
         Job systemd-update-utmp-runlevel.service/start failed with result 'dependency'.
         [  OK  ] Started (null).
         Starting Journal Service...
         [  OK  ] Reached target Local File Systems.
         Starting LSB: Raise network interfaces....
         [  OK  ] Started Journal Service.
         [  OK  ] Started LSB: Raise network interfaces..
         [  OK  ] Reached target Network.
         [  OK  ] Reached target System Initialization.
         [  OK  ] Reached target Basic System.
         Starting LSB: Set the CPU Frequency Scaling governor to "ondemand"...
         Starting /etc/rc.local Compatibility...
         [  OK  ] Reached target Timers.
         Starting Cleanup of Temporary Directories...
         [  OK  ] Started /etc/rc.local Compatibility.
         [  OK  ] Started Cleanup of Temporary Directories.
         [  OK  ] Started LSB: Set the CPU Frequency Scaling governor to "ondemand".
         [  OK  ] Reached target Multi-User System.
         [  OK  ] Reached target Graphical Interface.


# example nginx img using systemd to start :D

         docker build -t dockerimages/docker-nginx-systemd - <<EOF
         FROM dockerimages/docker-systemd
         RUN apt-get install -y nginx; apt-get clean; systemctl enable nginx.service
         EXPOSE 80
         CMD [“/lib/systemd/systemd”]
         EOF


or simply directly :D

         docker run --cap-add SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 dockerimages/docker-nginx-systemd


thats it have fun with systemd
