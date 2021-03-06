var path = require('path');
var app = require('connect')();

app.use(require('connect-livereload')());
app.use(require('serve-static')(__dirname, {'index': ['dist/views/index.html']}));

var server = app.listen(3000, function () {

    var host = server.address().address;
    var port = server.address().port;

    console.log('custom server listening at http://%s:%s', host, port);
});