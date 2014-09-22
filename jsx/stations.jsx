if (window.NxtBrt == null) window.NxtBrt = {};

(function(NxtBrt){

StationItem = React.createClass({
  render: function() {
    var href = "#"+this.props.abbr;
    return (
      <a href={href}>
        <li>{this.props.name}</li>
      </a>
    );
  }
});

NxtBrt.StationList = React.createClass({
  render: function() {
    var stationNodes = this.props.stations.map( function(station){
      return <StationItem name={station.name} abbr={station.abbr}/>
    });
    return (
      <ul>
        {stationNodes}
      </ul>
    );
  }
});

}(window.NxtBrt));
