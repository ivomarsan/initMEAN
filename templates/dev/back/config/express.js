var express = require('express')
  , load = require('express-load')
  , path = express.static('./public')
  , bodyParser = require('body-parser')
  , compression = require('compression')
  , methodOverride = require('method-override')()
  , dir = 'dev/back/app'
  ;

module.exports = function() {
  var app = express();

  app.set('port', 5000);
  app.use(path);
  app.set('view engine', 'ejs');
  app.set('views', './'+dir+'/views');

  /*
************************************************************************
  */
  app.use(compression());
  app.use(bodyParser.urlencoded({extended: true}));
  app.use(bodyParser.json());
  app.use(methodOverride);
  /*
************************************************************************
  */

  load('models', {cwd: dir})
      .then('controllers')
      .then('routes')
      .into(app)
  ;

  return app;
};
