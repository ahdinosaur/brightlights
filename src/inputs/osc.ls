osc = require('osc-min')
udp = require('dgram')

inport = 31337

sock = udp.createSocket('udp4', (msg, rinfo) ->
  try
    console.log(JSON.stringify(osc.fromBuffer(msg), null, 2))
  catch {message}
    console.error(message)
)

sock.bind(inport)