function [weight,Post, Pre] = make_weights(Image, Post, Pre)
params = model_parameters();
image = Image(:);
weight = zeros(params.quantity_connections,1);
for i = 1 : params.quantity_connections
    weight(i,1) = (params.w ^ abs(image(Post(1,i)) -image(Pre(1,i)))) * (params.gsyn_max - params.gsyn_min)+ params.gsyn_min;
end
end