window.NxtBrt ?= {}

window.NxtBrt.displayEtdsFor = (stationAbbr,kioskMode)->
  stationName = if kioskMode 
    undefined
  else
    station = NxtBrt.lookupStationByAbbr(stationAbbr)
    station.name

  estimates = React.renderComponent(
    NxtBrt.EstimatesList(stationName:stationName),
    document.getElementById('etds'),
    (-> $('#etds').show())
  );

  refresh = ->
    NxtBrt.showToast('loading departure times...')

    NxtBrt.loadEtds(stationAbbr).then (etds)-> 
      estimates.setState({etds})
      NxtBrt.hideToast()

  refresh()

  # in kiosk mode, refresh every 10 seconds
  if kioskMode
    window.setInterval(refresh,10000)
