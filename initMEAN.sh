#!/bin/bash

## Autor: @ivomarsan
## PS: Eu utilizo comandos que são direcionados para o Ubuntu, como a instalação do Node por Exemplo

## Leio algumas informações do Projeto e do Autor
echo -e "\E[01;37m Informe o nome do projeto"; tput sgr0
read PROJECT_NAME;
echo -e "\E[01;37m Em 140 caracteres, a descrição"; tput sgr0
read PROJECT_DESC;
## Variáveis do Projeto
Path=~/Projetos/MEAN/$PROJECT_NAME
AUTHOR_GIT="ivomarsan"
AUTHOR_NAME="Ivomar Santos"
AUTHOR_EMAIL="contato@ivomarsantos.com"
## Removo vestígios passados, se houver
#sudo rm -r $Path ## Removido pelo Risco de Apagar todo o Diretório ~/Projetos
## Crio uma pasta para o Projeto e entro
mkdir -pv $Path && cd $Path
## Crio a estrutura de pastas do Projeto
mkdir -pv app && mkdir -pv config && mkdir -pv public && mkdir -pv app/controllers && mkdir -pv app/models && mkdir -pv app/routes && mkdir -pv app/views
## Gravo as informações no package.json
> $Path/package.json
echo '{
  "name": "'$PROJECT_NAME'",
  "version": "1.0.0",
  "description": "'$PROJECT_DESC'",
  "keywords": [
    "'$PROJECT_NAME'",
    "'$AUTHOR_GIT'"
  ],
  "main": "index.js",
  "author": "'$AUTHOR_NAME' <'$AUTHOR_EMAIL'>",
  "license": "ISC",
  "homepage": "https://github.com/'$AUTHOR_GIT'/'$PROJECT_NAME'",
  "repository": {
    "type": "git",
    "url": "git://github.com/'$AUTHOR_GIT'/'$PROJECT_NAME'.git"
  }
}' >> $Path/package.json
## Gravo as informações no bower.json
> $Path/bower.json
echo '{
  "name": "'$PROJECT_NAME'",
  "version": "1.0.0",
  "description": "'$PROJECT_DESC'",
  "keywords": [
    "'$PROJECT_NAME'",
    "'$AUTHOR_GIT'"
  ],
  "main": "index.js",
  "authors": [
    "@'$AUTHOR_GIT' <'$AUTHOR_EMAIL'>"
  ],
  "license": "ISC",
  "homepage": "https://github.com/'$AUTHOR_GIT'/'$PROJECT_NAME'",
  "private": true,
  "ignore": [
    "**/.*",
    "node_modules",
    "bower_components",
    "test",
    "tests"
  ]
}' >> $Path/bower.json
## Arquivo de Configuração do Bower, muda o diretório padrão
> $Path/.bowerrc
echo '{
  "directory": "public/bower"
}' >> $Path/.bowerrc
## Alerto sobre a senha que será solicitada no próximo comando
echo -e "\E[05;31m Requisitando permissão de root"; tput sgr0
## Testo se o Nodemon, NodeJS, Bower e Git estão instalados
which nodemon || sudo npm install nodemon -g
which nodejs || curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash - && sudo apt-get install nodejs -y
which bower || sudo npm install bower@1.3 -g
which git || sudo apt-get update && sudo apt-get install git
## Instalo os módulos necessários e salvo
sudo npm install express@4.8 --save
sudo npm install express-load@1.1 --save
sudo npm install ejs@0.8 --save
bower install angular#1.3 --save
bower install angular-route#1.3 --save
## Crio um repositório git vazio
git init
## Faço download da "lista negra do git"
wget https://raw.githubusercontent.com/github/gitignore/master/Node.gitignore -O .gitignore
## Crio o readme padrão do repositório
> $Path/README.md
echo '# '$PROJECT_NAME
$PROJECT_DESC'

*Gerado automaticamente com o [initMEAN](https://github.com/ivomarsan/initMEAN "initMEAN")*
' >> $Path/README.md
## Crio o arquivo de licença
> $Path/LICENSE
echo 'Copyright (c) 2015, '$AUTHOR_NAME' <'$AUTHOR_EMAIL'>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.' >> $Path/LICENSE
## Configurar o config/express.js
> $Path/config/express.js
echo "var express = require('express');
var load = require('express-load');
module.exports = function() {
  var app  = express();
  app.set('port', 3000);
  app.use(express.static('./public'));
  app.set('view engine', 'ejs');
  app.set('views', './app/views');
  load('models', {cwd: 'app'})
    .then('controllers')
    .then('routes')
    .into(app);
  return app;
};" >> $Path/config/express.js
## Configurar o index.js
> $Path/index.js
echo "var http = require('http');
var app  = require('./config/express')();

http.createServer(app).listen(app.get('port'), function(){
  console.log('\n******************************************************');
  console.log('\tExpress Server escutando na porta '+app.get('port'));
  console.log('******************************************************\n');
});" >> $Path/index.js
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
echo "module.exports = function(app){
  var controller = app.controllers.home;
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
cd $Path && xdg-open 'http://localhost:3000/' && nodemon index.js
