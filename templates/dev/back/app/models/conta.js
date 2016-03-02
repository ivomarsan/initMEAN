var mongoose = require('mongoose');

module.exports = function() {

  var schema = {
    nome:
    { type: String
    , required: true
    , index: { unique: true }
    }
  };

  var Schema = mongoose.Schema(schema);

  return mongoose.model('Conta', Schema);
};
