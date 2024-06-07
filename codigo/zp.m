clc;clear;close all;
parametros;

r_s = R_s_40;

% Definimos la funcion de transferencia para G_vqs

num = (3/2)*P_p*lambda_m;
den = [J_eq*L_q (L_q*b_eq+r_s*J_eq) (r_s*b_eq+(3/2)*P_p^2*lambda_m^2) 0];

H_vqs = tf(num, den);

z = zero(H_vqs);
p = pole(H_vqs);

figure;
pzmap(H_vqs);
title('Diagrama de Polos y Ceros G_{vqs}');
grid on;

% Definimos la funcion de transferencia para G_Tl

num = [L_q/r_s 1];
den = [J_eq*L_q (L_q*b_eq+r_s*J_eq) (r_s*b_eq+(3/2)*P_p^2*lambda_m^2) 0];

H_vqs = tf(num, den);

z = zero(H_vqs);
p = pole(H_vqs);

figure;
pzmap(H_vqs);
title('Diagrama de Polos y Ceros G_{Tl}');
grid on;


% Evaluación de estabilidad por barrido de parámetros para G_vqs y G_Tl
            
J_l_nom = 0.0833;
b_l_nom = 0.1;
b_l_min=0.1-0.03;
b_l_max=0.1+0.03;
m_l_min=0;
m_l_max=1.5;

b_eq_nom = b_m + b_l_nom / r^2;
b_eq_min = b_m + b_l_min / r^2;
b_eq_max = b_m + b_l_max / r^2;

z_b_eq_nom = [];
z_b_eq_min = [];
z_b_eq_max = [];

p_b_eq_nom = [];
p_b_eq_min = [];
p_b_eq_max = [];

for m_l=m_l_min:0.01:m_l_max

    J_l = (m*l_cm^2 + J_cm) + (m_l * l_l^2);

    J_eq = J_m + J_l/r^2;
    
    num = [L_q/r_s 1];
    den = [J_eq*L_q (L_q*b_eq_min+r_s*J_eq) (r_s*b_eq_min+(3/2)*P_p^2*lambda_m^2) 0];

    H = tf(num, den);

    z = zero(H);
    p = pole(H);
    z_b_eq_min = [z_b_eq_min, z];
    p_b_eq_min = [p_b_eq_min, p];

    num = [L_q/r_s 1];
    den = [J_eq*L_q (L_q*b_eq_nom+r_s*J_eq) (r_s*b_eq_nom+(3/2)*P_p^2*lambda_m^2) 0];

    H = tf(num, den);

    z = zero(H);
    p = pole(H);
    z_b_eq_nom = [z_b_eq_nom, z];
    p_b_eq_nom = [p_b_eq_nom, p];

    num = [L_q/r_s 1];
    den = [J_eq*L_q (L_q*b_eq_max+r_s*J_eq) (r_s*b_eq_max+(3/2)*P_p^2*lambda_m^2) 0];

    H = tf(num, den);

    z = zero(H);
    p = pole(H);
    z_b_eq_max = [z_b_eq_nom, z];
    p_b_eq_max = [p_b_eq_max, p];

end


figure;

for i=1:3
    plot(real(p_b_eq_min(i,:)),imag(p_b_eq_min(i,:)),"color","k");
    hold on
end

plot(real(p_b_eq_min(1,1)),imag(p_b_eq_min(1,1)),"marker",'o',"LineWidth",2,"color","b");
plot(real(p_b_eq_min(1,length(p_b_eq_min))),imag(p_b_eq_min(1,length(p_b_eq_min))),"marker",'o',"LineWidth",2,"color","b");
plot(real(p_b_eq_min(2,1)),imag(p_b_eq_min(2,1)),"marker",'*',"LineWidth",1,"color","r");
plot(real(p_b_eq_min(2,length(p_b_eq_min))),imag(p_b_eq_min(2,length(p_b_eq_min))),"marker","*","LineWidth",1,"color","r");
plot(real(p_b_eq_min(3,1)),imag(p_b_eq_min(3,1)),"marker","*","LineWidth",1,"color","g");
plot(real(p_b_eq_min(3,length(p_b_eq_min))),imag(p_b_eq_min(3,length(p_b_eq_min))),"marker","*","LineWidth",1,"color","g");

title("Evolución de polos y ceros para b_{l-min}")
grid on;
hold off

figure;

for i=1:3
    plot(real(p_b_eq_nom(i,:)),imag(p_b_eq_nom(i,:)),"color","k");
    hold on
end

plot(real(p_b_eq_nom(1,1)),imag(p_b_eq_nom(1,1)),"marker",'o',"LineWidth",2,"color","b");
plot(real(p_b_eq_nom(1,length(p_b_eq_nom))),imag(p_b_eq_nom(1,length(p_b_eq_nom))),"marker",'o',"LineWidth",2,"color","b");
plot(real(p_b_eq_nom(2,1)),imag(p_b_eq_nom(2,1)),"marker",'*',"LineWidth",1,"color","r");
plot(real(p_b_eq_nom(2,length(p_b_eq_nom))),imag(p_b_eq_nom(2,length(p_b_eq_nom))),"marker","*","LineWidth",1,"color","r");
plot(real(p_b_eq_nom(3,1)),imag(p_b_eq_nom(3,1)),"marker","*","LineWidth",1,"color","g");
plot(real(p_b_eq_nom(3,length(p_b_eq_nom))),imag(p_b_eq_nom(3,length(p_b_eq_nom))),"marker","*","LineWidth",1,"color","g");

title("Evolución de polos y ceros para b_{l-nom}")
grid on;
hold off

figure;

for i=1:3
    plot(real(p_b_eq_min(i,:)),imag(p_b_eq_min(i,:)),"color","k");
    hold on
end

plot(real(p_b_eq_min(1,1)),imag(p_b_eq_min(1,1)),"marker",'o',"LineWidth",2,"color","b");
plot(real(p_b_eq_min(1,length(p_b_eq_min))),imag(p_b_eq_min(1,length(p_b_eq_min))),"marker",'o',"LineWidth",2,"color","b");
plot(real(p_b_eq_min(2,1)),imag(p_b_eq_min(2,1)),"marker",'*',"LineWidth",1,"color","r");
plot(real(p_b_eq_min(2,length(p_b_eq_min))),imag(p_b_eq_min(2,length(p_b_eq_min))),"marker","*","LineWidth",1,"color","r");
plot(real(p_b_eq_min(3,1)),imag(p_b_eq_min(3,1)),"marker","*","LineWidth",1,"color","g");
plot(real(p_b_eq_min(3,length(p_b_eq_min))),imag(p_b_eq_min(3,length(p_b_eq_min))),"marker","*","LineWidth",1,"color","g");

title("Evolución de polos y ceros para b_{l-min}")
grid on;
hold off
