/*(function(){
  var osc = require('osc-min'),
      udp = require('dgram');

  var inport = 31337,
      sock = udp.createSocket('udp4', function(msg, rinfo){
    var error;
    try {
      return console.log(JSON.stringify(osc.fromBuffer(msg), null, 2));
    } catch (e$) {
      error = e$;
      return console.log(error.msg);
    }
  });
  sock.bind(inport);
}).call(this);*/

var numPixels = 32;

var _ = require('lodash'),
    ws2801 = require('./lib/ws2801'),
    Line = require('./lib/line');

var strip = new ws2801.Strip('/dev/spidev1.0', numPixels);
var line0 = new Line(strip, 0, 16);
var line1 = new Line(strip, 16, 16);
line0.all([100, 10, 10]);
line1.all([10, 10, 100]);
strip.sync();

/*strip.throb(_.range(numPixels), [0,0,0], [100,20,20], 1, {easing: 'sinusoidal'})
strip.throb(_.range(0, numPixels, 3), [0,0,0], [255,0,0], 1, {easing: 'sinusoidal'})
strip.throb(_.range(1, numPixels, 3), [0,0,0], [100,40,40], 1, {easing: 'sinusoidal'})
strip.throb(_.range(2, numPixels, 3), [0,0,0], [0,0,255], 1, {easing: 'sinusoidal'})*/
