ETD_URL = "http://api.bart.gov/api/etd.aspx"
API_KEY="MW9S-E7SL-26DU-VV8V"
# STATIONS_URL = "http://api.bart.gov/api/etd.aspx?cmd=etd&orig=RICH&key="


parseEtds = (doc)->
  allEstimates = []
  for etd in doc.getElementsByTagName('etd')
    do (etd)->
      dest = pluckTextFromNode(etd, 'abbreviation')
      for estimates in etd.getElementsByTagName('estimate')
        allEstimates.push(
          dest: dest
          minutes: pluckTextFromNode(estimates,'minutes')
          platform: pluckTextFromNode(estimates,'minutes')
          length: pluckTextFromNode(estimates,'length')
        )
  allEstimates
  [
    {
      dest: "FOO",
      minutes: "12"
    },
    {
      dest: "BAR",
      minutes: "22"
    }
  ]

displayEtds = (estimates)->
  $list = $("<ul>")
  estimates.forEach (e)->
    $("<li>").text("#{e.dest}: #{e.minutes}").appendTo($list)
  $('.etds').empty().append($list)

etdsForStation = (stationAbbr)->
  Q($.get( ETD_URL, {cmd: 'etd', orig: stationAbbr, key: API_KEY} ))
    .then( parseEtds )

handleHash = ->
  station = window.location.hash.substring(1)
  return if station == ""

  etdsForStation(station)
    .then( displayEtds )
    .then ->
      $('.stations').hide()

window.onhashchange = handleHash
$(handleHash)
