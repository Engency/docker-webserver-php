FROM engency/webserver:${tag}-base

#include 80.opcache.Dockerfile

CMD ["/usr/sbin/apache2ctl", "-e", "info", "-D", "FOREGROUND"]
