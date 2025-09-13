#!/bin/bash

#1)conectar al servidor de la utu por ssh
function linkSSH(){

read -p "ingrese IP del servidor: " ipserver;
read -p "ingrese Usuario del servidor: " user;
read -p "ingrese puerto: " port;

ssh -p $port $user@$ipserver

}

function manualBackup(){

read -p "ingrese ruta del archivo que quiere respaldar: " path1;
read -p "ingre ruta del servidor DONDE quiere almacenar el arhivo: " path2
read -p "ingrese nombre de usuario del servidor: " user;
read -p "ingrese IP del servidor: " IP;
echo "respaldo realizado"

scp $path1 $user@$IP:$path2;

}


function manualToRestore(){

read -p "ingrese ruta (server) del archivo que quiere RESTARUAR: " path2;
read -p "ingrse ruta (local) donde quiere restaurar: " path1;
read -p "ingese nombre usuario del servidor: " name;
read -p "ingrese IP del servidor: " IP;

scp $user@$IP:$path2 $path1;
echo "restauracion realizada"

}

op=1;

while [[ "$op" != 0 ]]
do

echo "1) ingresar al servidor via SSH";
echo "2) realizar respaldo manual";
echo "3) acerca de http";
echo "4) acerca de BBDD"
echo "0) salir";
read op;

case "$op" in

1) linkSSH;;
2) manualBackup;;
3) manualToRestore;;
0) op=0 ;;


esac
done
