module.exports = function(app) {

  var Conta = app.models.conta
    , controller = {}
    ;


  controller.listContas = function(req, res) {
    Conta.find().exec()
      .then
      ( function(contas) {
          res.json(contas);
        }
      , function(err) {
          console.error(err);
          res.status(500).json(err);
        }
      )
    ;
  };


  controller.getConta = function(req, res) {
    var _id = req.params.id;

    Conta.findById( _id ).exec()
      .then
      ( function(conta) {
          if(!conta) throw new Error('Contato não encontrado');
          res.json(conta);
        }
      , function(err) {
          console.error(err);
          res.status(404).json(err);
        }
      )
    ;
  };


  controller.setConta = function(req, res) {
    var conta = req.body;

    conta = conta._id ?
        update(conta) :
        insert(conta) ;


    function insert(data) {
      Conta.create(data)
        .then
        ( function(conta) {
            console.log('API: SetConta -> _id: ' + conta._id + '\n' + conta);
            res.status(201).json(conta);
          }
        , function(err) {
            console.error(err);
            res.status(500).json(err);
          }
        )
      ;
    }

    function update(data) {
      Conta.findByIdAndUpdate( data._id, data ).exec()
        .then
        ( function(conta) {
            console.log('API: UpConta -> _id: ' + data._id);
            console.dir(data);
            res.json(conta);
          }
        , function(err) {
            console.error(err);
            res.status(500).json(err);
          }
        )
      ;
    }
  };


  controller.delConta = function(req, res) {
    var _id = req.params.id;

    Conta.remove({'_id': _id }).exec()
      .then
      ( function() {
          console.log('API: delConta -> _id: ' + _id);
          res.status(204).end();
        }
      , function(err) {
          return console.error(err);
        }
      )
    ;
  };


  return controller;
};
