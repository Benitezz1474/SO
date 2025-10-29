

#!/bin/bash

#monitoreo de red
function showNetwork(){

 read -p "ingrese nombre del contenedor para monitorear su red (por defecto es apache): " name;

  if sudo docker ps -a | grep -q "$name$";
   then

    echo "INSTANTÁNEA DE RED:";
    #muestra una instantánea del trafico der actual, mostrando puertos, protocolos de comunicacion y los puertosss
    sudo docker exec -it apache2 ss -tuln;

   read -p "¿desea ver informacion detallada en tiempo real? (y/n):" option;
   echo "NOTA: para salir, deberá puslar 'ctrl' + 'c' o '^C'"

       if [[ "$option" == "y" || "$option" == "Y" || "$option" == "yes" || "$option" == "YES" ]]
         then

           echo ""
            echo "TRAFICO DE RED EN TIEMPO REAL:";
              sudo docker exec -it apache2 iftop -t;
       fi

 else

   echo "el contenedor no existe";

fi
}


op=1;
while [[ "$op" != 0 ]]
do

echo "";
echo "MEMU de monitoreo de RECURSOS";
echo "";
echo "1) monitoreo de la red ";
echo "2) monitoreo del CPU ";
read op;

echo ""

case "$op" in

1) showNetwork;;
0) op=0;;
*) ingrese una opcion valida;;

esac

done
