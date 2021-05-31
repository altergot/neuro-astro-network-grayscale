function [Iapp, t_Iapp_met] = make_Iapp_test(t_Iapp,i)
params = model_parameters();
images_dir = '../images';

if i == 1
    %% training image with 80% Gaussian noise
    image = imread(fullfile(images_dir, 'Julia.jpg'));
    image = 255 - shiftdim(image(:,:,1));
    image = double(image);
    image = image - min(image(:));
    image = image / max(image(:));
    disp = (params.variance_test_gauss * std(image(:)))^2;
    image = imnoise(image, 'gaussian', 0, disp);
    Iapp = image .* (params.max_Iapp_test - params.min_Iapp_test) ...
        + params.min_Iapp_test;
    
elseif i == 2
    %% training image with 40% "Salt and Pepper" noise
    image = imread(fullfile(images_dir, 'Julia.jpg'));
    image = 255 - shiftdim(image(:,:,1));
    image = double(image);
    image = image - min(image(:));
    image = image / max(image(:));
    image = imnoise(image,'salt & pepper',params.variance_test_salt_pepper);
    Iapp = image .* (params.max_Iapp_test - params.min_Iapp_test) + ...
        params.min_Iapp_test;
    
elseif i == 3
    %% spatial uniform noise
    image = rand(params.mneuro, params.nneuro);
    Iapp = image .* (params.max_Iapp_noise - params.min_Iapp_noise) + ...
        params.min_Iapp_noise;
    
elseif i == 4
    %% another photo
    image = imread(fullfile(images_dir, 'Mike.jpg'));
    image = 255 - shiftdim(image(:,:,1));
    image = double(image);
    Iapp = image ./ 255 .* (params.max_Iapp_test - params.min_Iapp_test) + ...
        params.min_Iapp_test;
end

t_Iapp_met = zeros(1, params.n_test);
t_Iapp_met(t_Iapp(1, 1) : t_Iapp(1, 2)) = 1;
end