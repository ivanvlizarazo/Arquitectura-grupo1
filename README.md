# Arquitectura-grupo1
Integrantes:
Valentina Rendón Acosta 1088345193
Jorge Iván Villada Lizarazo 1116267609
Karen Lopez 1088338015

------------procesador 3-----------

load - store

ld[address], reg(rd) va a un address que es calculado como una suma y va al DM y dependiendo el address, los saca y los almacena en el RF

st reg(rd) [address] va a la memoria de datos, calcula el address (suma) y lo utiliza para almacenar el contenido del registro destino

nueva señal CRD

address <-- crs1 + crs2
            crs+sev(imm13)

load y store son de formato 3 el op es 11 
el op es de 6 bits

al RF le entra una nueva señal llamada WREN (write enable) que me deshabilita la escritura en el RF
cuando hay un store, tiene que almacenar dato en el DM y no en el RF, eso lo hace la UC

wrnem-- nueva señal

cuando hay un store, uso el nuevo mux para que me deje pasar la señal de arriba de la DM 
al nuevo mux le entra el resultado de la ALU y el CDR 

en la UC aparecen más señales 

el Dm es una RAM que tien un puerto de lectura y escritura (será asíncrona)

--------------procesador 4-----------------------

Branches: son saltos condicionados y saltos relativos y tienen un bit de anulación, (no lo tendremos en cuenta)

cmp %l0, 5 --> subcc
beq label

formato 2
      op -> 00
      op2-> 0100
 si hay un branch se tiene que ir a ver el "cond" que me verifica qué branch voy a utilizar (en total son 16)
 
 cuando hay un branch y es tomado el PC se modifica PC <-- PC + SEU(disp22) "lógica de saltos
 
 hay nuevo mux de 4 a 1: 
 
disp22 son los 22 bits menos significativos de lo que sale del IM y se le hace extension de signo

el carry del psr entra a la ALU
