spi = require('spi')
_ = require('lodash')
husl = require('husl')

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
    @dirty = false

  sync: (callback) ->
    @dirty = false
    @device.write(@pixelBuffer, callback)

  off: (callback) ->
    @device.write(@offBuffer, callback)

  clear: ->
    @pixelBuffer.fill(0)

  set: (pixel, color) ->
    @dirty = true

    # if pixel is string, parse into integer
    if _.isString(pixel)
      pixel = parseInt(pixel)

    # if color is string, parse as hex color
    if _.isString(color)
      color = husl.fromHex(color)

    # if color is array, clean up rgb triplet
    if _.isArray(color)
      color = [_.parseInt(c) for c in color]

    # if color is object
    if _.isObject(color)
      # if contains rgb keys, change to rgb triplet
      if (_.has(color, 'red') &&
          _.has(color, 'green') &&
          _.has(color, 'blue'))
        color = [color.red, color.green, color.blue]
      # if contains hsl keys, change to rgb triplet
      else if (_.has(color, 'hue') &&
          _.has(color, 'saturation') &&
          _.has(color, 'lightness'))
        color = husl.toRGB(color.hue, color.saturation, color.lightness)

    [r, g, b] = color

    @pixelBuffer[pixel * 3] = r
    @pixelBuffer[pixel * 3 + 1] = g
    @pixelBuffer[pixel * 3 + 2] = b

    return "success"

  setRange: (start, end, color) ->
    for i from start to end
      @set(i, color)

  all: (color) ->
    @setRange(0, @numLeds, color)

  toString: ->
    JSON.stringify(@pixelBuffer)

module.exports.Strip = Strip;