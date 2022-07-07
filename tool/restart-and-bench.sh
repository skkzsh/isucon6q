#!/bin/bash
set -euvx

sudo truncate -s 0 -c /var/log/nginx/access.log
sudo truncate -s 0 -c /var/log/nginx/error.log
# sudo truncate -s 0 -c /var/log/mysql/mysql-slow.log
# sudo truncate -s 0 -c /var/log/mysql/error.log
# mysqladmin flush-logs

# cd ~/webapp/go
# GOPATH=~/webapp/go make
# sudo systemctl restart isuda.go
# sudo systemctl restart isutar.go

sudo systemctl restart mysql
# sudo ./db/init.sh

sudo systemctl restart nginx

cd ~/isucon6q/
./isucon6q-bench | tee ~/log/bench-$(date +%Y%m%d-%H%M%S).log

sudo cat /var/log/nginx/access.log | alp json --sort avg -r -q --qs-ignore-values -m '^/keyword/.*$' | tee ~/log/alp-$(date +%Y%m%d-%H%M%S).log

# sudo mysqldumpslow /var/log/mysql/mysql-slow.log | tee ~/log/slow-$(date +%Y%m%d-%H%M%S).log
# sudo pt-query-digest /var/log/mysql/mysql-slow.log | tee ~/log/pt-query-digest-$(date +%Y%m%d-%H%M%S).log

# go tool pprof -http=:10060 http://localhost:6060/debug/pprof/profile

