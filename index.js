(function(){
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
}).call(this);
