%% ======== Carga Mecánica ======== %%

    % Coeficiente de fricción viscosa en articulación [N.m/(rad/s)]
    b_l = 0.1; % [+- 0.03] 
    
    % Aceleración de la gravedad [m/s^2]
    g = 9.80665; 
    
    % Masa del brazo manipulador [kg]
    m = 1; 
    
    % Longitud al centro de masa [m]
    l_cm = 0.25;
    
    % Inercia equivalente del brazo al centro de masa [kg.m^2]
    J_cm = 0.0208;
    
    % Longitud total del brazo [m]
    l_l = 0.5;
    
    % Masa de carga útil en el extremo [kg]
    m_l = 0; % [+ 1.5]
    
    % Inercia total al eje de rotación [kg.m^2]
    J_l = (m*l_cm^2 + J_cm) + (m_l * l_l^2); % Afectado por incertidumbre

    % Coeficiente de torque recuperador gravitacional [N.m]
    k_l = m * g * l_cm + m_l * g * l_l; % Afectado por incertidumbre

    % Torque de perturbación [N.m]
    T_per = 0; % [+- 5.0]


%% ======== Tren de Transmisión ======== %%

    % Relación de reducción 
    r = 120;

    % Velocidad nominal a la salida [rpm]
    n_l_nom = 60.0;

    % Velocidad nominal a la salida [rad/s]
    w_l_nom = 6.28; 

    % Torque de saldia nominal [N.m]
    T_q_nom = 17.0;

    % Torque de salida máximo [N.m]
    T_q_max = 45.0;
  

%% ======== Máquina Eléctrica ======== %%

    % Momento de inercia motor + caja [kg.m^2]
    J_m = 1.4 * 10^-5; % [+- 1%]
    
    % Coeficiente de fricción viscosa motor + caja [N.m/rad/s]
    b_m = 1.5 * 10^-5; % [+- 1%]

    % Pares de polos magnéticos
    P_p = 3;

    % Flujo magnético equivalente de imanes concatenado por espiras del
    % bobinado de estator [dWb/dt ó V / rad.s]
    lambda_m = 0.016; % [+- 1%]

    % Inductancia del estator, eje en cuadratura [H]
    L_q = 5.8 * 10^-3; % [+- 1%]

    % Inductancia del estator, eje directo [H]
    L_d = 6.6 * 10^-3; % [+- 1%]

    % Inductancia de dispersión del estator [H]
    L_ls = 0.8 * 10^-3; % [+- 1%]

    % Resistencia de estator, por fase a 40ºC [Ohm]
    R_s_40 = 1.02; % [+- 1%]

    % Resistencia de estator, por fase a 115ºC [Ohm]
    R_s_115 = 1.32; % [+- 1%]

    % Coeficiente de aumento de R_s con Temp_s [1/ºC]
    alpha_cu = 3.9 *10^-3;

    % Capacitancia térmica del estator [W/ºC./s]
    C_ts = 0.818; % [+- 1%]

    % Resistencia térmica estator - ambiente [ºC/W]
    R_ts_amb = 146.7; % [+- 1%]

    % Constante de tiempo térmica [s]
    tao_ts_amb = R_ts_amb * C_ts;

    % Velocidad nominal del rotor [rpm]
    n_m_nom = 6600;

    % Velocidad nominal del rotor [rad/s]
    w_m_nom = 691.15;

    % Tensión nominal de línea, corriente alterna eficaz.[V_ca_rms]
    V_sl_nom = 24;

    % Tensión nominal de línea, corriente alterna eficaz.[V_ca_rms]
    V_sf_nom = V_sl_nom / sqrt(3);

    % Corriente nominal en régimen continuo [A_ca_rms]
    I_s_nom = 0.4;

    % Corriente máxima de pico [A_ca_rms]
    I_s_max = 2.0;

    % Temperatura máxima del bobinado del estator [ºC]
    Temp_s_max = 115.0;

    % Rango de temperatura ambiente de operación [ºC]
    Temp_amb = 40; % [-55]   

    % Temperatura de referencia para el cobre [ºC]
    Temp_s_ref = 50;

    % Resistencia del estator a una temperatura dada [ºC]
    R_s = R_s_40 + alpha_cu * Temp_amb;

    % Torque motor [N.m]
    T_m = 0;

    

%% ======== Inversor trifásico ======== %%

    % Ángulo eléctrico de voltaje [rad]
    theta_ev = 0;

    % Tensión de línea [V_ca_rms]
    V_sl = 24; % [-24]

    % Frecuencia sincrónica [Hz]
    f_e = 330; % [-660]

    % Frecuencia angular sincrónica [rad/s]
    w_e = f_e * 2 * pi;

    % Tensiones de fase [V_ca]
    V_as = sqrt(2) * V_sl / sqrt(3) * cos(theta_ev);
    V_bs = sqrt(2) * V_sl / sqrt(3) * cos(theta_ev - 2/3 * pi);
    V_cs = sqrt(2) * V_sl / sqrt(3) * cos(theta_ev + 2/3 * pi);

   
%% ======== Relaciones de la resolución ======== %%

    % Inercia equivalente [kg.m^2]
    J_eq = J_m + (1/r^2) * J_l;

    % Coeficiente de fricción viscosa equivalente [N.m/(rad/s)]
    b_eq = b_m + (1/r^2) * b_l;





    
