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
    ws2801 = require('./ws2801');

var strip = new ws2801.Strip('/dev/spidev2.0', numPixels);

//pixel.all(30, 30, 30);
//pixel.sync();

strip.throb(_.range(numPixels), [0,0,0], [255,100,100], 1, {})
