# Arquitectura-grupo1
Integrantes:
Valentina Rendón Acosta 1088345193
Jorge Iván Villada Lizarazo 1116267609
Karen Lopez 1088338015


1) regitser file debe modificarse no va a ser de 32 sino un modulo con 40 registros (0-39)
rs1,rs2,rd va a ser nrs1,nrs2,nrd de 6 bits diferente a los 5 bits del anterior

los registros O de la ventana 0 y con los i de la ventana 1y los 0 de la ventana 1 a los i de la ventana 0

cwp-> (current window pointer) saco valor ventana que estoy 
      psr(4:0)
      (Processor state register)
                                 
de una ventana 1 a la ventana 0 hay 16 registros de disntancia  
============================ window manager =============================================
when sean registros de  salida (O) o locales ( L locals) nrs1 <= rs1 +(cwp * 16)
when sean registros locales ( i       ) nrs1 <= rs1 -(cwp * 16)
nrd <= rd (cwp * 16)

windows manager => traducir registros de una venbtana a la otra 
                   
Save => formato 3 cuando llega save lee el ncwp(nuevo cwp)= cwp -1
restore => formato 3 cuando llega save lee el ncwp(nuevo cwp)= cwp +1
suman registro fuente 1 y registro fuente 2 del actual y lo guardan en la ventana nueva o la que voy
orden (save rs1 | )

calcula nueva direcciones con lo anterior

================================================================================================
psr  registro de 5 bits, tarea de almacena NZVC del icc |registro debe tener clock 
y la ventana 0 ó 1 

entras NVZC
entra 1 bit del cwp
================================================================================================
psr modifier registro  hace lo de la pagina 170 de sparcv8

entra aluresult ->(32 bits)
        csr1 -> (4 bits)
        op2 -> (1 bit el más significativo )
        ALUOP -> (6bits)
 sale NVZC       
      
=============================================================================================

lógicas no deben tener ni carry ni overflow solo 
