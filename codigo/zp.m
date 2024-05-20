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
% Discretización de 10 pasos por bucle

pasos = 2; % no aplica a temp

all_poles = [];
col = 1;

% 1 - Temperatura ambiente
for Tamb=-15:(40--15)/55:40

    disp(Tamb);

    for bl=(0.1-0.03):(0.1+0.03-(0.1-0.03))/pasos:(0.1+0.03)

        for bm=(1.5*10^(-5)-1.5*10^(-5)*0.01):((1.5*10^(-5)+1.5*10^(-5)*0.01)-(1.5*10^(-5)-1.5*10^(-5)*0.01))/pasos:(1.5*10^(-5)+1.5*10^(-5)*0.01)

            for ml=0:1.5

                for lambdam=(0.016-0.016*0.01):((0.016+0.016*0.01)-(0.016-0.016*0.01))/pasos:(0.016+0.016*0.01)

                    for Lq=(5.8 * 10^-3-5.8 * 10^-3*0.01):((5.8 * 10^+3-5.8 * 10^-3*0.01)-(5.8 * 10^-3-5.8 * 10^-3*0.01))/pasos:(5.8 * 10^-3+5.8 * 10^-3*0.01)

                        for Ld=(6.6 * 10^-3-6.6 * 10^-3*0.01):((6.6 * 10^-3+6.6 * 10^-3*0.01)-(6.6 * 10^-3-6.6 * 10^-3*0.01))/pasos:(6.6 * 10^-3+6.6 * 10^-3*0.01)
                            
                            for Lls= (0.8 * 10^-3-0.8 * 10^-3*0.01):((0.8 * 10^-3+0.8 * 10^-3*0.01)-(0.8 * 10^-3-0.8 * 10^-3*0.01))/pasos:(0.8 * 10^-3+0.8 * 10^-3*0.01)
                            


                                J_eq = J_m + (1/r^2) * J_l;
                                b_eq = b_m + (1/r^2) * b_l;
                                r_s = R_s_40 + (alpha_cu*(Tamb-Temp_s_ref));

                                num = (3/2)*P_p*lambda_m;
                                den = [J_eq*L_q (L_q*b_eq+r_s*J_eq) (r_s*b_eq+(3/2)*P_p^2*lambda_m^2) 0];
                                
                                H_vqs = tf(num, den);
                                
                                z = zero(H_vqs);
                                p = pole(H_vqs);

                                for i=1:3

                                    all_poles(i,col)=p(i);

                                end

                                col = col+1;

                            end
                        end
                    end
                end
            end
        end
    end
end

figure;
title("Posición de todos los polos para un barrido de parámetros compleot de G")
grid minor;
hold on;
ylabel = "Parte imaginaria";
xlabel = "Parte real";
for i=1:length(all_poles(1,:))
    for j=1:length(all_poles(:,1))
    
        if mod(i,10) == 0

            plot(all_poles(j,i),"Marker","*");

        end
    
    end
end
hold off;



