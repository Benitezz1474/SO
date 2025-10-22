#!/bin/bash

#ruta donde se almacenan los logs de la BBDD
LOG=/var/log/conceptualScripts/mariadb.log 

function showServices(){ #esta funcion debe mostrar los servicios contratados por x usuario

read -p "ingrese la CI del usuario para ver los servicios contratados: " ci;
read -p "ingrese la ip del host (ip del servidor que contiene el servicio de BBDD): " host;
read -p "ingrese el puerto por el que desea acceder al servicio: " port;

if [[ -n "$ci" && -n "$host" &&  -n "$port" ]]
then

 #realizo la consulta:
 sudo mysql -h "$host" -P "$port" -u root -p proyectobd -e "SELECT * FROM contrata WHERE CiCliente=$ci";
 #verifico si da error o no
    if [[ $? != 0 ]]
    then
    echo "algo salio mal, verifique los datos de entrada";
   fi


 else
   echo "debe completar todos los campos";
fi
}

function serviceDel(){ #esta funcion debe eliminar los servicios contratados por x usuarios

read -p "ingrese CI del usuario: " ci;
read -p "ingrese ID del servicio: " id;
read -p "ingrese ip del host (ip del servidor que contiene el servicio de BBDD): " host;
read -p "ingrese el purto por el que desea acceder al servicio: " port;

if [[ -n "$port" && -n "$host" &&  -n "ci" &&  -n "$id" ]]
then

sudo mysql -h "$host" -P "$port" -u root -p proyectobd -e "DELETE FROM contrata WHERE CiCliente=$ci AND IdContrato=$id";

   if [[ $? != 0 ]]
    then
     echo "algo salio mal, verifique los datos de entrada";

   echo "usuario:$USER:fecha:$(date):accion:se intenta eliminar datos de la tabla contrata" | sudo tee -a "$LOG" > /dev/null;


    elif [[ $? == 0 ]]
    then
    #mando el registro
    echo "usuario:$USER:fecha:$(date):accion:elimina resultados de la tabla contrata" | sudo tee -a "$LOG" > /dev/null;
  fi
echo

#registro la baja

echo "contrato eliminado correctamente";

else
  echo "debe completar todos los campos";

fi
}



op=1;
while [[ "$op" != 0 ]]
do

echo ""
echo "MENU de gestion de contrataciones";
echo "1) ver los servicios contratados por un usuario en especifico";
echo "2) eliminar servicios contratados por un usuario en especifico";
echo "0) salir";
read op;

case "$op" in

1) showServices;;
2) serviceDel;;
0) op=0;;
*) echo "debe ingresar una opcion valida";;

esac

done
