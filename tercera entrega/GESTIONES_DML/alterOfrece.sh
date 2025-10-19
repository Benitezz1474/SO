#!/bin/bash


function showService(){ #debe mostrar los servicios publicados por un usuario

read -p "ingrese CI del usuario (proveedor) para ver los servicios publicados: " ci;

sudo mysql -u root -p proyectobd -e "SELECT * FROM ofrece WHERE ciProveedor=$ci";


}

function serviceDel(){ #esta funcion debe eliminar un servicio especifico del proveedor

read -p "ingrese el ID del servicio para eliminar: " id;

sudo mysql -u root -p proyectobd -e "DELETE FROM ofrece WHERE idServicio=$id";

}

op=1;

while [[ "$op" != 0 ]]
do
echo "";
echo "MENU de servicios publicados (publicaciones) por el proveedor";
echo "1) ver servicios publicados";
echo "2) eliminar servicio publicacion"
read op;

case "$op" in

1) showService ;;
2) serviceDel ;;


esac



done
