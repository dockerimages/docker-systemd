FROM ubuntu:15.04
# You can change the FROM Instruction to your existing images if you like and build it with same tag
ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'APT::Install-Recommends "0"; \n\
APT::Get::Assume-Yes "true"; \n\
APT::Get::force-yes "true"; \n\
APT::Install-Suggests "0";' > /etc/apt/apt.conf.d/01buildconfig
RUN mkdir -p  /etc/apt/sources.d/
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt vivid main restricted universe multiverse \n\
deb mirror://mirrors.ubuntu.com/mirrors.txt vivid-updates main restricted universe multiverse \n\
deb mirror://mirrors.ubuntu.com/mirrors.txt vivid-backports main restricted universe multiverse \n\
deb mirror://mirrors.ubuntu.com/mirrors.txt vivid-security main restricted universe multiverse" > /etc/apt/sources.d/ubuntu-mirrors.list
RUN apt-get update && apt-get install systemd
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*; \
rm -f /lib/systemd/system/plymouth*; \
rm -f /lib/systemd/system/systemd-update-utmp*;
# rm -f /lib/systemd/system/graphical.target;
# rm -f /lib/systemd/system/default.target
RUN systemctl set-default multi-user.target
ENV init /lib/systemd/systemd
COPY init /sbin/init
RUN chmod +x /sbin/init
VOLUME [ "/sys/fs/cgroup" ]
# docker run -it --privileged=true -v /sys/fs/cgroup:/sys/fs/cgroup:ro 444c127c995b /lib/systemd/systemd systemd.unit=emergency.service
CMD ["/sbin/init"]
#CMD ["systemd.unit=emergency.service"]
