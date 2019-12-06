# Script Web-Server

<h3>Trabalho Final da Disciplina de Programação de Scripts</h3>
<h4>Universidade Federal do Ceará - Campus Quixadá</h4>

<p>
Código escrito em Shell Script para configuração de servidor web a partir de um repositório git definido pelo usuário que utiliza a Stack Javascript (Node.JS e ReactJS), podendo usar MongoDB e/ou Postgres como banco de dados e o gerenciador de pacotes Yarn.
</p>

<p>
Função <code>menu()</code><br>
Inicialmente, o usuário do script deve informar o link do repositório git da aplicação web, contendo backend e frontend. Suas respectivas pastas também devem ser informadas ao script, assim como a senha do banco de dados Postgres. Essas informações são inseridas através de caixas <code>dialog</code>.
</p>

<p>
Função <code>gitFunction()</code><br>
A função instalará na máquina a ser configurada o <code>git</code>, caso a mesma não possua.
Em seguida, o repositório informado pelo usuário será clonado.
</p>

<p>
Função <code>postgres()</code><br>
A função instalará o banco de dados <code>postgres</code> e definirá uma senha de acordo com a entrada do usuário na função <code>menu()</code>.
</p>

<p>
Função <code>nodeFunction()</code><br>
Através do <code>snap</code>, o Node.JS será instalado.
</p>

<p>
Função <code>yarnFunction()</code><br>
Instalação do gerenciador de pacotes Yarn.
</p>

<p>
Função <code>backend()</code><br>
Inicialmente chama a função <code>mongoFunction()</code>, para instalação do docker, utilizado para o Banco de Dados do servidor, cuja imagem é instanciada nesta mesma funcão através do <code>docker-compose</code>. Para finalizar a função do backend, suas dependências são instaladas através do <code>yarn</code>. O banco de dados é criando, além de suas tabelas através do <code>sequelize</code>.
</p>

<p>
Função <code>frontend()</code><br>
Instalação das dependências do frontend.
</p>

<p>
Função <code>start()</code><br>
Execução do <code>backend</code> em segundo plano e do <code>frontend</code> em primeiro plano.
</p>

<p>
<strong>Servidor funcionando!</strong>
</p>
