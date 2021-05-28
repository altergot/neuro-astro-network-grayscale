function [psnr] = compute_psnr(model)
params = model_parameters();
psnr = zeros(params.num_test,1);
images_dir = '../images';
image = imread(fullfile(images_dir, 'julia.jpg'));
image = abs(255 - shiftdim(image(:,:,1)));
image = double(image);
image = shiftdim(image(1:params.mneuro, 1:params.nneuro));

for i = 1 : params.num_test
    freq = model.Freq(:,:,i+1);
    freq = freq - min(min(freq));
    freq = freq ./ max(max(freq)) .* 255;
    S = 0;
    for m = 1 : params.mneuro
        for n = 1 : params.nneuro
            sq = (freq(m,n) - image(m,n)) .^ 2;
            S = S + sq;
        end
    end
    mse = S / params.mneuro / params.nneuro;
    psnr(i,1) = 10 .* log10(255 .^ 2 ./ mse);
end
end