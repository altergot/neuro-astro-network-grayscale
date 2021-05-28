function [Iastro_neuron_expanded, Iastro_neuron] = expand_astrocytes(Ca, Iastro_neuron, neurons_activity,i)

params = model_parameters();

bnh = rem(i, params.shift_window_astro_watch);
for j = 1: params.mastro
    for k = 1: params.nastro
        if ((Ca(j, k) > params.threshold_Ca) && (bnh == 0 ))
            if neurons_activity(j, k) >= params.enter_astro
                Iastro_neuron(j, k, i : i + params.impact_astro) = 1;
            end
        end
    end
end

km = 0;
for j = 1 : params.az : (params.mneuro - params.az)
    kmm = 0;
    for k = 1 : params.az : (params.nneuro - params.az)
        Iastro_neuron_expanded(j : j + params.az, k : k + params.az) = ...
            Iastro_neuron(j - km, k - kmm, i);
        kmm = kmm + 2;
    end
    km = km + 2;
end
Iastro_neuron_expanded = Iastro_neuron_expanded(:)';
end