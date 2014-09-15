MAX_GEOLOCATION_STALENESS = 300000 #5 minutes

getCurrentPosition = (options={})->
  deferred = Q.defer()
  navigator.geolocation.getCurrentPosition(
    deferred.resolve,
    deferred.reject,
    options
  )
  deferred.promise

renderStations = (stations)->
  $list = $("<ul>")
  stations.forEach (s)->
    a = $("<a href='##{s.abbr}'>").text(s.name)
    $("<li>").append(a).appendTo($list)

  $('.stations').empty().append($list).show()

stationsSortedByProximity = (stations,position)->
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
  stations = NxtBrt.STATIONS
  renderStations( stations )

  NxtBrt.showToast('finding stations nearest you...')

  getCurrentPosition(maximumAge:MAX_GEOLOCATION_STALENESS)
    .then( (position)-> stationsSortedByProximity(stations,position) )
    .then( renderStations )
    .then ->
      NxtBrt.hideToast()

window.NxtBrt.lookupStationByAbbr = (abbr)->
  _.find( NxtBrt.STATIONS, (s)-> s.abbr == abbr )
