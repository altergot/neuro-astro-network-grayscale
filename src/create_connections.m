function [post_line,pre] = create_connections()
params = model_parameters();

post_line = randi([1,params.quantity_neurons],1,params.quantity_connections);
k = 1;
for i = 1 : params.N_connections : params.quantity_connections
    pre(i : i + params.N_connections - 1) = k;
    k = k + 1;
end
end
