function [Iapp, t_Iapp_met, image] = make_Iapp_training(t_Iapp)
params = model_parameters();

images_dir = '../images';
image = imread(fullfile(images_dir, 'Julia.jpg'));
image = abs(255 - shiftdim(image(:,:,1)));
image = double(image);
image = shiftdim(image(1 : params.mneuro, 1 : params.nneuro));
Iapp = image ./ 255 .* (params.max_Iapp_training - params.min_Iapp_training)...
    + params.min_Iapp_training;

t_Iapp_met = zeros(1, params.n_training);
t_Iapp_met(t_Iapp(1, 1) : t_Iapp(1, 2)) = 1;
end