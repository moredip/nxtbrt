window.NxtBrt ?= {}

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
