# sort.s
.text
.globl main
main:
#Dados a serem ordenados
	addi $t0, $zero, 1
	sll $t0, $t0, 28
	addi $t1, $zero, 0002
	sw $t1, 0($t0)
	addi $t2, $zero, 0101
	sw $t2, 4($t0)
	addi $t3, $zero, 0071
	sw $t3, 8($t0)
	addi $t2, $zero, 0092
	sw $t2, 12($t0)
	add $a0, $zero, $t0
	addi $a1, $zero, 0004

    jal sort
    syscall
.end main
#Inicio procedimento sort
.globl sort
.text
#Essa parte tem no livro
#Salvando registradores
sort:	addi	$sp, $sp, -20 #cria espaco na pilha para 5 registradores
		sw		$ra, 16($sp) #salva $ra na pilha 
		sw		$s3, 12($sp) #salva $s3 na pilha
		sw		$s2, 8($sp)  #salva $s2 na pilha
		sw		$s1, 4($sp)  #salva $s1 na pilha
		sw		$s0, 0($sp)	 #salva $s0 na pilha
#Corpo do procedimento
#Move parametros	
		add	$s2, $a0, $zero  
		add	$s3, $a1, $zero 
#Loop externo
 		add	$s0, $zero,$zero #i=0 
for1tst:	slt	$t0, $s0, $s3
		beq     $t0, $zero, exit1  #vai para exit1 se $s0 >=$s3
#Loop interno
		addi	$s1, $s0, -1	# j = i-1	
for2tst:	slti $t0, $s1, 0
		bne		$t0, $zero, exit2 
		sll		$t1, $s1, 2 #$t1 = j*4
		add		$t2, $s2, $t1 #$t2 = v + (j*4)
		lw		$t3, 0($t2)
		lw		$t4, 4($t2)
		slt		$t0, $t4, $t3
		beq		$t0, $zero, exit2
#Passa parametros e chama	
		add	$a0, $s2,$zero
		add	$a1, $s1, $zero
		jal		swap
#Loop interno
		addi	$s1, $s1, -1
		j		for2tst		
#Loop externo
exit2:	addi	$s0, $s0, 1
		j		for1tst
#Restaurando registradores			
exit1:	lw 		$s0, 0($sp)
		lw 		$s1, 4($sp)
		lw 		$s2, 8($sp)
		lw 		$s3, 12($sp)
		lw 		$ra, 16($sp)
		addi 	$sp, $sp, 20	
#Retorno do procedimento
		jr			$ra
#Final da parte que tem no livro
.end sort

#Inicio do procedimento swap
.globl swap	
#Essa parte tem no livro 	
swap:	sll		$t1, $a1, 2 #registrador $t1 = k *4
		add		$t1, $a0, $t1	#registrador $t1 = v + (k*4)	
		lw		$t0, 0($t1) #registrador $t0 (temp) = v[k]
		lw		$t2, 4($t1) #resgitrador $t2 = v[k+1]		
		sw		$t2, 0($t1) #v[k] = registrador $t2
		sw		$t0, 4($t1)	 #v[k+1]= registrador $t0(temp)		
		jr		$ra
#Final da parte que tem no livro
.end swap

