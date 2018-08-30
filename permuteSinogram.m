function out = permuteSinogram(sinogram)
% Assume columns correpond to angles
n_cols = size(sinogram,2);
perm = randsample(1:n_cols,n_cols);
out = sinogram(:,perm);

