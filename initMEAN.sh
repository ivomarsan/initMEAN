#!/bin/bash

## Autor: @ivomarsan

## Leio algumas informações do Projeto e do Autor
echo -e "\E[01;37m Informe o nome do projeto"; tput sgr0
read PROJECT_NAME;
echo -e "\E[01;37m Em 140 caracteres, a descrição"; tput sgr0
read PROJECT_DESC;
echo -e "\E[01;37m Autor: Nome"; tput sgr0
read AUTHOR_NAME;
echo -e "\E[01;37m Autor: E-mail"; tput sgr0
read AUTHOR_EMAIL;
echo -e "\E[01;37m Autor: Github user"; tput sgr0
read AUTHOR_GIT;
## Variáveis do Projeto
Path=~/Projetos/$PROJECT_NAME
## Removo vestígios passados, se houver
#sudo rm -r $Path ## Removido pelo Risco de Apagar todo o Diretório ~/Projetos
## Crio uma pasta para o Projeto e entro
mkdir -pv $Path && cd $Path
## Crio um repositório git vazio
git init
## Faço download da "lista negra do git"
wget https://github.com/github/gitignore/blob/master/Node.gitignore -O .gitignore
## Crio a estrutura de pastas do Projeto
mkdir -pv app && mkdir -pv config && mkdir -pv public && mkdir -pv app/controllers && mkdir -pv app/models && mkdir -pv app/routes && mkdir -pv app/views
## Gravo as informações no package.json
> $Path/package.json
echo '{
  "name": "'$PROJECT_NAME'",
  "version": "1.0.0",
  "description": "'$PROJECT_DESC'",
  "keywords": [
    "npm",
    "'$PROJECT_NAME'",
    "'$AUTHOR_GIT'"
  ],
  "main": "app.js",
  "author": "'$AUTHOR_NAME' <'$AUTHOR_EMAIL'>",
  "license": "ISC",
  "homepage": "https://github.com/'$AUTHOR_GIT'/'$PROJECT_NAME'",
  "repository": {
    "type": "git",
    "url": "git://github.com/'$AUTHOR_GIT'/'$PROJECT_NAME'.git"
  }
}' >> $Path/package.json
## Alerto sobre a senha que será solicitada no próximo comando
echo -e "\E[05;31m Requisitando permissão de root"; tput sgr0
## Instalo o Express e salvo no package.json
sudo npm install express@4.8 --save
## Instalo o EJS e salvo no package.json
sudo npm install ejs@0.8 --save
## Configurar o config/express.js
> $Path/config/express.js
echo "var express = require('express');
module.exports = function() {
  var app  = express();
  var home = require('../app/routes/home');
  app.set('port', 3000);
  app.use(express.static('./public'));
  app.set('view engine', 'ejs');
  app.set('views', './app/views');
  home(app);
  return app;
};" >> $Path/config/express.js
## Configurar o app.js
> $Path/app.js
echo "var http = require('http');
var app  = require('./config/express')();

http.createServer(app).listen(app.get('port'), function(){
  console.log('\n******************************************************');
  console.log('\tExpress Server escutando na porta '+app.get('port'));
  console.log('******************************************************\n');
});" >> $Path/app.js
## Configurar o public/index.html
#> $Path/public/index.html
#echo '<!doctype html>
#<html lang="pt_BR">
#<head>
#  <meta charset="utf-8">
#  <title>'$PROJECT_NAME'</title>
#</head>
#<body>
#  <h1>Alô Mamãe!</h1>
#</body>
#</html>' >> $Path/public/index.html
###############################################################################
## Configurar o app/views/index.ejs
> $Path/app/views/index.ejs
echo '<!doctype html>
<html lang="pt_BR">
<head>
  <meta charset="utf-8">
  <title>'$PROJECT_NAME'</title>
</head>
<body>
  <h1>Alô Mamãe!</h1>
  <h2>Bem vinda ao <%=nome %></h2>
</body>
</html>' >> $Path/app/views/index.ejs
## Configurar o app/routes/home.js
> $Path/app/routes/home.js
echo "var controller = require('../controllers/home')();
module.exports = function(app){
  app.get('/index', controller.index);
  app.get('/', controller.index);
};" >> $Path/app/routes/home.js
## Configurar o app/controllers/home.js
> $Path/app/controllers/home.js
echo "module.exports = function(){
  var controller = {};
  controller.index = function(req, res){
    res.render('index', {nome: 'Express'});
  };
  return controller;
};" >> $Path/app/controllers/home.js
## Adiciono todos os arquivos no git
git add .
## Faço o primeiro commit
git commit -am "Primeiro Commit :) Gerada a estrutura do projeto"
## Inicio o Server
cd $Path && xdg-open 'http://localhost:3000/' && node app.js
