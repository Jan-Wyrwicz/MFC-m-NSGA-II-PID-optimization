function j = pid_search_p_dist(PID)
    global x;      
    x(1) = PID(1);
    x(2) = PID(2);
    x(3) = PID(3);
    x(4) = PID(4);
    x(5) = PID(5);
    x(6) = PID(6);
    out = sim("p_3_MFCm_dist.slx");
    j = [trapz(abs(out.e1obj))*0.001 + trapz(abs(out.e2obj))*0.001, trapz(abs(gradient(out.tau1obj,0.001))*0.001) + trapz(abs(gradient(out.tau2obj,0.001))*0.001)];
end
