#!/bin/bash



op=1;
while [[ "$op" != 0 ]]
do
echo "";
echo "";
echo "1) Respaldos y restauraciones manuales de la base de datos";
echo "2) Gestionar la base de datos";
echo "3) Gestionar el uso de recursos (VM y contenedores)";
echo "4) Visualizar logs del servidor (APACHE)";
echo "0) salir";
echo "";
read op;

case "$op" in

1) RESPALDOS/backupBBDD.sh;;
2) GESTIONES_DML/scriptDML_tables.sh;;
3) MONITOREO/script_monitoreo.sh;;
4) GESTIONES_APACHE/apacheLogs.sh;;
0) op=0;;
*) echo "debe ingresar una opcion correcta";;

esac


done
