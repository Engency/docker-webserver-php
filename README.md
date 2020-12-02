<p align="center"><a href="https://www.engency.com" target="_blank"><img src="engency.png?raw=true" width="400" alt="Engency Logo"></a></p>

# docker webserver with PHP

[![CircleCI](https://circleci.com/gh/Engency/docker-webserver-php/tree/master.svg?style=shield)](https://app.circleci.com/pipelines/github/Engency/docker-webserver-php)

All images include;

- php 8.0 with APCu, pdo, mysql, sqlite, gd, tidy
- apache 2.4 with mod_rewrite
- git client
- the Dutch language
- timezone set to Amsterdam

## How to use

In a dockerfile

```dockerfile
FROM engency/webserver:1.0
```

-or- In a docker-compose yaml file

```yaml
services:
  webserver:
    image: engency/webserver:1.0
    volumes:
      - .:/var/www/html
    ports:
      - "80:80"
```

## List of available images

- engency/webserver:{version}
- engency/webserver:{version}-npm
- engency/webserver:{version}-npm-chrome
- engency/webserver:{version}-debug
- engency/webserver:{version}-debug-npm
- engency/webserver:{version}-debug-npm-chrome

### Non-debug images include;

- opcache, JIT compiler

### Debug images include;

- xdebug

### Environment variables;

|variable|images|description|default|
|---|---|---|---|
|XDEBUG_CONFIG|^debug.*|Add values to xdebug configuration.|client_host=172.17.0.1|
|PHP_IDE_CONFIG|^debug.*|Custom configuration for use with IDEs. For instance, name the service so that phpstorm will recognise it in a debugging session.|serverName=webserver|