FROM engency/webserver:${tag}-base

#include 20.composer.Dockerfile
#include 80.opcache.Dockerfile
#include 85.node.Dockerfile
#include 90.headless-chrome.Dockerfile

CMD ["/usr/sbin/apache2ctl", "-e", "info", "-D", "FOREGROUND"]
