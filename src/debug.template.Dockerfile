FROM engency/webserver:${tag}-base

#include 20.composer.Dockerfile
#include 81.xdebug.Dockerfile

CMD ["/usr/sbin/apache2ctl", "-e", "info", "-D", "FOREGROUND"]
