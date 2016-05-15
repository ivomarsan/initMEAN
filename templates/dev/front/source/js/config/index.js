var app = require('angular').module('<%= appNameSlug %>');

app.config(['$routeProvider', function($routeProvider) {
  'use strict';

  $routeProvider
    .when('/1',
      { templateUrl: 'identificacao.html'
      , controller: 'HomeController'
      }
    )
    .when('/2',
      { templateUrl: 'viagem.html'
      , controller: 'HomeController'
      }
    )
    .when('/3',
      { templateUrl: 'horarios.html'
      , controller: 'HomeController'
      }
    )
    .when('/4',
      { templateUrl: 'passageiros.html'
      , controller: 'HomeController'
      }
    )
    .when('/contas',
      { templateUrl: 'contas.html'
      , controller: 'ContasController'
      }
    )
    .when('/conta',
      { templateUrl: 'conta.html'
      , controller: 'ContaController'
      }
    )
    .when('/conta/:_id',
      { templateUrl: 'conta.html'
      , controller: 'ContaController'
      }
    )
    .when('/404',
      { templateUrl: '404.html'
      , controller: 'Error404'
      }
    )
    .otherwise({
      redirectTo: '/404'
    })
  ;
}]);
