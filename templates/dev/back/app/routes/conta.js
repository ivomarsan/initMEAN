module.exports = function(app) {
  var controller = app.controllers.conta;

  app.route('/contas')
     .get(controller.listContas)
     .post(controller.setConta)
  ;
  app.route('/contas/:id')
     .get(controller.getConta)
     .delete(controller.delConta)
  ;
};
