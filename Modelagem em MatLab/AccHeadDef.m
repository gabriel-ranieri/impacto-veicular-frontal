function status = AccHeadDef(t,y,flag)
% 'OutputFnc' is an option in ODE45 and it has a closed format:
% input variables: time(t), output of ODE45(y), and state information (flag) 
% = 'init' in the first step (initialization state), 
% = 'done' in the last step (final state), 
% = [ ] in all other steps)

%A 'OutputFnc' é implementada para o cálculo da aceleração da cabeça do dummy
%e a armazena em Accelhead
 global k c m L I g Accelhead
 switch(flag) %flag — Current status of the algorithm
   case 'init'   % 'init' — Initialization state
     fprintf('start\n');
     Accelhead = zeros(1,1);
   case 'done'   % 'done' — Final state
     fprintf('done\n');
   case ''    % [] - empty flag
 
     A = [(m(1)+m(2)+m(3)), 1/2 * (m(2)*L(2)*cos(y(3))+2*m(3)*L(2)*cos(y(3))), 1/2 * (m(3)*L(3)*cos(y(5)));
          1/2*(m(2)+2*m(3))*L(2)*cos(y(3)), I(2) + 1/2 * L(2)**2 * cos(y(3))**2 * (m(2)/2 +2*m(3)), 1/2 *m(3)*L(3)*L(2)*cos(y(3))*cos(y(5));
          1/2*L(3)*cos(y(5))*m(3), 1/2*m(3)*L(3)*L(2)*cos(y(3))*cos(y(5)), I(3)+ 1/4*m(3)*L(3)**2 * cos(y(5))**2];
          
     C = [(m(2)/2 * (L(2)*y(4)**2 * sin(y(3))) + m(3)/2 * (2*L(2)*y(4)**2 * sin(y(3)) + L(3)*y(6)**2 * sin(y(5))) - 1/2 * (2*y(1)*(k(1)+k(2)) + (2*y(1)+L(2)*sin(y(3)))*(k(3)+k(4))+k(5)*(2*y(1)+2*L(2)*sin(y(3)+L(3)*sin(y(5))))) - 1/2 *(2*y(2)*(c(1)+c(2))+(2*y(2)+L(2)*y(4)*cos(y(3)))*(c(3)+c(4))+c(5)*(2*y(2)+2*L(2)*y(4)*cos(y(3))+L(3)*y(6)*cos(y(5))))),
          (-m(2)/2 *(-1/4 *L(2)**2 *y(4)**2 *sin(2*y(3))) - m(3)/2 *(-L(2)**2 *y(4)**2 *sin(2*y(3))- L(3)*L(2) * y(6)**2 *cos(y(3))*sin(y(5))) -m(2)*g *(-L(2)/2 *sin(y(3))) - m(3)*g*(-L(2)/2 *sin(y(3))) - 1/2 *(k(3)+k(4))*(L(2)*y(1)*cos(y(3))+L(2)**2/4 *sin(2*y(3))) - k(5)/2 * (2*L(2)*y(1)*cos(y(3)) + L(2)**2 *sin(2*y(3))+L(2)*L(3) *cos(y(3)) *sin(y(5))) - k(6)*y(3) - 1/2 * (c(3)+c(4)) *(L(2)*y(2)*cos(y(3))+L(2)**2 /2 * y(4)*cos(y(3))**2) - c(5)/2 * (2*L(2)*y(2)*cos(y(3)) + 2*L(2)**2 *y(4)*cos(y(3))**2 +L(2)*L(3)*y(6)*cos(y(3)) *cos(y(5)))),
          (-m(3)/2*(-L(3)*L(2)*y(4)**2 *sin(y(3))*cos(y(5))- L(3)**2 /4 *y(6)**2 *sin(2*y(5))) - m(3)*g*(-L(3)/2 *sin(y(5)))-1/2*k(5)*(y(1)*L(3)*cos(y(5))+L(2)*L(3)*sin(y(3))*cos(y(5))+1/4 * L(3)**2 *sin(2*y(5)))-k(7)*y(5)-c(5)/2 *(y(2)*L(3)*cos(y(5))+L(3)*L(2)*y(4)*cos(y(3))*cos(y(5))+L(3)**2 /2 *y(6)*cos(y(5))**2))];
 
 
     B = A\C; #Resolução do sistema Linear AB=C
     
     x_dot2 = B(1); #Aceleração loadngitudinal da massa 1 
     theta1 = y(3); #Deslocamento angular da massa 2 em relação a 1
     theta2 = y(5); #Deslocamento angular da massa 3 em relação a 2
     theta1_dot = y(4); #Velocidade angular da massa 2 em relação a 1
     theta2_dot = y(6); #Velocidade angular da massa 3 em relação a 2
     theta1_dot2 = B(2); #Aceleração angular da massa 2 em relação a 1
     theta2_dot2 = B(3); #Aceleração angular da massa 3 em relação a 2
      
     % Aceleração da cabeça do Dummy [g]
     Accelhead = [Accelhead; (x_dot2 + L(2)*theta1_dot2*cos(theta1)-L(2)*theta1_dot**2*sin(theta1)+L(3)/2 *theta2_dot2*cos(theta2)-L(3)/2 * theta2_dot**2 * sin(theta2))/g];
     status = 0;
 end