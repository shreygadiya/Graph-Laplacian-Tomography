function L_tilde = constructL(sinogram,epsilon)
N = size(sinogram,2);
W = zeros(N);
D=W;
for i=1:N
    for j=1:N
        W(i,j) = exp(-sum((sinogram(:,i)-sinogram(:,j)).^2)/(epsilon));
    end
end
for i=1:N
    for j=1:N
        D(i,i)=D(i,i)+W(i,j);
    end
end
W_tilde = (D^-1)*W*(D^-1);
D_tilde = zeros(N);
for i=1:N
    for j=1:N
        D_tilde(i,i)=D_tilde(i,i)+W_tilde(i,j);
    end
end
L_tilde = (D_tilde^-1)*W_tilde-eye(N);

