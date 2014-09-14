STATIONS_URL = "http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V"

MAX_GEOLOCATION_STALENESS = 300000 #5 minutes

getCurrentPosition = (options={})->
  deferred = Q.defer()
  navigator.geolocation.getCurrentPosition(
    deferred.resolve,
    deferred.reject,
    options
  )
  deferred.promise


parseStationNode = (stationNode)->
  pluckText = (tagName)-> pluckTextFromNode(stationNode, tagName)
  {
    name: pluckText('name')
    abbr: pluckText('abbr')
    lat: pluckText('gtfs_latitude')
    long: pluckText('gtfs_longitude')
  }

loadStations = ->
  Q($.ajax(STATIONS_URL)).then (doc)->
    ( parseStationNode(s) for s in doc.getElementsByTagName("station") )

displayStations = (stations)->
  $list = $("<ul>")
  stations.forEach (s)->
    a = $("<a href='##{s.abbr}'>").text(s.name)
    $("<li>").append(a).appendTo($list)

  $('.stations').empty().append($list).show()

clearStations = ()->
  $('.stations').empty()

sortStationsByProximity = (stations,position)->
  currLocation = {
    lat: position.coords.latitude,
    long: position.coords.longitude
  }

  stationsWithDistance = stations.map (station)->
    $.extend(
      {distance:haversine(currLocation, station)}, 
      station)

  stationsWithDistance.sort (a,b)->
    a.distance - b.distance
  stationsWithDistance

arrangeStationsByProximityOnceArrived = (stations)->
  position = getCurrentPosition(maximumAge:MAX_GEOLOCATION_STALENESS)

  Q.all([stations,position])
    .spread(sortStationsByProximity)

window.NxtBrt ?= {}
window.NxtBrt.displayStations = ->
  clearStations()
  NxtBrt.showToast('loading stations...')

  stations = loadStations()

  stations.then(displayStations)
    .then ->
      NxtBrt.showToast('finding stations nearest you...')

  arrangeStationsByProximityOnceArrived(stations)
    .then(displayStations)
    .then ->
      NxtBrt.hideToast()
