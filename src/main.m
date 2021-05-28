try
    tic;
    %% Initialization
    close all; clearvars;
    rng(42);
    params = model_parameters(true);
    
    %% Training
    disp('Training');
    is_test = false;
    i = 0;
    model_training = ...
        init_model(is_test, i);
    [model.weight,model.Post, model.Pre] = ...
        make_weights(model_training.Image, model_training.Post, model_training.Pre);
    [model.Ca, model.Iapp_learn, model.V_learn] = ...
        simulate_model(model_training, model, params, is_test);
    clear model_learn
    
    %% Test
    is_test = true;
    for i = 1 : params.num_test
        fprintf('Test %0.4f\n',i);
        model_test = ...
            init_model(is_test,i);
        [model_test.Ca, model.Iapp_test(i,:,:), model.V_test(i,:,:)] = ...
            simulate_model(model_test, model, params, is_test);
    end
    clear model_test
    
    %% Compute PSNR
    [model] = ...
        make_pictures(model);
    clear model.weight model.Post model.Pre model.V_learn model.V_test
    
    [model.Psnr] = ...
        compute_psnr(model);
    
    disp('PSNR:');
    fprintf('training image with 80 Gaussian noise: %0.4f\n', model.Psnr(1,1));
    fprintf('training image with 40 "Salt and Pepper" noise: %0.4f\n', model.Psnr(2,1));
    fprintf('spatial uniform noise: %0.4f\n', model.Psnr(3,1));
    fprintf('another photo: %0.4f\n', model.Psnr(4,1));
    
    [model] = ...
        plot_pictures(model);
    toc;
    
catch ME
    if (strcmp(ME.identifier,'MATLAB:nomem'))
        error('Out of memory. Please, increase the amount of available memory. \nThe minimum required amount of RAM is 16 GB.', 0);
    else
        rethrow(ME);
    end
    
end