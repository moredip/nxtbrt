STATIONS_URL = "http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V"

parseStationNode = (stationNode)->
  pluckText = (tagName)-> pluckTextFromNode(stationNode, tagName)
  {
    name: pluckText('name')
    abbr: pluckText('abbr')
    lat: pluckText('gtfs_latitude')
    long: pluckText('gtfs_longitude')
  }


window.NxtBrt ?= {}
window.NxtBrt.displayStations = ->
  stations = Q($.ajax(STATIONS_URL)).then (doc)->
    ( parseStationNode(s) for s in doc.getElementsByTagName("station") )

  stations.then (stations)->
    $list = $("<ul>")
    stations.forEach (s)->
      a = $("<a href='##{s.abbr}'>").text(s.name)
      $("<li>").append(a).appendTo($list)

    $('.stations').append($list).show()
