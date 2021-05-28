function [V, U, G, Isyn] = step_neurons(V, U, G, t_Iapp_met, array_Iapp, ...
    Isyn, Post, Pre, gsyn, Ca, Iastro_neuron, is_test)
params = model_parameters();

%% Input image as rectangle function of applied current to neuronal layer
if t_Iapp_met == 0
    Iapp = zeros(params.mneuro, params.nneuro, 'uint8');
else
    Iapp = array_Iapp(:, :, t_Iapp_met);
end

%% Izhikevich neuron model
Iapp_line = Iapp(:);
Iapp_line = double(Iapp_line);
fired = find(V >= params.neuron_fired_thr);
V(fired) = params.c;
U(fired) = U(fired) + params.d;
I_sum = Iapp_line + Isyn;
V = V + params.step .* 1000 .* (0.04 .* V .^ 2 + 5 .* V + 140 + I_sum - U);
U = U + params.step .* 1000 .* params.aa .* (params.b .* V - U);
V = min(V, params.neuron_fired_thr);

%% Glutamate (neurotransmitter model)
del = zeros(params.quantity_neurons,1);
%del(V == params.neuron_fired_thr) = 1;
del(V > params.V_thr) = 1;
G = G - params.step .* (params.alf .* G - params.k  .* del);

%% Astrocytic modulation of synaptic transmission
if is_test
    km = 0;
    for j = 1 : params.az : (params.mneuro - params.az)
        kmm = 0;
        for k = 1 : params.az : (params.nneuro - params.az)
            Ca1(j : j + params.az, k : k + params.az) = Ca(j - km, k - kmm);
            kmm = kmm + 2;
        end
        km = km + 2;
    end
    Ca = Ca1(:);
    Ca = (Ca - params.threshold_Ca);
    Ca(Ca < 0) = 0;
    Ca = Ca ./ max(Ca) .* params.aep;
end

%% Neuron synaptic currents
S = 1 ./ (1 + exp((-V ./ params.ksyn)));
Isyn = zeros(params.quantity_neurons, 1, 'double');
if is_test
    gsync = gsyn + Ca(Post) .* Iastro_neuron(Post);
else
    gsync = gsyn;
end
Isync = gsync .* S(Pre) .* (params.Esyn - V(Post));
for i = 1 : params.quantity_connections
    Isyn(Post(i)) = Isyn(Post(i)) + Isync(i);
end

end