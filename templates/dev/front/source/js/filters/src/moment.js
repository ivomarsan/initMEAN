//var moment = require('./lib/moment');

module.exports = function() {
  'use strict';

  return function(dateString, format) {
    //return moment(dateString).format(format);
    return console.log(dateString,format);
  };

};
