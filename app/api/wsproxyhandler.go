package api

import (
	"fmt"
	"net/http"
	"net/url"

	// "time"
	"github.com/sirupsen/logrus"

	"github.com/gorilla/websocket"
	"github.com/yongchengchen/wsproxy/app/model"

	"github.com/google/uuid"
)

var chans = make(map[string]chan bool)

var WsProxyToHost = ""
var WsProxyToPath = ""
var ChkRegTime = 0

var upGrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024 * 1024 * 10,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

func WsProxy(w http.ResponseWriter, r *http.Request) {
	fmt.Println("connection comming...")
	var token = uuid.New().String()

	wsConn, err := upGrader.Upgrade(w, r, nil)
	if err != nil {
		// response.JsonExit(r, 500, "Fail to push")
		logrus.Fatal("Fail to push:", err)
		return
	}
	defer wsConn.Close()

	u := url.URL{Scheme: "ws", Host: string(WsProxyToHost), Path: string(WsProxyToPath)}

	logrus.Printf("connecting uplevel server %s", u.String())

	toWsConn, _, err := websocket.DefaultDialer.Dial(u.String(), nil)
	if err != nil {
		logrus.Println("dial:", err)
		return
	}
	defer toWsConn.Close()

	logrus.Printf("start proxy...")
	sws, err := model.NewLogicWSProxySession(wsConn, toWsConn)
	defer sws.Close()

	quitChan := make(chan bool, 3)
	chans[token] = quitChan
	defer delete(chans, token)

	sws.Start(quitChan)
	if ChkRegTime > 0 {
		go sws.CheckReg(quitChan, ChkRegTime)
	}

	<-quitChan

	logrus.Println("wsconnection", "quitChan Exit")
}
