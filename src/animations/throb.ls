Easing = require('easing')
tick = require('../tick')

STEPS = 50
DURATION_SCALE = 400/STEPS

class Throb
  (@setter, @pixels, @startColor, @endColor, @duration, options) ->
    if (options !== undefined && "easing" in options)
      @easing = Easing(STEPS, options.easing, {
        endToEnd:true
      })
    else
      @easing = Easing(STEPS, 'linear', {
        endToEnd:true
      })
    @step = 0
    @running = false

  start: ->
    @running = true
    @tick()

  stop: ->
    @running = false

  calculate_single: (startValue, endValue) ->
    return startValue + (endValue - startValue)* @easing[@step]

  calculate_rgb: ->
    r = @calculate_single(@startColor[0], @endColor[0])
    g = @calculate_single(@startColor[1], @endColor[1])
    b = @calculate_single(@startColor[2], @endColor[2])
    return [r, g, b]

  tick: ->
    self = @
    rgb = @calculate_rgb()
    # Loop through all of the pixels in pixels, and call set
    @pixels.forEach((element, index, array) ->
      self.setter.set(element, rgb)
    )

    @step = (@step += 1) % STEPS;
    if (@running)
      tick.setTimeout((-> self.tick()),
        @duration * DURATION_SCALE)

module.exports = Throb