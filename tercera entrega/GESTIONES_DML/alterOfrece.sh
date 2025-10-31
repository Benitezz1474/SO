#!/bin/bash

LOG=/var/log/conceptualScripts/mariadb.log;

function showService(){ #debe mostrar los servicios publicados por un usuario

read -p "ingrese CI del usuario (proveedor) para ver los servicios publicados: " ci;
read -p "ingrese el host (ip del servidor donde se encuentra la BBDD): " host;
read -p "ingrese el puerto por el que desea acceder al servicio de BBDD: " port;

if [[ -n "$port" && -n "&host" && -n "$ci" ]]
then

sudo mysql -h "$host" -P "$port" -u root -p proyectobd -e "SELECT * FROM ofrece WHERE ciProveedor=$ci";

 if [[ $? != 0 ]]
  then
     echo "algo salio mal, verifique los datos de entrada";
  fi

else
  echo "debe completar todos los campos"
fi
}

function serviceDel(){ #esta funcion debe eliminar un servicio especifico del proveedor

read -p "ingrese el ID del servicio para eliminar: " id;
read -p "ingrse el host (ip del servidor donde se encuentra la BBDD): " host;
read -p "ingrese el puerto por el que desea acceder al servicio: " port;

if [[ -n "$port" && -n "host" &&  -n "$id"]]
then
   sudo mysql -h "$host" -P "$port" -u root -p proyectobd -e "DELETE FROM ofrece WHERE idServicio=$id";

     if [[ $? != 0 ]]
      then
       echo "algo salio mal, verifique los campos";

        echo "usuario:$USER:fecha:$(date):accion:se intenta eliminar datos de la tabla ofrece" | sudo tee -a "$LOG" > /dev/null;

      else
         echo "servicio eliminado correctamente";
         echo "usuario:$USER:fecha:$(date):accion:elimina resultados de la tabla ofrece" | sudo tee -a "$LOG" > /dev/null;
     fi

else
    echo "debe completar todos los campos";
fi
}


function showServiceProvider(){ #ver los servicios publicados por un proveedor en especifico;

read -p "ingrese CI del proveedor: " ci;
read -p "ingrese ip del host (ip del servidor donde se encuentra la BBDD): " host;
read -p "ingrse el purto por el que desea acceder al servicio: " port;

if [[ -n "$port" && -n "$ci" && -n "$host" ]]
then
   mysql -h "$host" -P "$port" -u root -p proyectobd -e "SELECT * FROM ofrece WHERE CiCLiente=$ci";

     if [[ $? != 0 ]]
      then
       echo "error al conectar con la BBDD";
     fi

else
  echo "debe completar todos los campos";
fi


}

op=1;

while [[ "$op" != 0 ]]
do
echo "";
echo "MENU de servicios publicados (publicaciones) por el proveedor";
echo "1) ver TODOS servicios publicados";
echo "2) eliminar servicio publicacion";
echo "3) ver servicios publicados por UN provedor";
read op;

case "$op" in

1) showService ;;
2) serviceDel ;;

esac
done
