NxtBrt = window.NxtBrt


hideEverything = ->
  $('body > article').hide()

handleHash = ->
  route = window.location.hash.substring(1)
  ga('send', 'pageview', { 'page': route }) # we're a single page app. Track fragments instead

  hideEverything()
  
  kioskMode = window.location.search.toLowerCase() == "?kiosk"

  if route == ""
    NxtBrt.displayStations()
  else
    NxtBrt.displayEtdsFor(route,kioskMode)

window.onhashchange = handleHash

$(handleHash)
