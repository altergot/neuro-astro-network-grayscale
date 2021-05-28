function [neuron_astrozone_activity] = get_neuron_astrozone_activity(G)
params = model_parameters();

glutamate = reshape(G, params.mneuro, params.nneuro);
neuron_astrozone_activity = zeros(params.mastro, params.nastro);
sj = 0;
for j = 1 : params.az : (params.mneuro - params.az)
    sk = 0;
    for k = 1 : params.az : (params.nneuro - params.az)
        neuron_astrozone_activity(j - sj, k - sk) = ...
            sum(glutamate(j : j + params.az, k : k + params.az), 'all');
        sk = sk + 2;
    end
    sj = sj + 2;
end
end