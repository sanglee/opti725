function [Xs,fcn_vals,stepsizes] = gd_fixed_stepsize(fcn,grad_fcn,init_X,nb_steps,stepsize0,bt_rate,nb_bt_steps,slope_ratio)
    
    ss = stepsize0;
    stepsizes(1) = ss;
    Xs(1,:) = init_X;
    fcn_vals(1) = fcn(Xs(1,1),Xs(1,2));
    for i=2:nb_steps
        stepsizes(i) = ss;
        gradvec = grad_fcn(Xs(i-1,1),Xs(i-1,2));
        Xs(i,:) = Xs(i-1,:) - ss*gradvec;
        fcn_vals(i) = fcn(Xs(i,1),Xs(i,2));
        %------
        %if fcn_vals(i) > fcn_vals(i-1)-slope_ratio*ss*norm(gradvec)^2;
            %ss = ss*bt_rate;
        %end
        btcounter=0;
        while fcn_vals(i) > fcn_vals(i-1)-slope_ratio*ss*norm(gradvec)^2;
            ss = ss*bt_rate;
            if btcounter>nb_bt_steps, break; end
            btcounter = btcounter+1;
        end
        %------
    end

end
