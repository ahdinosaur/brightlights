Line = require('./line')

strip = require('../strips')[0]

module.exports = [
  new Line(strip, 0, 16),
  new Line(strip, 16, 16)
  ]