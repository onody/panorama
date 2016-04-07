var chart = c3.generate({
    data: {
        columns: [
			["bitFlyer {{ bf_24volans|round(2) }}", {{ bf_24volans }}],
			["zaif {{ zaif_24volans|round(2) }}", {{ zaif_24volans }}],
			["coincheck {{ coin_24volans|float|round(2) }}", {{ coin_24volans }}],
			["BTCBOX {{ btcbox_24volans|round(2) }}", {{ btcbox_24volans }}]
        ],
        type : 'donut',
        onclick: function (d, i) { console.log("onclick", d, i); },
        onmouseover: function (d, i) { console.log("onmouseover", d, i); },
        onmouseout: function (d, i) { console.log("onmouseout", d, i); }
    },
color: {
  pattern: ['#4692d1', '#1d5b9d', '#00c8d7', '#ffa300']
},
    donut: {
        title: "Iris Petal Width"
    }
});
