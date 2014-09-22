window.NxtBrt ?= {}

D = React.DOM

humanMinutes = (min)->
  if min == 0
    "now"
  else if min == 1
    "1 min"
  else
    "#{min} mins"

Estimate = React.createClass
  render: ->
    mins = humanMinutes(@props.minutes)
    (D.li className:"line-"+@props.lineColor,
      "#{@props.dest}: #{mins}"
    )

EstimatesList = React.createClass 
  getInitialState: ->
    {etds: []}
  render: ->
    header = 
      (D.h1 {},
        (D.a href:"#", @props.stationName) 
      )

    etds = @state.etds.map (etd)->
      Estimate
        dest: etd.dest.name
        minutes: etd.minutes
        lineColor: etd.lineColor

    (D.div {},
      header
      (D.ul {},
        etds
      )
    )
      
window.NxtBrt.EstimatesList = EstimatesList
