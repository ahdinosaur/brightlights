spi = require('spi')

class Strip
  (device, numPixels) ->
    @numPixels = numPixels
    @device = new spi.Spi(device, {
      "mode": spi.MODE['MODE_0'],
    }, (s) ->
      return s.open()
    )
    @pixelBuffer = new Buffer(numPixels * 3)
    @offBuffer = new Buffer(numPixels * 3)
    @pixelBuffer.fill(0)
    @offBuffer.fill(0)
    @device.write(@pixelBuffer)

  sync: (callback) ->
    @device.write(@pixelBuffer, callback)

  off: (callback) ->
    @device.write(@offBuffer, callback)

  clear: ->
    @pixelBuffer.fill(0)

  set: (pixel, [r, g, b]) ->
    @pixelBuffer[pixel * 3] = r
    @pixelBuffer[pixel * 3 + 1] = g
    @pixelBuffer[pixel * 3 + 2] = b

  setRange: (start, end, color) ->
    for i from start to end
      @set(i, color)

  all: (color) ->
    @setRange(0, @numLeds, color)

module.exports.Strip = Strip;