#!/bin/bash

#-------------------------------------crear usuaio------------------------
function crearUsuario(){

read -p "ingrese un nombre de usuario" name;

 if [[ -n "$name" ]] then 
         
           sudo useradd $name; #creo el usuario
           sudo passwd $name; #le asigno una clave
           echo "usuario creado correctamente";
           

else
    echo "debes ingresar datos validos";

fi
}

#----------------------------------eliminar usuario------------------
function eliminarUsuario(){

read -p "ingrese nombre de usuario" name;
if [[ -n "$name" ]] then
  sudo userdel -r $name;
  echo "usuario eliminado!"
else
 echo "debes datos ingresar validos";
fi

}

#--------------------------------- cambiar clave---------------
function cambiarClave(){

  read -p "ingrese nombre de usuario" name;
   
     if [[ -n "$name" ]] then
      
       sudo passwd $name;
       echo "contraseña cambiada correctamente";

      else
         echo "debes ingresar datos validos";
fi
}
#------------------------------cambiar  nombre usuario-------------

function cambiarNombre(){

 read -p "ingrese nombre de usuario a cambiar" name;
 read -p "ingrese NUEVO nombre de usuario" newName;
 
   if [[ -n "$name" && -n "$newName" ]] then
          
           sudo usermod -l $name $newName;
           echo "nombre cambiado correctamente";


fi

}
#----------------------------ver contenido de usuarios (nombre,nivel de acceso y comentario) -----------



#--------------------------->>>>>>>  MAIN <<<<<-----------------------
op=1;
while [[ "$op" != 0 ]]; do

echo "1) crear usuario";
echo "2) cambiar clave de usuario"
echo "3) cambiar nombre de usuario "
echo "4) eliminar usuario"
echo "5) ver contenido de usuario"
echo "0) salir"
read -p "eliga una opcion" op;

case "$op" in

1) crearUsuario ;;
2) cambiarClave ;;
3) cambiarNombre ;;
4) eliminarUsuario ;;


esac

done

