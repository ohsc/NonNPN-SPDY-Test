# About This Project
As you know [CocoaSPDY][CocoaSPDY] is based on Secure Transport (Apple's TLS implementation). And Secure Transport doesn't support NPN.
Take a look at [a note on npn][0].

The project that shows how [CocoaSPDY][CocoaSPDY] works with [node-spdy][node-spdy] using nonNPN and forcing SPDY mode.


Thanks to [indutny][1] for helping me work out the [no response problem][2].

[CocoaSPDY]: https://github.com/twitter/CocoaSPDY
[node-spdy]: https://github.com/indutny/node-spdy
[0]: https://github.com/twitter/CocoaSPDY#a-note-on-npn
[1]: https://github.com/indutny
[2]: https://github.com/indutny/node-spdy/issues/133
