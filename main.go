package main

import (
	"net/http"

	"github.com/yongchengchen/wsproxy/app/api"

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gctx"
	"github.com/sirupsen/logrus"
)

func main() {
	cx := gctx.New()
	m, _ := g.Cfg().Get(cx, "listenon", true)
	pHost, _ := g.Cfg().Get(cx, "proxytohost", true)
	pPath, _ := g.Cfg().Get(cx, "proxytopath", true)
	ChkRegTime, _ := g.Cfg().Get(cx, "chkregtime", true)

	api.WsProxyToHost = pHost.String()
	api.WsProxyToPath = pPath.String()
	api.ChkRegTime = ChkRegTime.Int()

	http.HandleFunc("/pub/chat", api.WsProxy)
	logrus.Println("Listen on ", m.String())
	http.ListenAndServe(m.String(), nil)
}
