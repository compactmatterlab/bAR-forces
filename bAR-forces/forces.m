% Esteban Vazquez-Hidalgo
% last update 11.14.2019
% close all
% clear
params;
options = optimset('Display','off');

%  motorhead spacing exponentially distributed spacing of motor heads
% first motor at (0,0)
for j = 1:nactin
    for i=1:nmotors
        if i==1
            myo_pos(i,1)=0;
        else
            myo_pos(i,1)=myo_pos(i-1,1)+exprnd(mu);
        end
    end
end
% start simulation
while t<runtime
    t=t+1;
    % loop through all filaments at time (t)
    for jj = 1:nactin
        % track number of motors in each state
        state1(t,jj)=0;
        state2(t,jj)=0;
        state3(t,jj)=0;
        state4(t,jj)=0;
%         l(t,jj)=lamda;
        
        % track number of 3-4 transitions
        if t==1
            n34(t,jj)=0;
        else
            n34(t,jj)=n34(t-1,jj);
        end
        %  track integrin attachmet status
        if t == 1
            attch(t,jj) = 0;
        else
            attch(t,jj) = attch(t-1,jj);
        end

        % loop through motors only one state per motor per time point
        % track number of motors in each state
        for motors=1:nmotors
            success = 0;
            
            if state(motors,jj)==1 && success == 0
                strain(motors,jj)=strain(motors,jj)+xx(t-1);
                % strain incorporated into the rate constant
                ks12 = k12*exp((0.5*km*(strain(motors,jj))^2)/(kb*T));
                % this is the probability that it will change state in
                % time delta_t
                a=(1-exp(-ks12*delta_t));
                % if a random variable is less than the probability that
                % it will change state, it will change
                if rand < a
                    prev_state(motors,jj)=1;
                    % next state the motor will go to
                    state(motors,jj)=2;
                    % stores the time when the motor passes to next step
                    tao(motors,jj)=t;
                    % stores the state change count
                    change(motors,jj)=change(motors,jj)+1;
                    % this prevents the motor from going to a new state in
                    % the same time point
                    success = 1;
                    strain(motors,jj)=0;
                    n12(jj)=n12(jj)+1;
                end
            end
            if state(motors,jj)==15 && success == 0
                e1= (1-exp(-ks152*delta_t));
                if rand < e1
                    prev_state(motors,jj)=15;
                    state(motors,jj)=2;
                    tao(motors,jj)=t;
                    success = 1;
                    strain(motors,jj)=0;
                end
            end
            if state(motors,jj)==2 && success == 0
                % 2->3 or 2->15
                ks23 = k23*exp((-0.5*km*(strain(motors,jj))^2)/(kb*T));
                % this is the probability that it will change state in time delta_t
                b1= (1-exp(-ks23*delta_t));
                e2= (1-exp(-k215*delta_t));
                u1=rand;
                u2=b1 + e2;
                bb1 = b1/u2;
                ee2 = e2/u2;
                % if u1 < b1 + e2
                if u2 < 1
                    if t==1
                        % if a random variable is less than the probability
                        % that it will change state, it will change but only
                        % if actin binding site and myosin head are aligned
                        % within a tolerance
                        if ((rem((0+myo_pos(motors,jj)),bsd)<toler) || ...
                                ((bsd-rem((0+myo_pos(motors,jj)),bsd))<toler))...
                                && u1 < b1
                            prev_state(motors,jj)=2;
                            % next state the motor will go to
                            state(motors,jj)=3;
                            % stores the time when the motor passes to next step
                            tao(motors,jj)=t;
                            % stores the state change count
                            change(jj,motors)=change(motors)+1;
                            % this prevents the motor from going to a new state
                            % in the same time point
                            success = 1;
                            if rem((0+myo_pos(motors,jj)),bsd)<toler
                                strain(motors,jj)= rem((0+myo_pos(motors,jj)),bsd);
                            elseif (bsd-rem((0+myo_pos(motors,jj)),bsd))<toler
                                strain(motors,jj)= -(bsd-rem((0+myo_pos(motors,jj)),bsd));
                            end
                        elseif b1 < u1 && u1 < u2
                            prev_state(motors,jj)=2;
                            state(motors,jj)=15;
                            tao(motors,jj)=t;
                            change(motors,jj)=change(motors,jj)+1;
                            success = 1;
                        elseif u1 > u2
                            prev_state(motors,jj)=2;
                            state(motors,jj)=2;
                            tao(motors,jj)=t;
                            success = 1;
                        end
                    else
                        % determine state change with binding distance
                        % if a random variable is less than the probability
                        % that it will change state, it will change but only
                        % if actin binding site and myosin head are aligned
                        % within a tolerance
                        if ((rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd)<toler) || ...
                                ((bsd-rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd))<toler)) ...
                                && u1 < b1
                            prev_state(motors,jj)=2;
                            % next state the motor will go to
                            state(motors,jj)=3;
                            % stores the time when the motor passes to next step
                            tao(motors,jj)=t;
                            % stores the state change count
                            change(motors,jj)=change(motors,jj)+1;
                            % this prevents the motor from going to a new state
                            % in the same time point
                            success = 1;
                            if rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd)<toler
                                strain(motors,jj)= rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd);
                            elseif (bsd-rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd))<toler
                                strain(motors,jj)= -(bsd-rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd));
                            end
                        elseif b1 < u1 && u1 < u2
                            prev_state(motors,jj)=2;
                            state(motors,jj)=15;
                            tao(motors,jj)=t;
                            change(motors,jj)=change(motors,jj)+1;
                            success = 1;
                        elseif u1 > u2
                            prev_state(motors,jj)=2;
                            state(motors,jj)=2;
                            tao(motors,jj)=t;
                            success = 1;
                        end
                    end
                    % if u1 > b1 + e2
                elseif u2 > 1
                    if t==1
                        % if a random variable is less than the probability
                        % that it will change state, it will change but only
                        % if actin binding site and myosin head are aligned
                        % within a tolerance
                        if ((rem((0+myo_pos(motors,jj)),bsd)<toler) || ...
                                ((bsd-rem((0+myo_pos(motors,jj)),bsd))<toler))...
                                && u1 <= bb1
                            prev_state(motors,jj)=2;
                            % next state the motor will go to
                            state(motors,jj)=3;
                            % stores the time when the motor passes to next step
                            tao(motors,jj)=t;
                            % stores the state change count
                            change(jj,motors)=change(motors)+1;
                            % this prevents the motor from going to a new state
                            % in the same time point
                            success = 1;
                            if rem((0+myo_pos(motors,jj)),bsd)<toler
                                strain(motors,jj)= rem((0+myo_pos(motors,jj)),bsd);
                            elseif (bsd-rem((0+myo_pos(motors,jj)),bsd))<toler
                                strain(motors,jj)= -(bsd-rem((0+myo_pos(motors,jj)),bsd));
                            end
                        elseif bb1 < u1 && u1 < bb1 + ee2
                            prev_state(motors,jj)=2;
                            state(motors,jj)=15;
                            tao(motors,jj)=t;
                            change(motors,jj)=change(motors,jj)+1;
                            success = 1;
                        end
                    else
                        %  determine state change with binding distance
                        % if a random variable is less than the probability
                        % that it will change state, it will change but only
                        % if actin binding site and myosin head are aligned
                        % within a tolerance
                        if ((rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd)<toler) || ...
                                ((bsd-rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd))<toler)) ...
                                && u1 <= bb1
                            prev_state(motors,jj)=2;
                            % next state the motor will go to
                            state(motors,jj)=3;
                            % stores the time when the motor passes to next step
                            tao(motors,jj)=t;
                            % stores the state change count
                            change(motors,jj)=change(motors,jj)+1;
                            % this prevents the motor from going to a new state
                            % in the same time point
                            success = 1;
                            if rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd)<toler
                                strain(motors,jj)= rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd);
                            elseif (bsd-rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd))<toler
                                strain(motors,jj)= -(bsd-rem((delta(t-1,jj)+myo_pos(motors,jj)),bsd));
                            end
                        elseif bb1 < u1 && u1 < bb1 + ee2
                            prev_state(motors,jj)=2;
                            state(motors,jj)=15;
                            tao(motors,jj)=t;
                            change(motors,jj)=change(motors,jj)+1;
                            success = 1;
                        end%
                    end
                end
            end
            %3 -> 4 or 3 -> 2
            %  calculate strain on motors
            if state(motors,jj)==3 && success == 0
                strain(motors,jj)=strain(motors,jj)+xx(t-1,jj);
                % strain incorporated into the rate constant
                ks34 = k34*exp((km*(strain(motors,jj))*bsd)/(kb*T));
                ks32 = k32;
                % this is the probability that it will change state in
                % time delta_t
                c=(1-exp(-ks34*delta_t));
                % this is the probability that it will change state in
                % time delta_t
                b2=(1-exp(-ks32*delta_t));
                % random variable 1
                x1=rand;
                x2=c + b2;
                cc = c/x2;
                bb2 = b2/x2;
                %  determine if motors will change states
                % if both random variables are less than the probability
                % that it will change state, it will stay in the same state
                if x2 <= 1
                    if x1 > x2
                        prev_state(motors,jj)=3;
                        % next state the motor will go to
                        state(motors,jj)=3;
                        % stores the time when the motor passes to next step
                        tao(jj,motors)=t;
                        % this prevents the motor from going to a new state in
                        % the same time point
                        success=1;
                        % if a random variable is less than the probability
                        % that it will change state, it will change
                    elseif c < x1 && x1 < x2
                        prev_state(motors,jj)=3;
                        % next state the motor will go to
                        state(motors,jj)=2;
                        % stores the time when the motor passes to next step
                        tao(motors,jj)=t;
                        % stores the state change count
                        change(motors,jj)=change(motors,jj)+1;
                        % this prevents the motor from going to a new state in
                        % the same time point
                        success = 1;
                        strain(motors,jj)=0;
                        % if a random variable is less than the probability
                        % that it will change state, it will change
                    elseif x1 < c
                        prev_state(motors,jj)=3;
                        % next state the motor will go to
                        state(motors,jj)=4;
                        % stores the time when the motor passes to next step
                        tao(motors,jj)=t;
                        % stores the state change count
                        change(motors,jj)=change(motors,jj)+1;
                        % this prevents the motor from going to a new state
                        % in the same time point
                        success=1;
                        n34(t,jj)=n34(t,jj)+1;
                    end%
                elseif x2 > 1
                    if x1 <= cc
                        prev_state(motors,jj)=3;
                        % next state the motor will go to
                        state(motors,jj)=4;
                        % stores the time when the motor passes to next step
                        tao(jj,motors)=t;
                        % this prevents the motor from going to a new state in
                        % the same time point
                        success=1;
                        % if a random variable is less than the probability
                        % that it will change state, it will change
                    elseif cc < x1 && x1 < cc+bb2
                        prev_state(motors,jj)=3;
                        % next state the motor will go to
                        state(motors,jj)=2;
                        % stores the time when the motor passes to next step
                        tao(motors,jj)=t;
                        % stores the state change count
                        change(motors,jj)=change(motors,jj)+1;
                        % this prevents the motor from going to a new state in
                        % the same time point
                        success = 1;
                        strain(motors,jj)=0;
                    end
                end
            end
            %  calculate strain for each motor
            if state(motors,jj)==4 && success == 0
                strain(motors,jj)=strain(motors,jj)+xx(t-1,jj);
                % not a function of strain
                ks41 = k41*1;
                % this is the probability that it will change state in
                % time delta_t
                % determine if the motor will change states
                % if a random variable is less than the probability that
                % it will change state, it will change
                d=(1-exp(-ks41*delta_t));
                if rand < d
                    prev_state(motors,jj)=4;
                    % next state the motor will go to
                    state(motors,jj)=1;
                    % stores the time when the motor passes to next step
                    tao(motors,jj)=t;
                    % stores the state change count
                    change(motors,jj)=change(motors,jj)+1;
                    % stores the step (full completion of cycle) count
                    steps(motors,jj)=steps(motors,jj)+1;
                    % this prevents the motor from going to a new state in
                    % the same time point
                    success = 1;
                end%
            end%
            % array of total steps for each motor
            motorstep(motors,jj)=steps(motors,jj);
            % array of total state changes for each motor
            motorstatechange(motors,jj)=change(motors,jj);
            %  count how many heads are in state 1,2,3,4
            if state(motors,jj)==1
                % count of motors in state 1 for each time point
                state1(t,jj)=state1(t,jj)+1;
            elseif state(motors,jj)==2
                % count of motors in state 2 for each time point
                state2(t,jj)=state2(t,jj)+1;
            elseif state(motors,jj)==3
                % count of motors in state 3 for each time point
                state3(t,jj)=state3(t,jj)+1;
            elseif state(motors,jj)==4
                % count of motors in state 4 for each time point
                state4(t,jj)=state4(t,jj)+1;
            end
        end
        % number of motors in states 1, 3, and 4 (number of motors
        % attached to actin)
        nn(jj) = state3(t,jj) + state1(t,jj) + state4(t,jj);
        % # of motors in state 1 and 4 (number of motors pulling actin)
        N(jj) = state1(t,jj) + state4(t,jj);
        %  calculate size of motorhead step at delta_t
        if t==1% calculation for how far the motor moved at a specific time point
            xx(t,jj) = fsolve(@(x) (-(N(jj)*km*y)+(km*sum(strain(:,jj)))+(nn(jj)*km*x)+...
                (k_spring*x)+F+(drag*x/delta_t)),0,options);
        else
            % calculation for how far the motor moved at a specific time point
            xx(t,jj) = fsolve(@(x) (-(N(jj)*km*y)+(km*sum(strain(:,jj)))+(nn(jj)*km*x)+ ...
                (k_spring*delta(t-1,jj))+(k_spring*x)+F+(drag*x/delta_t)),0,options);
        end
        % calculate total distance at timestep
        if attch(t,jj) == 1
            if t==1
                delta(t,jj) = xx(t,jj);
            else
                delta(t,jj) = delta(t-1)+xx(t,jj);
            end
            % check if myosin has reached end of filament
            if delta(t,jj)<=actlen
                delta(t,jj) = delta(t,jj);
            else
                delta(t,jj) = actlen;
            end
            %  calculate force
            Force(t,jj) = delta(t,jj) * k_spring;
            %  calculate koff and probability
            newrand = rand;
            kslip(t,jj) = ks0 * exp(Force(t,jj) * epsilon/kbT);
            kctch(t,jj) = kc0 * exp(-Force(t,jj) * epsilon/kbT);
            koff(t,jj) = kslip(t,jj) + kctch(t,jj);
            pprob(t,jj) = 1-exp(-koff(t,jj) * delta_t);% probability of detaching
            % check probablility of attached state
            if newrand < pprob(t,jj)
                delta(t,jj) = 0;
                xx(t,jj) = fsolve(@(x) (-(N(jj)*km*y)+(km*sum(strain(:,jj)))+(nn(jj)*km*x)+...
                    +F+(drag*x/delta_t)),0,options);
                Force(t,jj) = 0;
                attch(t,jj) = 0;
            end
        else
            delta(t,jj) = 0;
            Force(t,jj) = 0;
            rand_kon = rand;
            prob_attch(t,jj) = 1  - exp(-k_on*(delta_t));
            if rand_kon<prob_attch(t,jj)
                attch(t,jj) = 1;
            end
        end
    end
end