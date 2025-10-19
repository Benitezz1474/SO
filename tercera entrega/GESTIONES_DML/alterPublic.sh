#!/bin/bash

function publicationDel(){ #elimina publicaciones

 read -p "ingrese ID de la publicacion: " id;

sudo mysql -u root -p proyectobd -e "DELETE FROM publicacion WHERE IdPublicacion=$id";
 echo "Publicacion Eliminada";
}

function showPublication(){ #muestra publicaciones

 sudo mysql -u root -p proyectobd -e "SELECT * FROM publicacion";
}

op=1;
while [[ "$op" != 0 ]]
do

echo ""
echo "MENU tabla publicaciones de la BBDD"

echo "1) eliminar publicaciones";
echo "2) ver publicaciones";
echo "0) salir;"
read op;

case "$op" in

1) publicationDel;;
2) showPublication;;
0) op=0;;
*) echo "Debes ingresar una opcion valida";
esac
done
