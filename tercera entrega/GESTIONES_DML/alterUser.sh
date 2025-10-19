#!/bin/bash

#este es el script de gestion de motor de bases de datos (dml)

function userAdd(){ #esta funcion agrega usuarios a la BBDD 

echo "para agregar un usuario a la bbdd debe especificar tipo de usuario y datos de este:"
read -p "ingrese CI para ese usuario: " ci;
read -p "ingrese ROL para ese usuario (cliente o proveedor):" rol;
read -p "ingrese nombre usuario: " name;
read -p "ingrese apellido usuario: " surname;
read -p "ingrese email de usuario: " email;
read -p "ingrese una clave para el usuario: " password;

#validar

#meter en la bbdd

if [[ "$rol" == "cliente" ]] #verifico el rol
then

#meter en la BBDD
sudo mysql -u root -p proyectobd -e "INSERT INTO usuario (CiUsuario, Rol, Nombre, Apellido, Email, Contraseña) VALUES ('$ci', '$rol','$name','$surname','$email','$password')";

echo "usuario insertado correctamente";

else

echo "lo siento, el rol de los usuarios debe ser proveedor o cliente";

fi
}


#userDel
function userDel(){ #esta funcion elimina usuarios de la BBDD

#por cuestion de tiempo, la eliminacion es forzosa, si el usuario existe o no ejecuta
read -p "ingrese CI de usuario a eliminar: " ci;

sudo mysql -u root -p proyectobd -e "DELETE FROM usuario WHERE CiUsuario=$ci";
echo "usuario eliminado";

}

#la funcion userShow => muestra todos los usuarios de la BBD
function userShow(){

sudo mysql -u root -p proyectobd -e "SELECT * FROM usuario";

}

op=1;
while [[ "$op" != 0 ]]
do
echo "";
echo "MENU de consultas DML a la BBDD en tabla usuarios";
echo "1) agregar usuario";
echo "2) eliminar usuario";
echo "3) ver usuarios";
echo "0) salir";
read op;

case "$op" in

1) userAdd ;;
2) userDel;;
3) userShow;;
0) op=0;;
*) echo "Debe ingresar opciones validas";;

esac
done
