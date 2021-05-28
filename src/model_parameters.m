function [params] = model_parameters(need_set)
persistent params_p
if nargin < 1 || ~need_set
    params = params_p;
    return;
end
params = struct;

%% Timeline
params.t_end_training = 1.9;
params.t_end_test = 0.7;
params.step = 0.0001;
params.n_training = fix(params.t_end_training / params.step);
params.n_test = fix(params.t_end_test / params.step) + 1;

%% Experiment
params.t_start_stim = 0.2;
params.t_end_stim = 0.3;
params.training_impulse_duration = 0.1;
params.test_start_Ca = 1.4;
params.num_test = 4;
params.max_Iapp_training = 8;
params.min_Iapp_training = 4;
params.max_Iapp_test = 8.67;
params.min_Iapp_test = 3;
params.max_Iapp_noise = 6;
params.min_Iapp_noise = 2;

%% Applied pattern current
params.variance_test_gauss = 0.8;
params.variance_test_salt_pepper = 0.4;

%% Psnr
params.after_sample_t_test = 0.5;
params.after_sample_frames_test = fix(params.after_sample_t_test / params.step);

params.V_thr = 29;

%% Runge-Kutta steps
params.u2 = params.step / 2;
params.u6 = params.step / 6;

%% Network size
params.mneuro = 151;
params.nneuro = 151;
params.quantity_neurons = params.mneuro * params.nneuro;
params.mastro = 50;
params.nastro = 50;
az = 4; % Astrosyte zone size
params.az = az - 1;

%% Initial conditions
params.v_0 = -70;
params.ca_0 = 0.072495;
params.h_0 = 0.886314;
params.ip3_0 = 0.820204;

%% Neuron mode
params.aa = 0.1; %FS
params.b = 0.2;
params.c = -65;
params.d = 2;
params.alf = 10;
params.k = 600;
params.neuron_fired_thr = 30;

%% Synaptic connections
params.N_connections = 100; % maximum number of connections between neurons
params.quantity_connections = params.quantity_neurons * params.N_connections;

params.gsyn_max = 0.025;
params.gsyn_min = 0.001;
params.aep = 0.1; % astrocyte effect parameter
params.Esyn = 0;
params.ksyn = 0.2;
params.w = 0.9;

%% Astrosyte model
params.dCa = 0.05;
params.dIP3 = 0.05;
params.enter_astro = 3;
params.min_neurons_activity = 2;
params.threshold_Ca = 0.2;
shift_window_astro_watch = 0.001; % t(sec)
impact_astro = 0.3; % t(sec)
params.impact_astro = fix(impact_astro / params.step);
params.shift_window_astro_watch = fix(shift_window_astro_watch / params.step);

params_p = params;
end