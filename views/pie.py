#coding:utf-8
from flask import Flask, render_template, request, redirect, url_for, Blueprint
import json, requests

app = Blueprint("pie", __name__, url_prefix="/pie")

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

#bitFlyer - 24時間取引量
def ticker_volume_bf():
	target = sendreq('bf', 'getticker')
	parseinfo = target['volume']
	bf_24volans = parseinfo
	return bf_24volans

#zaif - 24時間取引量
def ticker_volume_zaif():
	target = sendreq('zaif', 'ticker/btc_jpy')
	parseinfo = target['volume']
	zaif_24volans = parseinfo
	return zaif_24volans

#coincheck - 24時間取引量
def ticker_volume_coin():
	target = sendreq('coin', 'api/ticker')
	parseinfo = target['volume']
	coin_24volans = parseinfo
	return coin_24volans

#btcbox - 24時間取引量
def ticker_volume_btcbox():
	target = sendreq('btcbox', 'ticker/')
	parseinfo = target['vol']
	btcbox_24volans = parseinfo
	return btcbox_24volans


@app.route('/')
def pie_volume():
#24時間取引量
	bf_24volans = ticker_volume_bf()
	zaif_24volans = ticker_volume_zaif()
	coin_24volans = ticker_volume_coin()
	btcbox_24volans = ticker_volume_btcbox()
	ttl_24volans = bf_24volans + zaif_24volans + float(coin_24volans) + btcbox_24volans
	return render_template('volume_pie.js', ttl_24volans=ttl_24volans, coin_24volans=coin_24volans, zaif_24volans=zaif_24volans, bf_24volans=bf_24volans, btcbox_24volans=btcbox_24volans,)
