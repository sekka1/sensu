![sensu](https://raw.github.com/sensu/sensu/master/sensu-logo.png)

A monitoring framework that aims to be simple, malleable, and scalable.

[![Build Status](https://secure.travis-ci.org/sensu/sensu.png)](https://travis-ci.org/sensu/sensu)

## Documentation
  Please refer to the [Sensu Docs](http://sensuapp.org/docs/latest/overview).

## License
  Sensu is released under the [MIT license](https://raw.github.com/sensu/sensu/master/MIT-LICENSE.txt).

## Running with Docker

  https://www.digitalocean.com/community/tutorials/how-to-configure-sensu-monitoring-rabbitmq-and-redis-on-ubuntu-14-04

### RabbitMQ

    https://hub.docker.com/r/library/rabbitmq/
    
Starting:

    docker run -d \
    --hostname rabbitmq \
    --name rabbitmq \
    -e RABBITMQ_ERLANG_COOKIE='secret-cookie-here' \
    -p 15672:15672 \
    -p 5672:5672 \
    -p 5671:5671 \
    rabbitmq:3.5.6-management
    
web: 

    http://localhost:15672/
    
    user: guest
    password: guest
    
Sensu setup:
    
    docker exec rabbitmq rabbitmqctl add_vhost /sensu
    docker exec rabbitmq rabbitmqctl add_user sensu secret
    docker exec rabbitmq rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
    
Output data dirs?    
    
2015-10-15T16:49:03.726613934Z =INFO REPORT==== 15-Oct-2015::16:49:03 ===
2015-10-15T16:49:03.726619482Z node           : rabbit@37b456140425
2015-10-15T16:49:03.726624154Z home dir       : /var/lib/rabbitmq
2015-10-15T16:49:03.726628278Z config file(s) : /etc/rabbitmq/rabbitmq.config
2015-10-15T16:49:03.726631843Z cookie hash    : uWb4pHQucmvFr1QEkXDfaA==
2015-10-15T16:49:03.726636183Z log            : tty
2015-10-15T16:49:03.726639245Z sasl log       : tty
2015-10-15T16:49:03.726642236Z database dir   : /var/lib/rabbitmq/mnesia/rabbit@37b456140425

### Redis

    https://hub.docker.com/r/library/redis/
    
Starting:

    docker run -d \
    --name redis \
    -p 6380:6380 \
    -p 6379:6379 \
    -v /opt/redis:/data \
    redis:3.0.4 redis-server --appendonly yes

### Sensu
    
Starting:

    docker run -it \
    --name sensu \
    --link rabbitmq:rabbitmq \
    --link redis:redis \
    -p 4567:4567 \
    garland/sensu:dev bash

### Uchiwa

Setup:

    mkdir -p /opt/
    cp ops/uchiwa-config /opt/

Starting:

    docker run -d \
    --name uchiwa \
    -p 3000:3000 \
    --link sensu:sensu \
    -v /opt/uchiwa-config:/config \
    uchiwa/uchiwa
    
### Sending metrics to Grafana??

  https://ianunruh.com/2014/05/monitor-everything-part-4.html
  
### Deal breaker??

After setting all of this up and then going to the dashboard section.  I finally noticed that it is either
use the uchiwa community version which doesnt have critical features such as alert.

The "enterprise" version is $2/server/month

