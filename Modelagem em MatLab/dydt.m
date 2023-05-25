function ydot = dydt(t,y)
%Equações Diferenciais Ordinárias do Sistema
%As acelerações são calculadas a partir da resolução de um sistema linear gerado pela aplicação das equações de Lagrange no sistema proposto para o Dummy
 global k c m L I g Accelhead
 ydot = zeros(6,1);
 %Velocidades
 ydot(1) = y(2);
 ydot(3) = y(4);
 ydot(5) = y(6);

 A = [(m(1)+m(2)+m(3)), 1/2 * (m(2)*L(2)*cos(y(3))+2*m(3)*L(2)*cos(y(3))), 1/2 * (m(3)*L(3)*cos(y(5)));
      1/2*(m(2)+2*m(3))*L(2)*cos(y(3)), I(2) + 1/2 * L(2)**2 * cos(y(3))**2 * (m(2)/2 +2*m(3)), 1/2 *m(3)*L(3)*L(2)*cos(y(3))*cos(y(5));
      1/2*L(3)*cos(y(5))*m(3), 1/2*m(3)*L(3)*L(2)*cos(y(3))*cos(y(5)), I(3)+ 1/4*m(3)*L(3)**2 * cos(y(5))**2];
      
 C = [(m(2)/2 * (L(2)*y(4)**2 * sin(y(3))) + m(3)/2 * (2*L(2)*y(4)**2 * sin(y(3)) + L(3)*y(6)**2 * sin(y(5))) - 1/2 * (2*y(1)*(k(1)+k(2)) + (2*y(1)+L(2)*sin(y(3)))*(k(3)+k(4))+k(5)*(2*y(1)+2*L(2)*sin(y(3)+L(3)*sin(y(5))))) - 1/2 *(2*y(2)*(c(1)+c(2))+(2*y(2)+L(2)*y(4)*cos(y(3)))*(c(3)+c(4))+c(5)*(2*y(2)+2*L(2)*y(4)*cos(y(3))+L(3)*y(6)*cos(y(5))))),
     (-m(2)/2 *(-1/4 *L(2)**2 *y(4)**2 *sin(2*y(3))) - m(3)/2 *(-L(2)**2 *y(4)**2 *sin(2*y(3))- L(3)*L(2) * y(6)**2 *cos(y(3))*sin(y(5))) -m(2)*g *(-L(2)/2 *sin(y(3))) - m(3)*g*(-L(2)/2 *sin(y(3))) - 1/2 *(k(3)+k(4))*(L(2)*y(1)*cos(y(3))+L(2)**2/4 *sin(2*y(3))) - k(5)/2 * (2*L(2)*y(1)*cos(y(3)) + L(2)**2 *sin(2*y(3))+L(2)*L(3) *cos(y(3)) *sin(y(5))) - k(6)*y(3) - 1/2 * (c(3)+c(4)) *(L(2)*y(2)*cos(y(3))+L(2)**2 /2 * y(4)*cos(y(3))**2) - c(5)/2 * (2*L(2)*y(2)*cos(y(3)) + 2*L(2)**2 *y(4)*cos(y(3))**2 +L(2)*L(3)*y(6)*cos(y(3)) *cos(y(5)))),
     (-m(3)/2*(-L(3)*L(2)*y(4)**2 *sin(y(3))*cos(y(5))- L(3)**2 /4 *y(6)**2 *sin(2*y(5))) - m(3)*g*(-L(3)/2 *sin(y(5)))-1/2*k(5)*(y(1)*L(3)*cos(y(5))+L(2)*L(3)*sin(y(3))*cos(y(5))+1/4 * L(3)**2 *sin(2*y(5)))-k(7)*y(5)-c(5)/2 *(y(2)*L(3)*cos(y(5))+L(3)*L(2)*y(4)*cos(y(3))*cos(y(5))+L(3)**2 /2 *y(6)*cos(y(5))**2))];
 
 B = A\C; # Resolução do sistema Linear AB=C
 
 % Acelerações
 ydot(2) = B(1);
 ydot(4) = B(2);
 ydot(6) = B(3);

end