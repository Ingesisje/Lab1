# Programa en ensamblador MIPS para encontrar el número mayor entre 3 y 5 números ingresados por el usuario
# Autor: Juliana Maria Valencia Ocampo
# Fecha: 18/09/2024

.data
prompt: .asciiz "Ingrese cuántos números desea comparar (entre 3 y 5): "
input_message: .asciiz "Ingrese el número: "
output_message: .asciiz "El número mayor es: "

.text
main:
    # Solicitar al usuario que ingrese cuántos números comparar
    li $v0, 4          # Cargar el syscall para imprimir string
    la $a0, prompt     # Cargar la dirección del prompt
    syscall            # Llamar al syscall para imprimir el prompt

    # Leer la cantidad de números a comparar
    li $v0, 5          # Cargar el syscall para leer integer
    syscall            # Llamar al syscall para leer el número ingresado
    move $t0, $v0      # Guardar la cantidad de números en $t0
    
    # Validar la cantidad de números ingresada
    li $t1, 3          # Cargar 3 en $t1
    bge $t0, $t1, start_loop   # Si $t0 >= 3, iniciar el bucle
    li $a0, 1          # Cargar 1 en $a0 (syscall para imprimir integer)
    li $v0, 1          # Cargar 1 en $v0 (syscall para imprimir integer)
    syscall            # Imprimir el mensaje
    j exit             # Saltar a la etiqueta exit
    
start_loop:
    # Iniciar el bucle para ingresar y comparar los números
    move $s0, $zero    # Inicializar $s0 a 0 (contador de números ingresados)
    move $s1, $zero    # Inicializar $s1 a 0 (número mayor)

input_loop:
    # Solicitar al usuario que ingrese un número
    li $v0, 4          # Cargar el syscall para imprimir string
    la $a0, input_message    # Cargar la dirección del mensaje de entrada
    syscall            # Llamar al syscall para imprimir el mensaje de entrada

    # Leer el número ingresado por el usuario
    li $v0, 5          # Cargar el syscall para leer integer
    syscall            # Llamar al syscall para leer el número ingresado
    move $t2, $v0      # Guardar el número ingresado en $t2

    # Comparar el número ingresado con el número mayor actual
    bgt $t2, $s1, update_max   # Si $t2 > $s1, actualizar $s1 (número mayor)
    addi $s0, $s0, 1   # Incrementar el contador de números ingresados
    blt $s0, $t0, input_loop  # Si $s0 < $t0, volver a input_loop

update_max:
    move $s1, $t2      # Actualizar $s1 con el nuevo número mayor

exit:
    # Mostrar el número mayor encontrado
    li $v0, 4          # Cargar el syscall para imprimir string
    la $a0, output_message   # Cargar la dirección del mensaje de salida
    syscall            # Llamar al syscall para imprimir el mensaje de salida

    # Imprimir el número mayor
    li $v0, 1          # Cargar el syscall para imprimir integer
    move $a0, $s1      # Cargar el número mayor en $a0
    syscall            # Llamar al syscall para imprimir el número mayor

    # Salir del programa
    li $v0, 10         # Cargar el syscall para salir del programa
    syscall            # Llamar al syscall para salir del programa
