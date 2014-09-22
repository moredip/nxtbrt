if (window.NxtBrt == null) window.NxtBrt = {};

(function(NxtBrt){

  var Estimate = React.createClass({
    render: function(){
      var lineClass = "line-"+this.props.lineColor;
      return (
        <li className={lineClass}>
          {this.props.dest}: {NxtBrt.humanMinutes(this.props.minutes)}
        </li>
      );
    }
  });
  
  NxtBrt.EstimatesList = React.createClass({
    getInitialState: function(){
      return {etds:[]};
    },
    render: function(){
      var header = (<h1><a href='#'>{this.props.stationName}</a></h1>);
      var etds = this.state.etds.map( function(etd){
        return <Estimate dest={etd.dest.name} minutes={etd.minutes} lineColor={etd.lineColor}/>
      });
      return (
        <div>
          {header}
          <ul>
            {etds}
          </ul>
        </div>
      );
    }
  });
}(window.NxtBrt));
