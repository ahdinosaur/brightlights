ws2801 = require('./ws2801')

module.exports = [
  new ws2801.Strip('/dev/spidev1.0', 32)
]