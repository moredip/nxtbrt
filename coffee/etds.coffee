window.NxtBrt ?= {}

ETD_URL = "http://api.bart.gov/api/etd.aspx"
API_KEY="MW9S-E7SL-26DU-VV8V"

parseMinutes = (minutesString)->
  mins = parseInt(minutesString)
  if isNaN(mins) then 0 else mins

parseEtds = (doc)->
  allEstimates = []
  for etd in doc.getElementsByTagName('etd')
    do (etd)->
      destAbbr = pluckTextFromNode(etd, 'abbreviation')
      destStation = NxtBrt.lookupStationByAbbr(destAbbr)
      for estimates in etd.getElementsByTagName('estimate')
        allEstimates.push(
          dest: destStation
          minutes: parseMinutes(pluckTextFromNode(estimates,'minutes'))
          lineColor: pluckTextFromNode(estimates,'color').toLowerCase()
          length: pluckTextFromNode(estimates,'length')
        )
  allEstimates.sort (a,b)->
    a.minutes - b.minutes
  allEstimates

loadEtds = (stationAbbr)->
  Q($.get( ETD_URL, {cmd: 'etd', orig: stationAbbr, key: API_KEY} ))
    .then(parseEtds)

window.NxtBrt.humanMinutes = (min)->
  if min == 0
    "now"
  else if min == 1
    "1 min"
  else
    "#{min} mins"


window.NxtBrt.displayEtdsFor = (stationAbbr)->
  station = NxtBrt.lookupStationByAbbr(stationAbbr)

  $('#etds').show();
  estimates = React.renderComponent(
    NxtBrt.EstimatesList(stationName:station.name),
    document.getElementById('etds')
  );

  NxtBrt.showToast('finding departure times...')

  loadEtds(stationAbbr).then (etds)-> 
    estimates.setState({etds})
    NxtBrt.hideToast()
