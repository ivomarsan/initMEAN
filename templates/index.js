var http = require('http')
  , app = require('./dev/back/config/express')()
  , port = app.get('port')
  ;

require('./dev/back/config/database.js')('mongodb://localhost/<%= appNameSlug %>');

http.createServer(app).listen(port, function(){
  console.log('\n******************************************************');
  console.log('\tExpress Server escutando na porta', port);
  console.log('******************************************************\n');
});
