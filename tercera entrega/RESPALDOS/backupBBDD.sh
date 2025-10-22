#!/bin/bash

LOG_backup=/var/log/conceptualScripts/mariadb_backup.log
LOG_restore=/var/log/conceptualScripts/mariadb_restore.log

function backup(){

read -p "ingrese el nombre de la BBDD a restaurar: " name_data_base;
read -p "ingrese ruta para almacenar la copia (local) de la BBDD: " local_path;
read -p "ingrese el host (ip de su maquina virtual): " host
read -p "ingrese el puerto del contenedor (puerto mapeado): " port;

if [[ -n "$name_data_base" && -n "$local_path" && -n "$host" && -n "$port" ]]
then   #accedo al contenedor mediante el puerto y la ip de la maquina (por defecto es localhost)
  if  mysql -h "$host" -P "$port" -u root -p "$name_data_base" -e "SHOW DATABASES LIKE '$name_data_base'" | grep "^$name_data_base$" > /dev/null; 
     then
     #realizo la copia del fichero.sql
     mysqldump -h "$host" -P "$port" -u root -p "$name_data_base" >"$local_path"/"${name_data_base}_$(date +%d-%m-%Y).sql" > /dev/null;

     echo "usuario:$USER:fecha:$(date):accion:se realiza copia de la BBDD ($name_data_base)" | sudo tee -a "$LOG_backup" > /dev/null;
     echo "respaldo realizado con exito ";

       else
        echo "la base de datos no existe";
        echo "usuario:$USER:fecha:$(date):accion:se intenta realiza copia de la BBDD ($name_data_base)" | sudo tee -a "$LOG_backup" > /dev/null;


    fi

else
  echo "debes completar todos los campos";
fi

}


function restore(){

echo "recuerde que la BBDD debe existir previamente o crearla antes de restaurar";
echo "ingrese el nombre de la BBDD que quiere restaurar: " data_base_name;
read -p "ingrese la ruta de la base de datos (archivo.sql) que desea restaurar: " path;
read -p "ingrese el host (ip de su maquina virtual): " host;
read -p "ingrese el puerto del contenedor (puerto mapeado): " port;

 if [[ -n "$path" && -n "$host" && -n "$port" ]]
then
   mysql -h "$host" -P "$port" -u root -p "$data_base_name" < "$path" 2> /dev/null;

    if [[ $? != 0 ]]
     then
     echo "no se pudo realizar el respaldo, verifique los datos de entrada";
     echo "usuario:$USER:fecha:$(date):accion:se intento realizar una restauracion de la BBDD ($data_base_name)" | sudo tee -a "$LOG_restore" > /dev/null;
      else
       echo "usuario:$USER:fecha:$(date):accion:se intento realizar una restauracion de la BBDD ($data_base_name)" | sudo tee -a "$LOG_restore" > /dev/null;
    fi

  echo "restauracion exitosa"

  else
   echo "debe completar todos los campos"
fi

}


op=1;
while [[ "$op" != 0 ]]
do

echo ""
echo "1) respaldar una BBDD";
echo "2) restaurar una BBDD";
echo "0) salir";
read op;

case "$op" in

1) backup;;
2) restore;;
0)op=0;;
*) echo "debe ingresar una opcion válida";;

esac
done
