tick = require('./tick')
strips = require('../strips')

dt = 8
sync = ->
  tick.tick(dt);
  for strip in strips
    if (strip.dirty)
      strip.sync!
  setTimeout(sync, dt)

module.exports = sync