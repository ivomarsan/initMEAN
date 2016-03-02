var app = require('angular').module('<%= appNameSlug %>');

app.controller('HomeController', require('./src/home'));
app.controller('ContaController', require('./src/conta'));
app.controller('ContasController', require('./src/contas'));
