class Line
  (@strip, @start, @numPixels) ->

  set: (pixel, color) ->
    i = @start + pixel
    if (i >= @start || i < (@start + @numPixels))
      @strip.set(i, color)
    else
      throw new Error("pixel out of bounds: ", pixel)

  setRange: (start, end, color) ->
    for i from start to end
      @set(i, color)

  all: (color) ->
    @setRange(0, @numPixels, color)

module.exports = Line;