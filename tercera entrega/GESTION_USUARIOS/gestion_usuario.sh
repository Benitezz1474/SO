#!/bin/bash


#NOTA: cuando ejecuten el script en sus maquinas , lo ideal sería que le den permisos de root, onda hacer eso: sudo ./script.sh,
#      de esa forma nos ahorramos tener que poner sudo en cada comando
#por si alguno no le da privilegios al script, uso la palbra reservada sudo en los comandos :)

sudo touch /var/log/conceptualScript_logs.log; #no hace falta ya que echo>>archivo crea el archivo sino existe, pero: leer linea 4 y 5 :)

#-------------------------------------crear usuaio------------------------

LOGS="/var/log/conceptualScript_logs.log";

function crearUsuario(){

read -p "ingrese un nombre de usuario " name;

 if [[ -n "$name" ]] then 
   
    if ! grep -q "^$name:" /etc/passwd; then #si el usuario NO existe, entoces....

            read - p "ingrese el tipo de usuario a crear: admin o cliente " typeUser
              if [[ "$typeUser" != "admin" || "$typeUser" != "client" ]]; then
                   echo "debes ingresar un tipo de usuario correcto! ";

               else
                    sudo touch /etc/skel/welcome.txt
                     if [[ "$typeUser" == "admin" ]]; then
                        echo "bienvenido $name, eres un $typeUser" > etc/skel/welcome.txt;
                     elif [[ "$typeOf" == "client" ]]; then
                        echo "bienvenido $name, eres un $typeUser" > etc/skel/welcome.txt;
                    sudo useradd $name; #creo el usuario
                    echo "usuario creado correctamente";
                 fi
               fi
           #debo guardar en los logs la creacion del usuario con fecha y hora
          sudo echo "[$(date)] -> usuario creado: $name" >> "$LOGS";
      else 
           echo "El usuario ya existe";

    fi
else
    echo "debes ingresar datos validos ";

fi
}

#----------------------------------eliminar usuario------------------
function eliminarUsuario(){ #el usuario se elimina de manera bruta; no prgunta.

read -p "ingrese nombre de usuario " name;
if [[ -n "$name" ]] then
  sudo userdel -r $name;
  echo "usuario eliminado!"
   #guardar log
   sudo echo "[$(date)] -> usuario eliminado: $name" >> "$LOGS";

else
 echo "debes datos ingresar validos";
fi

}

#--------------------------------- cambiar clave---------------
function cambiarClave(){

  read -p "ingrese nombre de usuario " name;

     if [[ -n "$name" ]] then
      if grep -q "^$name:" /etc/passwd;then #el usuario existe?
       sudo passwd $name;
       echo "contraseña cambiada correctamente";
         #guardar log
        sudo echo "[$(date)] -> clave modificada: $name " >> "$LOGS";
          else
             echo "el usuario no existe";
         fi
     else
      echo "debes ingresar datos validos";
fi
}
#------------------------------cambiar nombre usuario-------------

function cambiarNombre(){

 read -p "ingrese nombre de usuario a cambiar " name;
 read -p "ingrese NUEVO nombre de usuario " newName;
 
   if [[ -n "$name" && -n "$newName" ]] then
          
      if grep -q "^$name:" /etc/passwd; then #pregunto si el usuario existe
           sudo usermod -l $name $newName;
          #guardar log
          sudo echo "[$(date)] -> nombre usuario cambiado: $name" >> "$LOGS";

           echo "nombre cambiado correctamente";
            else
              echo "usuario no encontrado";
  fi
fi

}
#----------------------------ver contenido de usuarios (nombre,nivel de acceso y comentario) -----------

function verContenido(){

if [[ -e /etc/passwd ]] then
      cat /etc/passwd
else
  echo "el archivo no existe "
fi

}
#----------------------------------ver logs del sistema -------------------------------

function verLogs(){

 echo "REGISTROS/ACCIONES DE USUARIO:";
   cat "$LOGS";

}



#--------------------------->>>>>>>  MAIN <<<<<-----------------------
op=1;
while [[ "$op" != 0 ]]; do

#dejo 3 (3 echo)  espacios para que sea mas facíl la lectura a la hora de ejecutar el script ;
echo "";
echo "";
echo "";

echo "1) crear usuario";
echo "2) cambiar clave de usuario"
echo "3) cambiar nombre de usuario "
echo "4) eliminar usuario"
echo "5) ver contenido de usuario"
echo "6) ver acciones (logs) de usuarios"
echo "0) salir"
read -p "eliga una opcion " op;

echo " ";
echo " ";
echo " ";

case "$op" in

1) crearUsuario ;;
2) cambiarClave ;;
3) cambiarNombre ;;
4) eliminarUsuario ;;
5) verContenido ;;
6) verLogs ;;
0) echo "saliendo...";;
*) echo "ingresa una opcion válida >:(";;
esac

done
