#!/bin/bash

op=1;
while [[ "$op" != 0 ]]
do

echo "";
echo "MENU de modificaciones de tablas de la BBDD";
echo "1) gestionar usuarios";
echo "2) gestionar publicaciones ";
echo "3) gestionar contrataciones (servicios contratados por el cliente)";
echo "0) salir";
read op;

case "$op" in

1) sudo ./alterUser.sh;;
2) sudo ./alterPublic.sh;;
3) sudo ./alterContrata.sh;;
0) op=0;;
*) echo "debe ingresar opciones validas";;
esac

done



