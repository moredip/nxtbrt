NxtBrt = window.NxtBrt

hideEverything = ->
  $('body > article').hide()

handleHash = ->
  route = window.location.hash.substring(1)
  ga('send', 'pageview', { 'page': route }) # we're a single page app. Track fragments instead

  hideEverything()

  if route == ""
    NxtBrt.displayStations()
  else
    NxtBrt.displayEtdsFor(route)

window.onhashchange = handleHash

$(handleHash)
