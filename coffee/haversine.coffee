# Distance in kilometers between two points using the Haversine algo.
# http://jsperf.com/vincenty-vs-haversine-distance-calculations

toRadians = (n)-> n * Math.PI / 180

window.haversine = (a,b)->
  R = 6371
  dLat = toRadians(b.lat - a.lat)
  dLong = toRadians(b.long - a.long)

  a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(toRadians(a.lat)) * Math.cos(toRadians(b.lat)) * Math.sin(dLong / 2) * Math.sin(dLong / 2)
  c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
  d = R * c
  d
