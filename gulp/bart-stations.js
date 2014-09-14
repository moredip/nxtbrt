var es = require('event-stream'),
    libxmljs = require('libxmljs');

var parseStation = function(stationNode){
  return {
    name: stationNode.get('name').text(),
    abbr: stationNode.get('abbr').text(),
    lat: stationNode.get('gtfs_latitude').text(),
    long: stationNode.get('gtfs_longitude').text()
  };
}

var parseBartStations = function(){
  var parser = function(file,callback){
    var root = libxmljs.parseXml(file.contents);
    var stations = root.find('//stations/station').map( parseStation );
    file.contents = new Buffer(JSON.stringify(stations));
    callback(null,file);
  };
  return es.map(parser);
}

module.exports = parseBartStations;
