function j = pid_search_v_load(PID)
    global x;      
    x(1) = PID(1);
    x(2) = PID(2);
    x(3) = PID(3);
    x(4) = PID(4);
    out = sim("v_3_MFCm_load.slx");
    j = [trapz(abs(out.e1obj))*0.001 + trapz(abs(out.e2obj))*0.001, trapz(abs(gradient(out.tau1obj(),0.001))*0.001) + trapz(abs(gradient(out.tau2obj,0.001))*0.001)];
end
