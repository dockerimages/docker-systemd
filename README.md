# [kxes/ubuntu-systemd](https://hub.docker.com/r/kxes/ubuntu-systemd/)

Based on [docker-systemd](https://github.com/dockerimages/docker-systemd), this is Docker image with Ubuntu running systemd init system inside a container.

## Available tags

`15.04` vivid

`15.10` wily

## Starting a shell with systemd

```
docker run -it --cap-add SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro kxes/ubuntu-systemd systemd.unit=emergency.service
```

You need CAP_SYS_ADMIN capability (as in the example above `--caps-add SYS_ADMIN`) or you can just add `--privileged`.