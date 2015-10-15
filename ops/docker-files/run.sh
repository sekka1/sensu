#!/bin/bash



# Run sensu-server
/opt/sensu/embedded/bin/ruby /opt/sensu/bin/sensu-server -b -c /etc/sensu/config.json -d /etc/sensu/conf.d -e /etc/sensu/extensions -p /var/run/sensu/sensu-server.pid -l /var/log/sensu/sensu-server.log -L info

# Run sensu-api
/opt/sensu/embedded/bin/ruby /opt/sensu/bin/sensu-api -b -c /etc/sensu/config.json -d /etc/sensu/conf.d -e /etc/sensu/extensions -p /var/run/sensu/sensu-api.pid -l /var/log/sensu/sensu-api.log -L info


