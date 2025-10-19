#!/bin/bash


function showServices(){ #esta funcion debe mostrar los servicios contratados por x usuario

read -p "ingrese la CI del usuario para ver los servicios contratados: " ci;

 sudo mysql -u root -p proyectobd -e "SELECT * FROM contrata WHERE CiCliente=$ci";

}

function serviceDel(){ #esta funcion debe eliminar los servicios contratados por x usuarios

read -p "ingrese CI del usuario: " ci;
read -p "ingrese ID del servicio: " id;

sudo mysql -u root -p proyectobd -e "DELETE FROM contrata WHERE CiCliente=$ci AND IdContrato=$id";
echo "contrato eliminado correctamente";

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
