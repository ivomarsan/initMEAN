module.exports = function() {
  'use strict';

  var mem = {};

  return {
    set: function(key, value) {
      mem[key] = value;
    },
    get: function(key) {
      return mem[key];
    }
  };

};
