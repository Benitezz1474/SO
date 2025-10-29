#!/bin/bash

#monitoreo de red
function showNetwork(){

 sudo ss -tuln #informacion detallada de la red;

read -p "desea ver el estado de red del contenedor (y/n) ?" option

 if [[ "$option" == "y" || "$option" == "Y" || "$option" == "yes" || "$option" == "YES" ]]

   then

   read -p "ingrese nombre del contenedor para monitorear su red: " name;

    if sudo docker ps -a | grep -q "$name$";
     then

       echo "INSTANTÁNEA DE RED:";
       #muestra una instantánea del trafico der actual, mostrando puertos, protocolos de comunicacion y los puertosss
        sudo docker exec -it apache2 ss -tuln;

        read -p "¿desea ver informacion detallada en tiempo real? (y/n):" option;
         echo "NOTA: para salir, deberá puslar 'ctrl' + 'c' o '^C'"

         if [[ "$option" == "y" || "$option" == "Y" || "$option" == "yes" || "$option" == "YES" ]]
           then

             echo "";
              echo "TRAFICO DE RED EN TIEMPO REAL:";
                sudo docker exec -it apache2 iftop -t;
            fi
     else
       echo "el contenedor no existe";
     fi

fi
}


#CPU RECURSOS

function showCPU(){

 echo ""
 echo "USO CPU DE LA MAQUINA VIRTUAL:";
 read -p "NOTA: para salir, deberá puslar 'ctrl' + 'c' o '^C'. Presione cualquier telca para continuar";

   htop; #muestra uso de recursos actual

  echo "";
  echo "USO RAM DE LA MAQUINA VIRTUAL:";

   free -h; #memoria

   read -p "¿desea ver el consumo de recursos CPU Y RAM de algun contenedor de forma detallada (y/n) ?: " option;

   if [[ "$option" == "y" || "$option" == "Y" || "$option" == "yes" || "$option" == "YES" ]]

    then
      read -p "ingrese el nombre del contenedor: " name;
      if sudo docker ps -a | grep -q "$name$";
      then
        sudo docker top "$name"; #uso de CPU;
         read -p "NOTA: para salir, deberá puslar 'ctrl' + 'c' o '^C'";
        sudo docker stats --format "table {{.Name}}\t{{.MemUsage}}"; #ram con formato personalizado
       else
      echo "el contenedor no existe";
    fi

fi
}

op=1;
while [[ "$op" != 0 ]]
do

echo "";
echo "MEMU de monitoreo de RECURSOS";
echo "";
echo "1) monitoreo de la red ";
echo "2) monitoreo del CPU y RAM";
echo "0) salir"
read op;

echo ""

case "$op" in

1) showNetwork;;
2) showCPU;;
0) op=0;;
*) ingrese una opcion valida;;

esac

done
