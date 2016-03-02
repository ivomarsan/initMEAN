module.exports = function() {
  'use strict';

  return {
    restrict: 'A',
    require: 'ngModel',
    scope: {
      ngLength: '='
    },
    link: function($scope, $element, $attrs, ngModel) {
      $scope.$watch($attrs.ngModel, function(value) {
        var isValid = (value.length === $scope.ngLength);
        ngModel.$setValidity($attrs.ngModel, isValid);
      });
    }
  };

};
