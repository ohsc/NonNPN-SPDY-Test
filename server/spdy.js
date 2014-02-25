var fs = require('fs'),
    spdy = require('spdy');
var Buffer = require('buffer').Buffer;

var options = {
  plain: true,
  ssl: true,
  maxStreams: 1000000,
  key: fs.readFileSync('keys/spdy-key.pem'),
  cert: fs.readFileSync('keys/spdy-cert.pem'),
  ca: fs.readFileSync('keys/spdy-csr.pem')
};

var big = new Buffer(16 * 1024);
for (var i = 0; i < big.length; i++) {
  big[i] = '0'.charCodeAt(0) + (i % 10);
}

var server = spdy.createServer(options, function(req, res) {
  if (req.url !== '/') {
    res.writeHead(404);
    res.end();
    return;
  }
  var buffers = [];
  req.on('data', function (chunk) {
    buffers.push(chunk);
  }).on('end', function () {
    var reqBody = Buffer.concat(buffers).toString('utf8');
    console.log('got data: ' + reqBody);
    res.writeHead(200, {
      "Content-Type": "text/plain"
    });
    res.write(reqBody + 'hello world\n');
    res.end();
    var now = new Date();
    console.log('receive time %s', now);
  });
});

server.listen(3232, function() {
  var addr = this.address();
  console.log('Server is listening on %s:%d', addr.address, addr.port);
});
