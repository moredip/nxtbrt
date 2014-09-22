window.NxtBrt ?= {}

D = React.DOM

Station = React.createClass
  render: ->
    (D.a href:"#"+@props.abbr,
      (D.li {},
        @props.name
      )
    )
      
StationList = React.createClass
  render: ->
    stations = @props.stations.map (s)->
      Station
        name:s.name
        abbr:s.abbr
        key:s.key

    (D.ul {},
      stations
    )

NxtBrt.StationList = StationList
