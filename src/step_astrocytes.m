function [Ca, h, IP3] = step_astrocytes(neurons_activity, Ca, h, IP3)
params = model_parameters();
diffusion_Ca = zeros(params.mastro, params.mastro,'double');
diffusion_IP3 = zeros(params.mastro, params.mastro,'double');
array_I_neuro = zeros(params.mastro, params.mastro,'double');
for j = 1 : params.mastro
    for k = 1 : params.nastro
        
        if neurons_activity(j, k) >= params.min_neurons_activity
            array_I_neuro(j, k) = neurons_activity(j, k);
        end
        
        %% Compute calcium and IP3 diffusion betweeb neighbors
        if (j == 1) && (k == 1)
            diffusion_Ca = Ca(j + 1, k) + Ca(j,k + 1) - 2 * Ca(j,k);
            diffusion_IP3 = IP3(j + 1, k) + IP3(j,k + 1) - 2 * IP3(j,k);
        elseif (j == params.mastro) && (k == params.nastro)
            diffusion_Ca = Ca(j - 1, k) + Ca(j,k - 1) - 2 * Ca(j,k);
            diffusion_IP3 = IP3(j - 1, k) + IP3(j,k - 1) - 2 * IP3(j,k);
        elseif (j == 1) && (k == params.nastro)
            diffusion_Ca = Ca(j + 1, k) + Ca(j,k - 1) - 2 * Ca(j,k);
            diffusion_IP3 = IP3(j + 1, k) + IP3(j,k - 1) - 2 * IP3(j,k);
        elseif (j == params.mastro) && (k == 1)
            diffusion_Ca = Ca(j - 1, k) + Ca(j,k + 1) - 2 * Ca(j,k);
            diffusion_IP3 = IP3(j - 1, k) + IP3(j,k + 1) - 2 * IP3(j,k);
        elseif j == 1
            diffusion_Ca = Ca(j + 1, k) + Ca(j, k - 1) + Ca(j,k + 1) - 3 * Ca(j,k);
            diffusion_IP3 = IP3(j + 1, k) + IP3(j, k - 1) + IP3(j,k + 1) - 3 * IP3(j,k);
        elseif j == params.mastro
            diffusion_Ca = Ca(j - 1, k) + Ca(j, k - 1) + Ca(j,k + 1) - 3 * Ca(j,k);
            diffusion_IP3 = IP3(j - 1, k) + IP3(j, k - 1) + IP3(j,k + 1) - 3 * IP3(j,k);
        elseif k == 1
            diffusion_Ca = Ca(j - 1, k) + Ca(j + 1, k) + Ca(j,k + 1) - 3 * Ca(j,k);
            diffusion_IP3 = IP3(j - 1, k) + IP3(j + 1, k) + IP3(j,k + 1) - 3 * IP3(j,k);
        elseif k == params.nastro
            diffusion_Ca = Ca(j - 1, k) + Ca(j + 1, k) + Ca(j,k - 1) - 3 * Ca(j,k);
            diffusion_IP3 = IP3(j - 1, k) + IP3(j + 1, k) + IP3(j,k - 1) - 3 * IP3(j,k);
        elseif (j > 1) && (j < params.mastro) && (k > 1) && (k < params.nastro)
            diffusion_Ca = Ca(j - 1, k) + Ca(j + 1, k) + Ca(j, k - 1) + Ca(j,k + 1) - 4 * Ca(j,k);
            diffusion_IP3 = IP3(j - 1, k) + IP3(j + 1, k) + IP3(j, k - 1) + IP3(j,k + 1) - 4 * IP3(j,k);
        end
        
        %% Astrocyte model
        X = [Ca(j, k) h(j, k) IP3(j, k)];
        I_neuro = array_I_neuro(j, k);
        w1 = runge_astro(0, X,                      I_neuro, diffusion_Ca, diffusion_IP3);
        w2 = runge_astro(0, X + params.u2   .* w1', I_neuro, diffusion_Ca, diffusion_IP3);
        w3 = runge_astro(0, X + params.u2   .* w2', I_neuro, diffusion_Ca, diffusion_IP3);
        w4 = runge_astro(0, X + params.step .* w3', I_neuro, diffusion_Ca, diffusion_IP3);
        X = X + params.u6 .* (w1' + 2 .* w2' + 2 .* w3' + w4');
        Ca(j, k) = X(1);
        h(j, k) = X(2);
        IP3(j, k) = X(3);
        
    end
end
end