function out = estimateAngles(sinogram,epsilon)
sinogram = horzcat(sinogram,sinogram(end:-1:1,1:end));

% figure, imshow(sinogram,[])
L_tilde = constructL(sinogram,epsilon);
% L_tilde = constructL(sinogram,epsilon);
[V,D]=eig(L_tilde);
eigvals = diag(D);
% [~,I] = sort(eigvals);
% B(1:3)
eigvecs = V;
% eigvecs(:,2)
% sum(eigvecs(:,3).^2)


phi = atan(eigvecs(:,2)./eigvecs(:,3));
%phi = acos(eigvecs(:,2));
% sum(phi==NaN)
[~,I]=sort(phi);
% figure, imshow(sinogram(:,I),[])
out = I;