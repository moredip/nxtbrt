window.NxtBrt ?= {}

window.NxtBrt.humanMinutes = (min)->
  if min == 0
    "now"
  else if min == 1
    "1 min"
  else
    "#{min} mins"


window.NxtBrt.displayEtdsFor = (stationAbbr)->
  station = NxtBrt.lookupStationByAbbr(stationAbbr)

  estimates = React.renderComponent(
    NxtBrt.EstimatesList(stationName:station.name),
    document.getElementById('etds'),
    (-> $('#etds').show())
  );

  NxtBrt.showToast('finding departure times...')

  NxtBrt.loadEtds(stationAbbr).then (etds)-> 
    estimates.setState({etds})
    NxtBrt.hideToast()
