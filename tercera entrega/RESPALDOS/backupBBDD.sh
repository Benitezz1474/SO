#!/bin/bash

function backup(){

read -p "ingrese el nombre de la BBDD a restaurar: " name_data_base;
read -p "ingrese ruta para almacenar la copia (local) de la BBDD: " local_path;

if [[ -n "$name_data_base" && -n "$local_path" ]]
then
    if  mysql -u root -p proyectobd -e "SHOW DATABASES LIKE '$name_data_base'" | grep "^$name_data_base$" > /dev/null; 
     then

     mysqldump -u root -p "$name_data_base" > "$local_path/${name_data_base}_$(date +%d-%m-%Y).sql" > /dev/null

     echo "respaldo realizado con exito ";

       else
        echo "la base de datos no existe";

    fi

else
  echo "debes completar todos los campos"

fi

}


function restore(){

echo "recuerde que la BBDD debe existir previamente o crearla antes de restaurar";
read -p "ingrese la ruta de la base de datos (archivo.sql) que desea restaurar: " path;

 if [[ -f "$path" ]]
then
   mysql -u root -p < "$path";

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
echo "3) subir una copia de la BBDD al servidor;"
echo "4) descargar una copia de la BBDD desde el servidor";
echo "0) salir";
read op;

case "$op" in

1) backup;;
2) restore;;
0)op=0;;
*) echo "debe ingresar una opcion válida";;

esac
done
