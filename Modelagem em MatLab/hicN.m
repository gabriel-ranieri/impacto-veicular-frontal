function HIC = hicN(acc,n)
  %Esta função é reponsável pelo cálculo do HIC do sistema
  %Calcula a área da curva da aceleração em deteminado intervalo pela soma de Riemann
  %Referência: http://newb.kettering.edu/wp/experientialcalculus/wp-content/uploads/sites/15/2017/05/crash-safety-test.pdf
  
  %Recebe dois parâmetros de entrada:
  %acc: vetor contendo os valores das acelerações (Accelhead para o Dummy)
  %n: tamanho do intervalo em ms para a aceleração média (padrão desse terabalho: 15)
  
  hicMax = 0; # O valor máximo de HIC é armazenado nessa variável
  for i = 1:length(acc)-(n-1) # Todos os intervalos possíveis de tamanho n ms
    RiemannSum = 0;
    for j = i:i+(n-1) #Soma de Riemann para um intervalo
      RiemannSum += acc(i) ;
    endfor
    hic = 0.001*(n)*(abs(RiemannSum/(n)))**(2.5); #Valor de HIC para aquele intervalo [s g^(2.5)]
    if (hic > hicMax) #HIC máximo
      hicMax = hic; 
    endif
  endfor
  HIC = hicMax; #Retorna HIC máximo
  
  endfunction