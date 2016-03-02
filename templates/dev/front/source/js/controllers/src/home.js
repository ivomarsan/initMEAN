module.exports = ['$scope', '$timeout', 'Scopes',
function($scope, $timeout, Scopes) {
  'use strict';

  $scope.setData = function() {
    Scopes.set('HomeController', $scope.reca);
  };

  $scope.getData = function() {
    $scope.reca = Scopes.get('HomeController') || {};
    console.log($scope.reca);
  };

  $scope.getData();

}];
