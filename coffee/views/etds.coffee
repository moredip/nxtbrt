window.NxtBrt ?= {}

D = React.DOM

Estimate = React.createClass
  render: ->
    mins = NxtBrt.humanMinutes(@props.minutes)
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
