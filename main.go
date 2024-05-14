package main

import (
	"flag"
	"net/http"

	"github.com/yongchengchen/wsproxy/app/api"

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gctx"
	"github.com/sirupsen/logrus"
)

var ()

func main() {
	cx := gctx.New()
	m, _ := g.Cfg().Get(cx, "listenon", true)
	pHost, _ := g.Cfg().Get(cx, "proxytohost", true)
	pPath, _ := g.Cfg().Get(cx, "proxytopath", true)
	lPath, _ := g.Cfg().Get(cx, "listenpath", true)
	ChkRegTime, _ := g.Cfg().Get(cx, "chkregtime", true)

	bDebug := flag.Bool("debug", false, "Output debug message")
	flag.Parse()
	if *bDebug {
		logrus.Println("Debug ", *bDebug)
		logrus.SetLevel(logrus.DebugLevel)
	}

	api.WsProxyToHost = pHost.String()
	api.WsProxyToPath = pPath.String()
	api.ChkRegTime = ChkRegTime.Int()

	http.HandleFunc(lPath.String(), api.WsProxy)
	logrus.Println("Listen on ", m.String()+lPath.String())
	http.ListenAndServe(m.String(), nil)
}
