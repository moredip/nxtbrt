MAX_GEOLOCATION_STALENESS = 300000 #5 minutes

getCurrentPosition = (options={})->
  deferred = Q.defer()
  navigator.geolocation.getCurrentPosition(
    deferred.resolve,
    deferred.reject,
    options
  )
  ga('send', 'event', 'geolocate', 'start')
  deferred.promise
    .then ->
      ga('send', 'event', 'geolocate', 'success')
    .catch (e)->
      ga('send', 'event', 'geolocate', "failure-#{e.code}", e.message)

  deferred.promise

renderStations = (stations)->
  React.renderComponent(
    NxtBrt.StationList(stations:stations),
    document.getElementById('stations')
  );
  $('#stations').show();
  return;

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
