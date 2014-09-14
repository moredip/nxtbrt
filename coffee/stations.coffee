STATIONS_URL = "http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V"

pluckTextFromNode = (node,tagName)->
  node.getElementsByTagName(tagName)[0].textContent

parseStationNode = (stationNode)->
  pluckText = (tagName)-> pluckTextFromNode(stationNode, tagName)
  {
    name: pluckText('name')
    abbr: pluckText('abbr')
    lat: pluckText('gtfs_latitude')
    long: pluckText('gtfs_longitude')
  }


$ ->
  stations = Q($.ajax(STATIONS_URL)).then (doc)->
    ( parseStationNode(s) for s in doc.getElementsByTagName("station") )

  stations.then (stations)->
    $list = $("<ul>")
    stations.forEach (s)->
      $("<li>").text(s.name).appendTo($list)

    $('.stations').append($list)



