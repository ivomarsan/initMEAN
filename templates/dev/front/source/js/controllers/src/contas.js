module.exports = ['$scope', 'Conta',
function($scope, Conta) {
  'use strict';

  $scope.contas = [];

  $scope.filtro = '';

  $scope.mensagem = { texto: '' };

  function getContas() {
    Conta.query(
      function(data) {
        $scope.contas = data;
        $scope.mensagem = {};
      },
      function(err) {
        console.error('Não foi possível obter a lista de Contas');
        console.error(err);
        $scope.mensagem = {
          texto: 'Não foi possível obter a lista de Contas'
        };
      }
    );
  }

  $scope.remove = function(conta) {
    Conta.delete({ id: conta._id }
    , getContas
    , function(err) {
        console.error('Não foi possível remover a Conta');
        console.error(err);
        $scope.mensagem = {
          texto: 'Não foi possível remover a Conta'
        };
      }
    );
  };


  $scope.init = function() {
    getContas();
  };
  $scope.init();

}];
