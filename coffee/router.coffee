NxtBrt = window.NxtBrt

hideEverything = ->
  $('body > article').hide()

handleHash = ->
  hideEverything()
  route = window.location.hash.substring(1)
  if route == ""
    NxtBrt.displayStations()
  else
    NxtBrt.displayEtdsFor(route)

window.onhashchange = handleHash

$(handleHash)
