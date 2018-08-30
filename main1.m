%% Data
format long
close all;
addpath('../Datasets/Lotus Dataset')
addpath('../Datasets/CT_walnut_v1')
addpath('../Datasets')
predicted_sinograms_list = {};

for i = 1 : 1
%     a=load('FullSizeSinogramsCheese');
%     sinogram =a.sinogram360;
%     sinogram = sinogram(1:4:end,:);
%     mN = size(sinogram,2);
%     m=2;
%     N=mN/m;
%     epsilon_values = [0.1 0.3 0.5 1 2.7 3 3.5 4 5 10 15 20 22 25 50 ];
%     original_iradon = iradon(sinogram, linspace(0,360,mN));
%     figure, imshow(original_iradon,[])
%     figure, imshow(sinogram,[])
    
    
%     a=load('FullSizeSinogramsCheese');
%     sinogram =a.sinogram180FullView;
%     sinogram = sinogram(1:4:end, :);  
%     mN = size(sinogram,2);
%     m=1;
%     N=mN/m;
%     epsilon_values = [0.1 0.3 0.5 1 2.7 3 3.5 4 5 10 20];
%     original_iradon = iradon(sinogram, linspace(0,360,mN));
%     figure, imshow(original_iradon,[])
%     figure, imshow(sinogram,[])
%     
%     a=load('Data328');
%     sinogram = a.m;
%     mN = size(sinogram,2);
%     m=2;
%     N=mN/m;
%     epsilon_values = [0.01 0.05 0.1 0.3 0.6 1 3 5 10];
%     original_iradon = iradon(sinogram, linspace(0,360,mN));
%     figure, imshow(original_iradon,[])
%     figure, imshow(sinogram,[])
    
%     load('sinogram')
%     mN = size(sinogram,2);
%     m=2;
%     N=mN/m;
%     epsilon_values = [1 5 10 20 30 35 40 45 60 100 ];
%     original_iradon = iradon(sinogram(:,1:m:end),linspace(0,360,N));
%     figure,imshow(original_iradon,[])
    
    P = phantom('Modified Shepp-Logan',200);
    P(end:end+10,end:end+10) = 0;
    mN = 512;
    N=128;
    m=mN/N;
    sinogram = radon(P,360*rand(1,mN));
    epsilon_values = [100 200 300 500 1000 1250 1300 1450 1600 1800 2000 2300];
    epsilon = epsilon_values;
    
    % figure('units','normalized','outerposition',[0 0 1 1]), imshow(sinogram,[])
    ProjPermute = permuteSinogram(sinogram);
    % figure('units','normalized','outerposition',[0 0 1 1]), imshow(ProjLotus,[])
    format long
    for epsilon=epsilon_values;
        I = estimateAngles(ProjPermute,epsilon);
        predicted_sinogram = horzcat(ProjPermute,ProjPermute(end:-1:1,:));
        predicted_sinogram = predicted_sinogram(:,I);
        %     temp2  = horzcat(sinogram,sinogram(end:-1:1,:));
        %     mean2((predicted_sinogram-temp2).^2)/mean2((predicted_sinogram).^2);
        
        %     figure('units','normalized','outerposition',[0 0 1 1]),imshow(temp2,[])
        figure('units','normalized','outerposition',[0 0 1 1]),  subplot(1,1,1),imshow(predicted_sinogram(:,1:2*m:end),[])
        predicted_sinograms_list{i,end+1}=predicted_sinogram(:,1:2*m:end);
        out = iradon(predicted_sinogram(:,1:2*m:end),180.0*(1:N)/N);
        figure('units','normalized','outerposition',[0 0 1 1]), subplot(1,1,1),imshow(out,[])
        title(['epsilon = ' num2str(epsilon)])
    end
end