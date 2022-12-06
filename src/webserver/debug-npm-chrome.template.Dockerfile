FROM engency/webserver:${tag}-base

#include 81.xdebug.Dockerfile
#include 85.node.Dockerfile
#include 90.headless-chrome.Dockerfile

CMD ["/usr/sbin/apache2ctl", "-e", "info", "-D", "FOREGROUND"]
