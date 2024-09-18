# Programa en ensamblador MIPS para generar y sumar números de la serie Fibonacci
# Autor: Juliana Maria Valencia Ocampo
# Fecha: 18/09/24

.data
prompt: .asciiz "Ingrese cuántos números de la serie Fibonacci desea generar: "
output_message: .asciiz "La serie Fibonacci generada es: "
sum_message: .asciiz "La suma de la serie Fibonacci es: "

.text
main:
    # Solicitar al usuario cuántos números de Fibonacci desea generar
    li $v0, 4          # Cargar el syscall para imprimir string
    la $a0, prompt     # Cargar la dirección del prompt
    syscall            # Llamar al syscall para imprimir el prompt

    # Leer la cantidad de números a generar
    li $v0, 5          # Cargar el syscall para leer integer
    syscall            # Llamar al syscall para leer el número ingresado
    move $t0, $v0      # Guardar la cantidad de números en $t0
    
    # Validar la cantidad de números ingresada
    bgt $t0, $zero, start_loop   # Si $t0 > 0, iniciar el bucle
    li $a0, 1          # Cargar 1 en $a0 (syscall para imprimir integer)
    li $v0, 1          # Cargar 1 en $v0 (syscall para imprimir integer)
    syscall            # Imprimir el mensaje de error o solicitud nuevamente
    j exit             # Saltar a la etiqueta exit si no se cumple la condición
    
start_loop:
    # Iniciar el bucle para generar y sumar la serie Fibonacci
    li $t1, 0          # Inicializar el primer número de Fibonacci a 0
    li $t2, 1          # Inicializar el segundo número de Fibonacci a 1
    li $t3, 2          # Inicializar el contador a 2 (porque ya tenemos los dos primeros números)
    move $t4, $zero    # Inicializar el acumulador de la suma a 0

fib_loop:
    # Verificar si hemos generado suficientes números de Fibonacci
    bge $t3, $t0, print_result   # Si el contador >= cantidad deseada, imprimir resultado

    # Generar el siguiente número de Fibonacci y sumarlo al acumulador
    add $t5, $t1, $t2   # $t5 = $t1 + $t2 (siguiente número de Fibonacci)
    add $t4, $t4, $t5   # Sumar $t5 al acumulador de la suma

    # Preparar los valores para la próxima iteración
    move $t1, $t2       # Mover $t2 a $t1 (el segundo número se convierte en el primero)
    move $t2, $t5       # Mover $t5 a $t2 (el siguiente número se convierte en el segundo)
    addi $t3, $t3, 1    # Incrementar el contador

    # Volver al inicio del bucle para generar el siguiente número de Fibonacci
    j fib_loop

print_result:
    # Imprimir la serie Fibonacci generada
    li $v0, 4           # Cargar el syscall para imprimir string
    la $a0, output_message  # Cargar la dirección del mensaje de salida
    syscall             # Llamar al syscall para imprimir el mensaje de salida

    # Imprimir el valor de la suma de la serie Fibonacci
    li $v0, 4           # Cargar el syscall para imprimir string
    la $a0, sum_message  # Cargar la dirección del mensaje de suma
    syscall             # Llamar al syscall para imprimir el mensaje de suma

    li $v0, 1           # Cargar el syscall para imprimir integer
    move $a0, $t4       # Cargar el valor de la suma en $a0
    syscall             # Llamar al syscall para imprimir el valor de la suma

exit:
    # Salir del programa
    li $v0, 10          # Cargar el syscall para salir del programa
    syscall             # Llamar al syscall para salir del programa
