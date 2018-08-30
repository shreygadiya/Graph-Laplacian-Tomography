function L_tilde = constructnewL(sinogram,epsilon)
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

L_tilde = D-W;

