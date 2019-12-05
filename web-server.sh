#!/bin/bash


POSTGRES_PASSWORD=
BACKEND_FOLDER=
FRONTEND_FOLDER=
GIT_URL=
APP_FOLDER=

init(){
    cd ~
    sudo apt update && sudo apt upgrade -y
    sudo apt install dialog
    
    menu
}

menu(){
    dialog --msgbox "Instalador de Aplicação NodeJS/ReactJS" 0 0
    GIT_URL=`dialog  --stdout --inputbox "URL do GitHub da aplicação " 0 0`
    BACKEND_FOLDER=`dialog  --stdout --inputbox "Pasta da API " 0 0`
    FRONTEND_FOLDER=`dialog  --stdout --inputbox "Pasta da aplicação WEB " 0 0`
    POSTGRES_PASSWORD=`dialog  --stdout --inputbox "Senha do banco de dados PostgreSQL " 0 0`
    gitFunction
    
}

gitFunction(){
    sudo apt install git -y
    git clone $GIT_URL
    APP_FOLDER=`echo $GIT_URL | rev | cut -d '/' -f 1 | rev | cut -d '.' -f 1`
    postgres
}

postgres(){
    sudo apt-get install wget ca-certificates -y
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list' -y
    sudo apt update && sudo apt-get install postgresql postgresql-contrib -y
    sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password '$POSTGRES_PASSWORD';"
    nodeFunction
}


nodeFunction(){
    sudo apt install snapd
    sudo snap install node --classic --channel=12
    yarnFunction
    backend
}


yarnFunction(){
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt install yarn -y
}


backend(){
    mongoFunction
    cd ~/$APP_FOLDER/$BACKEND_FOLDER
    docker-compose up -d &
    yarn install
    yarn sequelize db:create
    yarn sequelize db:migrate
    cd -
    frontend
}

# In case of mongo
mongoFunction(){
    sudo apt install curl
    sudo curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo apt install docker docker-compose -y
}


frontend(){
    cd ~/$APP_FOLDER/frontend/$FRONTEND_FOLDER
    yarn install
    cd -
    start
}



start(){
    cd ~/$APP_FOLDER/$BACKEND_FOLDER
    sudo nohup `sudo yarn start` &
    cd ~/$APP_FOLDER/frontend/$FRONTEND_FOLDER
    sudo yarn start
    
}

init

