MAPS_API='https://maps.googleapis.com/maps/api/distancematrix/json'

parseDistance = ({rows: {elements: { distance, duration }} }) ->
  { distance, duration }

getWalkingDistance = (currentLocation, {lat, long}) ->
  options = {
    origins: "#{currentLocation.lat},#{currentLocation.long}",
    destinations: "#{lat},#{long}",
    mode: 'walking'
  }
  $.ajax({
    beforeSend: (xhr) -> xhr.setRequestHeader('Access-Control-Allow-Origin', '*'),
    crossDomain: true,
    method: 'GET',
    url: MAPS_API,
    data: options,
    contentType: 'application/json',
    error: (xhr, status, error) -> console.log error
  }).done parseDistance

window.getWalkingDistance = getWalkingDistance
