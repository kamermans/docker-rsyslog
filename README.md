# Docker rsyslog container

This container brings rsyslog logging to your other containers.

To use it, simply start it up:

```
docker run -d --name logger kamermans/rsyslog
```

To use local system logging in your own container, you need to use rsyslog's `/var/log` volume, then make a symlink in your container from `/var/log/socket` to `/dev/log`, like this:

```
docker run --rm -ti --volumes-from logger ubuntu:14.04 bash

root@d0205e98fbdc:/# ln -s /var/log/socket /dev/log
root@d0205e98fbdc:/# logger "Let's see if this works"
root@d0205e98fbdc:/# tail /var/log/syslog
May 14 06:09:23 44308781a5b4 rsyslogd: [origin software="rsyslogd" swVersion="8.9.0" x-pid="1" x-info="http://www.rsyslog.com"] start
May 14 06:09:23 44308781a5b4 rsyslogd: rsyslogd's groupid changed to 104
May 14 06:09:23 44308781a5b4 rsyslogd: rsyslogd's userid changed to 101
May 14 06:11:22 44308781a5b4 logger: Let's see if this works
```

TCP and UDP work as well if you link the containers:

```
docker run --rm -ti --volumes-from logger --link logger:logger ubuntu:14.04 bash

root@9f391b72f85d:/# logger -u /foo --udp --server logger "This works too :)"
root@9f391b72f85d:/# tail /var/log/syslog
May 14 06:09:23 44308781a5b4 rsyslogd: [origin software="rsyslogd" swVersion="8.9.0" x-pid="1" x-info="http://www.rsyslog.com"] start
May 14 06:09:23 44308781a5b4 rsyslogd: rsyslogd's groupid changed to 104
May 14 06:09:23 44308781a5b4 rsyslogd: rsyslogd's userid changed to 101
May 14 06:11:22 44308781a5b4 logger: Let's see if this works
May 14 06:17:08 172.17.0.71 <someone>: This works too :)
```

(note: `-u /foo` was used above to work around a bug in the `logger` command)
