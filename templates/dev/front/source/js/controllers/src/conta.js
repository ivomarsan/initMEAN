module.exports = ['$scope', '$routeParams', 'Conta',
function($scope, $routeParams, Conta) {
  'use strict';

  if($routeParams._id)
    getConta();
  else
    $scope.conta = new Conta();


  function getConta() {
    Conta.get({ id: $routeParams._id }
    , function(data) {
        $scope.conta = data;
      }
    , function(err) {
        console.error('Não foi possível obter a conta');
        console.error(err);
        $scope.mensagem = {
          texto: 'Não foi possível obter a conta'
        };
      }
    );
  }

  $scope.setConta = function() {
    $scope.conta.$save()
      .then(function() {
        if($routeParams._id)
          $scope.mensagem = { texto: 'Conta alterada com sucesso!' };
        else
          $scope.mensagem = { texto: 'Conta inserida com sucesso!' };
        // Limpa o Formulário
        $scope.conta = new Conta();
      })
      .catch(function(err) {
        console.error('Não foi possível salvar a conta');
        console.error(err);
        $scope.mensagem = {
          texto: 'Não foi possível salvar a conta'
        };
      })
    ;
  };

}];
