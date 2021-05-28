function [model] = make_pictures(model)
params = model_parameters();

%% Ca
model.Ca = shiftdim(model.Ca(:,:,fix(params.test_start_Ca / params.step)));


model.Freq = zeros(params.mneuro, params.nneuro, 5);

%% Neuron frequency training
freq = zeros(params.quantity_neurons, 1);
for i = 1 : params.quantity_neurons
    N_sp = find(model.V_learn(i,:) > params.V_thr);
    freq(i,1) = length(N_sp);
end
model.Freq(:,:,1) = reshape(freq, params.mneuro, params.mneuro);
model.Freq(:,:,1) = model.Freq(:,:,1) ./ params.training_impulse_duration;

%% Neuron frequency test
for i = 1 : 4
    freq = zeros(params.quantity_neurons, 1);
    for k = 1 : params.quantity_neurons
        N_sp = find(model.V_test(i,k,:) > params.V_thr);
        freq(k,1) = length(N_sp);
    end
    model.Freq(:,:,i + 1) = reshape(freq, params.mneuro, params.nneuro);
    model.Freq(:,:,i + 1) = model.Freq(:,:,i + 1) ./ params.after_sample_t_test;
end

end