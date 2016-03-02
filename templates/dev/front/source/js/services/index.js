var app = require('angular').module('<%= appNameSlug %>');

app.factory('Scopes', require('./src/home'));
app.factory('Conta', require('./src/conta'));
