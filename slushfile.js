/*
 * slush-ivomarsan
 * https://github.com/ivomarsan/initMEAN
 *
 * Copyright (c) 2016, Ivomar @ivomarsan
 * Licensed under the MIT license.
 */

'use strict';

var gulp     = require('gulp')
  , install  = require('gulp-install')
  , conflict = require('gulp-conflict')
  , template = require('gulp-template')
  , rename   = require('gulp-rename')
  , _        = require('underscore.string')
  , inquirer = require('inquirer')
  , i_parser = require('iniparser')
  , path     = require('path')
  , fs       = require('fs')
;

function format(string) {
  var username = string.toLowerCase();
  return username.replace(/\s/g, '');
}

var defaults = (function () {
  var workingDirName = path.basename(process.cwd()),
    homeDir, osUserName, configFile, user;

  if (process.platform === 'win32') {
    homeDir = process.env.USERPROFILE;
    osUserName = process.env.USERNAME || path.basename(homeDir).toLowerCase();
  }
  else {
    homeDir = process.env.HOME || process.env.HOMEPATH;
    osUserName = homeDir && homeDir.split('/').pop() || 'root';
  }

  configFile = path.join(homeDir, '.gitconfig');
  user = {};

  if (fs.existsSync(configFile)) {
    user = i_parser.parseSync(configFile).user;
  }

  return {
    appName: workingDirName,
    userName: osUserName || format(user.name || ''),
    authorName: user.name || '',
    authorEmail: user.email || ''
  };
})();

gulp.task('default', function (done) {
  var prompts = [{
    name: 'appName',
    message: 'Qual é o nome do Projeto?',
    default: defaults.appName
  }, {
    name: 'appDescription',
    message: 'Descrição?'
  }, {
    name: 'appVersion',
    message: 'Versão do Projeto?',
    default: '0.1.0'
  }, {
    name: 'authorName',
    message: 'Nome do Autor?',
    default: defaults.authorName
  }, {
    name: 'authorEmail',
    message: 'Email do FDP?',
    default: defaults.authorEmail
  }, {
    name: 'userName',
    message: 'Github user?',
    default: defaults.userName
  }, {
    name: 'indexName',
    message: 'Script Principal?',
    default: 'index.js'
  }, {
    type: 'confirm',
    name: 'moveon',
    message: 'Continue?'
  }];
  //Ask
  inquirer.prompt(prompts,
    function (answers) {
      if (!answers.moveon)
          return done();

      answers.appNameSlug = _.slugify(answers.appName);
      gulp.src(__dirname + '/templates/**')
          .pipe(template(answers))
          .pipe(rename(function (file) {
            if (file.basename[0] === '_')
              file.basename = '.' + file.basename.slice(1);
          }))
          .pipe(conflict('./'))
          .pipe(gulp.dest('./'))
          .pipe(install())
          .on('end', function () {
              done();
          });
    });
});
