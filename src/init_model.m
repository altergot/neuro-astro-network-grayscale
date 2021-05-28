function [model] = init_model(is_test, i)
model = struct;
params = model_parameters();
if is_test
    model.T = 0 : params.step : params.t_end_test;
else
    model.T = 0 : params.step : params.t_end_training;
end
model.T = single(model.T);

%% Zone
if ~is_test
    model.Post = zeros(1, params.quantity_connections, 'int8');
    model.Pre  = zeros(1, params.quantity_connections, 'int8');
end

%% Neurons
if is_test
    model.V_line = zeros(params.quantity_neurons, params.n_test, 'double');
else
    model.V_line = zeros(params.quantity_neurons, params.n_training, 'double');
end
model.V_line(:, 1) = params.v_0;
model.G = zeros(params.quantity_neurons, 1, 'double');
model.U_line = zeros(params.quantity_neurons, 1, 'double');
model.Isyn_line = zeros(params.quantity_neurons, 1,'double');

%% Neuron activity
model.neuron_astrozone_activity = zeros(params.mastro, params.nastro, 1,'int8');
model.Iastro_neuron_line = zeros(params.quantity_neurons, 1,'logical');
if is_test
    model.Iastro_neuron = zeros(params.mastro, params.nastro, params.n_test, 'double');
end

%% Astrocytes
if ~is_test
    model.Ca = zeros(params.mastro, params.nastro, params.n_training,'double');
    model.H = zeros(params.mastro, params.nastro, 1,'double');
    model.IP3 = zeros(params.mastro, params.nastro, 1,'double');
    model.Ca(:,:,1) = params.ca_0;
    model.H(:,:,1) = params.h_0;
    model.IP3(:,:,1) = params.ip3_0;
end

%% Iapp
model.T_Iapp = [params.t_start_stim, params.t_end_stim];
model.T_Iapp = fix( model.T_Iapp ./ params.step);
if is_test
    model.T_Iapp_met = zeros(1, params.n_test);
else
    model.T_Iapp_met = zeros(1, params.n_training);
end

%% Prepare model
if is_test
    [model.Iapp, model.T_Iapp_met] = make_Iapp_test(model.T_Iapp, i);
else
    [model.Iapp, model.T_Iapp_met, model.Image] = make_Iapp_training(model.T_Iapp);
    [model.Post, model.Pre] = create_connections();
end

end