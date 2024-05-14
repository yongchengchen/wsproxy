# Websocket Proxy

## build
run go build to build the binary

## Configs
edit these nodes below from the config/config.yaml file:
```yml
listenon: 192.168.1.159:7788
listenpath: /pub/chat
proxytohost: proxyto.local.test
proxytopath: /pub/chat
#chkregtime milliseconds
chkregtime: 500
```

## run
debug mode, will print proxy message details
```shell
./wsproxy -debug 
```
run mode, without output debug info
```shell
./wsproxy 
```