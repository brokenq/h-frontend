var path = require('path');
var app = require('connect')();
var favicon = require('serve-favicon');
//require('config')();

app.use(favicon(path.join(__dirname, "favicon.ico")));
app.use(require('connect-livereload')());
app.use(require('serve-static')(path.join(__dirname, 'dist'), {'index': ['views/index.html']}));
app.use(require('serve-static')(__dirname));

var port = process.env.PORT || 3004;
var server = app.listen(port, function () {

    var host = server.address().address;
    var port = server.address().port;

    console.log('custom server listening at http://%s:%s', host, port);
});