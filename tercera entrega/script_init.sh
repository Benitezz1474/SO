#!/bin/bash



op=1;
while [[ "$op" != 0 ]]
do
echo "";
echo "";
echo "1) Respaldos manuales del sistema";
echo "2) Gestion de la base de datos";
echo "3) comming son";
echo "4) comming son";
echo "0) salir";
echo "";
read op;

case "$op" in

1) RESPALDOS/backupBBDD.sh;;
2) GESTIONES_DML/scriptDML_tables.sh;;
0) op=0;;
*) echo "debe ingresar una opcion correcta";;

esac


done
