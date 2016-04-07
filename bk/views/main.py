#coding:utf-8
from flask import Flask, render_template, request, redirect, url_for, Blueprint
import json, requests

app = Blueprint("main", __name__, url_prefix="/")

###API Endpoints
##bitFlyer
api_bitflyer = 'https://api.bitflyer.jp/v1/'
#https://lightning.bitflyer.jp/docs?lang=ja#http-public-api
#https://lightning.bitflyer.jp/docs/playground?lang=ja

##zaif
api_zaif = 'https://api.zaif.jp/api/1/'
#https://corp.zaif.jp/api-docs/

##coincheck
api_coincheck = 'https://coincheck.jp/'
#https://coincheck.jp/documents/exchange/api?locale=ja

##btcbox
api_btcbox = 'https://www.btcbox.co.jp/api/v1/'
#https://www.btcbox.co.jp/help/api.html


##JSON Reader
def sendreq(serv, queryurl):
	if serv == 'bf':
		endpoint = api_bitflyer
	elif serv == 'zaif':
		endpoint = api_zaif
	elif serv == 'coin':
		endpoint = api_coincheck
	elif serv == 'btcbox':
		endpoint = api_btcbox
	else:
		print 'Endpoint not found.'
	res = requests.get(endpoint + queryurl)
	return res.json()

#HTTP Status Code
def getstatus(queryurl):
	getstatusans = u'不明'
	buttoncolor = 'default'
	target = requests.get(queryurl)
	r = target.status_code
	if r == 200:
		getstatusans = 'HTTP' + str(r) + ' OK'
		buttoncolor = 'success'
	elif r == 400:
		getstatusans = 'HTTP' + str(r) + ' Bad Request'
		buttoncolor = 'default'
	elif r == 403:
		getstatusans = 'HTTP' + str(r) + ' Forbidden'
		buttoncolor = 'warning'
	elif r == 404:
		getstatusans = 'HTTP' + str(r) + ' Not Found'
		buttoncolor = 'danger'
	else:
		getstatusans = u'正常に取得出来ませんでした。'
		buttoncolor = 'warning'
	return getstatusans, buttoncolor

##稼働状況
#bitFlyer
def gethealth_bf():
	target = sendreq('bf', 'gethealth')
	parseinfo = target['status']
	bf_healthans = parseinfo
	if parseinfo == 'NORMAL':
		bf_healthans = u'取引所は稼動しています。'
		bf_buttoncolor = 'success'
	elif parseinfo == 'BUSY':
		bf_healthans = u'取引所に負荷がかかっている状態です。'
		bf_buttoncolor = 'default'
	elif parseinfo == 'VERY BUSY':
		bf_healthans = u'負荷が大きい状態です。発注は失敗するか、遅れて処理される可能性があります。'
		bf_buttoncolor = 'warning'
	elif parseinfo == 'STOP':
		bf_healthans = u'取引所は停止しています。発注は受付されません。'
		bf_buttoncolor = 'danger'
	else:
		bf_healthans = u'正常に取得出来ませんでした。'
		bf_buttoncolor = 'danger'
	return bf_healthans, bf_buttoncolor

#zaif
def gethealth_zaif():
	zaif_healthans, zaif_buttoncolor = getstatus('https://zaif.jp')
	return zaif_healthans, zaif_buttoncolor

#coincheck
def gethealth_coin():
	coin_healthans, coin_buttoncolor = getstatus('https://coincheck.jp')
	return coin_healthans, coin_buttoncolor

#btcbox
def gethealth_btcbox():
	btcbox_healthans, btcbox_buttoncolor = getstatus('https://www.btcbox.co.jp')
	return btcbox_healthans, btcbox_buttoncolor

##板情報
#bitFlyer - 売り
def getboard_bid_bf():
	target = sendreq('bf', 'getboard')
	parseinfo = target['bids']
	bf_getboardbidans = parseinfo
	return bf_getboardbidans

#bitFlyer - 買い
def getboard_ask_bf():
	target = sendreq('bf', 'getboard')
	parseinfo = target['asks']
	bf_getboardaskans = parseinfo
	return bf_getboardaskans

#zaif - 売り
def getboard_bid_zaif():
	target = sendreq('zaif', 'depth/btc_jpy')
	parseinfo = target['bids']
	zaif_getboardbidans = parseinfo
	return zaif_getboardbidans

#zaif - 買い
def getboard_ask_zaif():
	target = sendreq('zaif', 'depth/btc_jpy')
	parseinfo = target['asks']
	zaif_getboardaskans = parseinfo
	return zaif_getboardaskans

#coincheck - 売り
def getboard_bid_coin():
	target = sendreq('coin', 'api/order_books')
	parseinfo = target['bids']
	coin_getboardbidans = parseinfo
	return coin_getboardbidans

#coincheck - 買い
def getboard_ask_coin():
	target = sendreq('coin', 'api/order_books')
	parseinfo = target['asks']
	coin_getboardaskans = parseinfo
	return coin_getboardaskans

#btcbox - 売り
def getboard_bid_btcbox():
	target = sendreq('btcbox', 'depth/')
	parseinfo = target['bids']
	btcbox_getboardbidans = parseinfo
	return btcbox_getboardbidans

#btcbox - 買い
def getboard_ask_btcbox():
	target = sendreq('btcbox', 'depth/')
	parseinfo = target['asks']
	btcbox_getboardaskans = parseinfo
	return btcbox_getboardaskans


#総合 - 売り
# def getboard_bid_all():
# 	allbids = []
# 	bf_getboardbid = getboard_bid_bf()
#	b = map(lambda x: dict(name='Yahoo', **x), bf_getboardbid)


# 	zaif_pre_named = getboard_bid_zaif()
# 	zaif_namedlist =
#このタイプは最初にdにして次にd2でディクショナリにする
#d = map(lambda x: ['Yahoo']+x, c)
#d2 = [dict(name=i[0],price=i[1],amount=i[2]) for i in zaif_pre_named]

# 	coin_pre_named = getboard_bid_coin()
# 	btcbox_pre_named = getboard_bid_btcbox()


# bf_getboardaskans = getboard_ask_bf()
# zaif_getboardaskans = getboard_ask_zaif()
# coin_getboardaskans = getboard_ask_coin()
# btcbox_getboardaskans = getboard_ask_btcbox()




##Ticker
#bitFlyer -
def ticker_bf():
	target = sendreq('bf', 'getticker')
	bf_ticker_best_bid = target['best_bid']
	bf_ticker_best_ask = target['best_ask']
	bf_ticker_best_bid_size = target['best_bid_size']
	bf_ticker_best_ask_size = target['best_ask_size']
	bf_ticker_time = target['timestamp']
	return bf_ticker_best_bid, bf_ticker_best_ask, bf_ticker_best_bid_size, bf_ticker_best_ask_size, bf_ticker_time




#Rendering
@app.route('/')
def index():
#General settings
	title = 'Panorama'
#健康情報
	bf_healthans, bf_buttoncolor = gethealth_bf()
	zaif_healthans, zaif_buttoncolor = gethealth_zaif()
	coin_healthans, coin_buttoncolor = gethealth_coin()
	btcbox_healthans, btcbox_buttoncolor = gethealth_btcbox()
#板情報
	bf_getboardbidans = getboard_bid_bf()
	bf_getboardaskans = getboard_ask_bf()
	zaif_getboardbidans = getboard_bid_zaif()
	zaif_getboardaskans = getboard_ask_zaif()
	coin_getboardbidans = getboard_bid_coin()
	coin_getboardaskans = getboard_ask_coin()
	btcbox_getboardbidans = getboard_bid_btcbox()
	btcbox_getboardaskans = getboard_ask_btcbox()
#Ticker
	bf_ticker_best_bid, bf_ticker_best_ask, bf_ticker_best_bid_size, bf_ticker_best_ask_size, bf_ticker_time = ticker_bf()

#Return
	return render_template('index.html', title=title, bf_ticker_best_bid=bf_ticker_best_bid, bf_ticker_best_ask=bf_ticker_best_ask, bf_ticker_best_bid_size=bf_ticker_best_bid_size, bf_ticker_best_ask_size=bf_ticker_best_ask_size, bf_ticker_time=bf_ticker_time, btcbox_getboardaskans=btcbox_getboardaskans, zaif_buttoncolor=zaif_buttoncolor, coin_buttoncolor=coin_buttoncolor, btcbox_buttoncolor=btcbox_buttoncolor, btcbox_getboardbidans=btcbox_getboardbidans, btcbox_healthans=btcbox_healthans, coin_getboardaskans=coin_getboardaskans, coin_getboardbidans=coin_getboardbidans, coin_healthans=coin_healthans, zaif_getboardaskans=zaif_getboardaskans, zaif_getboardbidans=zaif_getboardbidans, bf_buttoncolor=bf_buttoncolor, zaif_healthans=zaif_healthans, bf_healthans=bf_healthans, bf_getboardbidans=bf_getboardbidans, bf_getboardaskans=bf_getboardaskans)
