express = require('express')
app = express()

outputs = require('../outputs')

app.get('/:output/:fn', (req, res) ->
  console.log(req.params.output, req.params.fn, req.query)
  ret = outputs[parseInt(req.params.output)][req.params.fn](req.query)
  res.send(ret)
);

app.listen(31337);