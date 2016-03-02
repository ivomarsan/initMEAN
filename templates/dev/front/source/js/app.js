var angular = require('angular')
  , ngRoute = require('angular-route')
  , ngResrc = require('angular-resource')
  , ngMasks = require('angular-input-masks')
  ;


var app = angular.module('<%= appNameSlug %>', [ngRoute, ngResrc, ngMasks]);


// Services, Controllers and Directives (index.js)
require('./config');
require('./filters');
require('./services');
require('./directives');
require('./controllers');
