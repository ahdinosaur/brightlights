husl = require('husl')
_ = require('lodash')

class Line
  (@strip, @start, @numPixels) ->

  set: ({ pixel, color }) ->
    # if pixel is string, parse into integer
    if _.isString(pixel)
      pixel = parseInt(pixel)

    i = @start + pixel
    if (i >= @start && i < (@start + @numPixels))
      return @strip.set(i, color)
    else
      throw new Error("pixel out of bounds: " + pixel)

  setRange: ({ start, end, color }) ->
    for i from start to end
      @set(i, color)

  all: ({ color }) ->
    @setRange(0, @numPixels, color)

module.exports = Line;