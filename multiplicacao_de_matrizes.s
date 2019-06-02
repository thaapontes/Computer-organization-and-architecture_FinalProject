	.data 0x10000000 #Primeiro conjunto de valores alocado a partir da posicao 10000000 da memoria para a matriz A
	matriza: .word 19,22,34,82
	.data 0x10000020 #Segundo conjunto de valores alocado a partir da posicao 10000020 da memoria para a matriz B
	matrizb: .word 77,44,23,52
	.data 0x10000040 #Resultado da multiplicacao sera alocado na matriz C a partir da posicao 10000040
	matrizc:
	.text
	.globl main
main:
	la	$a0, matriza #load address
	la	$a1, matrizb #Load address
	la	$a2, matrizc #load address
	addi	$a3, $zero, 2 # o registrador $a3 contém o numero de colunas
	add	$t1, $a3, $zero	 # o registrador temporario $t1 contém o numero de colunas
	add	$s0, $zero, $zero # o registrador $s0 recebe zero, esse registrador representa i de linhas

L1:	add	$s1, $zero, $zero 
	
L2:	add $s2, $zero, $zero	
	mul	$t2, $s0, $t1	
	add	$t2, $t2, $s1	
	sll	$t2, $t2, 2		
	add	$t2, $a2, $t2	
			
L3:	mul	$t0, $s2, $t1
	add	$t0, $t0, $s1					
	sll	$t0, $t0, 2						
	add	$t0, $a1, $t0					
	lw	$t3, 0($t0)						
	mul	$t0, $s0, $t1
	add	$t0, $t0, $s2						
	sll	$t0, $t0, 2						
	add	$t0, $a0, $t0					
	lw	$t4, 0($t0)						
	mul	$t3, $t3, $t4
	add	$t6, $t6, $t3
	addi	$s2, $s2, 1
	bne $s2, $t1, L3
	sw	$t6, 0($t2)
	add	$t6, $zero, $zero 
	addi	$s1, $s1, 1
	bne $s1, $t1, L2
	addi	$s0, $s0, 1
	bne	$s0, $t1, L1
	syscall
			
			
			
