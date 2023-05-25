function HIC = hicN(acc,n)
  %Esta fun��o � repons�vel pelo c�lculo do HIC do sistema
  %Calcula a �rea da curva da acelera��o em deteminado intervalo pela soma de Riemann
  %Refer�ncia: http://newb.kettering.edu/wp/experientialcalculus/wp-content/uploads/sites/15/2017/05/crash-safety-test.pdf
  
  %Recebe dois par�metros de entrada:
  %acc: vetor contendo os valores das acelera��es (Accelhead para o Dummy)
  %n: tamanho do intervalo em ms para a acelera��o m�dia (padr�o desse terabalho: 15)
  
  hicMax = 0; # O valor m�ximo de HIC � armazenado nessa vari�vel
  for i = 1:length(acc)-(n-1) # Todos os intervalos poss�veis de tamanho n ms
    RiemannSum = 0;
    for j = i:i+(n-1) #Soma de Riemann para um intervalo
      RiemannSum += acc(i) ;
    endfor
    hic = 0.001*(n)*(abs(RiemannSum/(n)))**(2.5); #Valor de HIC para aquele intervalo [s g^(2.5)]
    if (hic > hicMax) #HIC m�ximo
      hicMax = hic; 
    endif
  endfor
  HIC = hicMax; #Retorna HIC m�ximo
  
  endfunction