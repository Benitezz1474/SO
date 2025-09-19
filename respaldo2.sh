#!/bin/bash

#ejercicio1

# no lo hice :(


#ejercicio2 A)
#read -p "ingrse nombre BBDD: " database;
#read -p "ingrese nombre usuario: "user;
#read -p "ingrese clave: "password;

#if [[ -n "$database" && -n "$user" && -n "$password" ]] then

 #sudo mysqldum -u $user -p$password $database > ./bd.sql

#else
 #echo "debe completar todos los campos";

#fi


#ejercicio 3

function showServerStatus(){

read -p "ingrese el nombre del servicio: " service_name;

if [[ -n "$service_name" ]] then

   if sudo systemctl status "$service_name"; then

     sudo systemctl status "$service_name";

  else 
      echo "servicio no contrado";
  fi

else
 echo "debe completar todos los campos";
fi

}

function packageInstall(){

read -p "ingrese el nombre de un paquete: " package_name;

if [[ -n "$package_name" ]] then

sudo dnf install $package_name -y;

else
  echo "debe completar los campos";
fi

}

function showAccessLog(){
read -p "ingrese nombre usuario: "user_name;

#no recuerdo las rutas donde se almacenaban los usuarios, por eso no validé

sudo cat /var/log/boot.log

}

op=1;
while [[ "$op" != 0 ]]
do

echo "1) ver estado de un servicio";
echo "2) instalar un paquete dentro del server";
echo "3) ver logs de acceso al server";
echo "4) salir"
read -p "Ingrese una opcion: " op;

case "$op" in
1) showServerStatus;;
2) packageInstall;;
3) showAccessLog;;
4) op=0;;
*) echo "ingrese opciones validas";;
esac
done
