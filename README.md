# bright lights

Open Sound Control interface for WS2801 pixels

## notes

outputs
- line(strip, start, end)
  - set(x, [r, g, b])
  - gradient
- rect(strip, width, height)
  - set([x, y], [r, g, b])
  - gradient

animation
- throb(output, pixels, startColor, endColor, duration, type)
- rainbow(output, startPixel, endPixel, delta, duration)

strip(device)
