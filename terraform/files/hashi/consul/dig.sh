#!/bin/bash

#dig @localhost -p 8600 mysql.service.consul
dig @localhost -p 8600 mysql.service.consul SRV  #note it is running on 3306

#dig @localhost -p 8600 php.service.consul
dig @localhost -p 8600 php.service.consul SRV
