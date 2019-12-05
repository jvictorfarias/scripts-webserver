#!/bin/bash

PACKAGE_MANAGER=
POSTGRES_PASSWORD=
BACKEND_FOLDER=
FRONTEND_FOLDER=
GIT_URL=
APP_FOLDER=

menu(){
    dialog --msgbox "Instalador de Aplicação NodeJS/ReactJS" 0 0
    GIT_URL=`dialog  --stdout --inputbox "URL do GitHub da aplicação " 0 0`
    BACKEND_FOLDER=`dialog  --stdout --inputbox "Pasta da API " 0 0`
    FRONTEND_FOLDER=`dialog  --stdout --inputbox "Pasta da aplicação WEB " 0 0`
    PACKAGE_MANAGER=`dialog --stdout --title "Gerenciador de pacotes" --menu "Escolha o gerenciador:" \
    0 0 0 npm "Node Package Manager" yarn "Gerenciador do Facebook"`
    POSTGRES_PASSWORD=`dialog  --stdout --inputbox "Senha do banco de dados PostgreSQL " 0 0`
    gitFunction
    
}

init(){
    cd ~
    sudo apt update && sudo apt upgrade -y
    sudo apt install dialog
    
    menu
}

frontend(){
    cd $APP_FOLDER/frontend/$FRONTEND_FOLDER
    yarn install
    yarn start
    cd -
}

backend(){
    cd $BACKEND_FOLDER
    yarn install
    yarn sequelize db:create
    yarn sequelize db:migrate
    yarn start
    cd -
    frontend
}

# In case of mongo
mongo(){
    cd $BACKEND_FOLDER
    sudo apt install docker docker-compose -y
    docker-compose up -d
}

postgres(){
    sudo apt-get install wget ca-certificates -y
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list' -y
    sudo apt update && sudo apt-get install postgresql postgresql-contrib -y
    sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password '$POSTGRES_PASSWORD';"
    node
}

node(){
    sudo apt install snapd
    sudo snap install node --classic --channel=12
    backend
}

yarn(){
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt install yarn -y
    node
}

gitFunction(){
    sudo apt install git -y
    git clone $GIT_URL
    APP_FOLDER=`echo $GIT_URL | rev | cut -d '/' -f 1 | rev | cut -d '.' -f 1`
    postgres
}


init

