%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jungho Kim, UC Berkeley
% junghokim@berkeley.edu
%
% This code is part of the following preprint:
% Kim, J., Su, M., Wang, Z., & Broccardo, M. (2025).
% Recorded Versus Synthetic Ground Motions: A Comparative Analysis of Structural Seismic Responses.
% arXiv preprint arXiv:2502.19549.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all; tic;
set(0,'DefaultFigureColor',[1 1 1]);
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(0,'defaulttextinterpreter','latex','DefaultAxesFontSize',14);
hei = 10;  wid = hei*1.618;

%% load data

load('./Data_sv/241029_MDOF12_MCS_gen_E0_V1.mat')
n_MC_data_gen = n_MC_data;
Y_samp_sv_gen = Y_samp_sv;

load('./Data_sv/241029_MDOF12_MCS_sel_E0_V1.mat')
n_MC_data_sel = n_MC_data;
Y_samp_sv_sel = Y_samp_sv;

CP = [CP; 0.85, 0.33, 0.1];
n_story = 12;
YTick_s = 1:n_story;
Plot_idx = 1:n_MC_data_sel;

%% PDF and CCDF

k_CI = 1.96;

% Story number for plot
p_pdf = 2;

y_gen_temp = Y_samp_sv_gen(Plot_idx, :);
IDR_gen = y_gen_temp(:, 1:n_story);
PFA_gen = y_gen_temp(:, n_story+1:2*n_story);
y_sel_temp = Y_samp_sv_sel(Plot_idx, :);
IDR_sel = y_sel_temp(:, 1:n_story);
PFA_sel = y_sel_temp(:, n_story+1:2*n_story);

pdf_numb = 5e2;
[IDR_gen_PDF, IDR_gen_plot] = ksdensity(IDR_gen(:,p_pdf),'NumPoints', pdf_numb);
[IDR_sel_PDF, IDR_sel_plot] = ksdensity(IDR_sel(:,p_pdf),'NumPoints', pdf_numb);
[PFA_gen_PDF, PFA_gen_plot] = ksdensity(PFA_gen(:,p_pdf),'NumPoints', pdf_numb);
[PFA_sel_PDF, PFA_sel_plot] = ksdensity(PFA_sel(:,p_pdf),'NumPoints', pdf_numb);

CDF_IDR_gen = 1-(0:length(IDR_gen(:,p_pdf))-1)/length(IDR_gen(:,p_pdf));
CDF_IDR_sel = 1-(0:length(IDR_sel(:,p_pdf))-1)/length(IDR_sel(:,p_pdf));
CDF_IDR_gen_std = sqrt((1-CDF_IDR_gen).*CDF_IDR_gen./length(IDR_gen(:,p_pdf)));
CDF_IDR_sel_std = sqrt((1-CDF_IDR_sel).*CDF_IDR_sel./length(IDR_sel(:,p_pdf)));

CDF_IDR_gen_CI = [CDF_IDR_gen' + k_CI.*CDF_IDR_gen_std'; flip(CDF_IDR_gen' - k_CI.*CDF_IDR_gen_std',1)];
CDF_IDR_gen_CI = abs(CDF_IDR_gen_CI);
CDF_IDR_sel_CI = [CDF_IDR_sel' + k_CI.*CDF_IDR_sel_std'; flip(CDF_IDR_sel' - k_CI.*CDF_IDR_sel_std',1)];
CDF_IDR_sel_CI = abs(CDF_IDR_sel_CI);

CDF_PFA_gen = 1-(0:length(PFA_gen(:,p_pdf))-1)/length(PFA_gen(:,p_pdf));
CDF_PFA_sel = 1-(0:length(PFA_sel(:,p_pdf))-1)/length(PFA_sel(:,p_pdf));
CDF_PFA_gen_std = sqrt((1-CDF_PFA_gen).*CDF_PFA_gen./length(PFA_gen(:,p_pdf)));
CDF_PFA_sel_std = sqrt((1-CDF_PFA_sel).*CDF_PFA_sel./length(PFA_sel(:,p_pdf)));

CDF_PFA_gen_CI = [CDF_PFA_gen' + k_CI.*CDF_PFA_gen_std'; flip(CDF_PFA_gen' - k_CI.*CDF_PFA_gen_std',1)];
CDF_PFA_gen_CI = abs(CDF_PFA_gen_CI);
CDF_PFA_sel_CI = [CDF_PFA_sel' + k_CI.*CDF_PFA_sel_std'; flip(CDF_PFA_sel' - k_CI.*CDF_PFA_sel_std',1)];
CDF_PFA_sel_CI = abs(CDF_PFA_sel_CI);

figure()
subplot(2,2,1)
bb = plot(IDR_gen_plot, IDR_gen_PDF,'LineWidth',1.75,'Linestyle','-','Color',CP(15,:)); hold on
aa = plot(IDR_sel_plot, IDR_sel_PDF,'LineWidth',1.75,'Linestyle','--','Color',CP(2,:));
lgnd = legend([aa,bb],' Recorded',' Synthetic','Location','Best');
set(lgnd,'FontSize',14.7,'location','northeast');
legend boxoff;
xlabel(strcat('IDR$_{',num2str(p_pdf),'}$'),'fontsize',15.3);
ylabel('PDF','fontsize',14.8);
hold off;

subplot(2,2,2)
fill([sort(IDR_gen(:,p_pdf)); flip(sort(IDR_gen(:,p_pdf)),1)], CDF_IDR_gen_CI,...
    CP(15,:), 'FaceAlpha', 0.13, 'EdgeColor', 'none');  hold on
fill([sort(IDR_sel(:,p_pdf)); flip(sort(IDR_sel(:,p_pdf)),1)], CDF_IDR_sel_CI,...
    CP(2,:), 'FaceAlpha', 0.13, 'EdgeColor', 'none');  hold on
plot(sort(IDR_gen(:,p_pdf)), CDF_IDR_gen,'LineWidth',1.75,'Linestyle','-','Color',CP(15,:)); hold on;
plot(sort(IDR_sel(:,p_pdf)), CDF_IDR_sel,'LineWidth',1.75,'Linestyle','--','Color',CP(2,:));
ax1 = gca;
ax1.YMinorGrid = 'on';
ax1.MinorGridLineStyle = '-';
ax1.MinorGridAlpha = 0.1;
ax1.MinorGridColor = [0.5 0.5 0.5];
ax1.YAxis.Scale ="log";
xlabel(strcat('IDR$_{',num2str(p_pdf),'}$'),'fontsize',15.3);
ylabel('CCDF','fontsize',14.8);
xlim([0 0.03])
ylim([1e-3 1])
hold off;

subplot(2,2,3)
bb = plot(PFA_gen_plot, PFA_gen_PDF,'LineWidth',1.75,'Linestyle','-','Color',CP(15,:)); hold on
aa = plot(PFA_sel_plot, PFA_sel_PDF,'LineWidth',1.75,'Linestyle','--','Color',CP(2,:));
xlabel(strcat('PFA$_{',num2str(p_pdf),'}$ (g)'),'fontsize',15.3);
ylabel('PDF','fontsize',14.8);
hold off;

subplot(2,2,4)
fill([sort(PFA_gen(:,p_pdf)); flip(sort(PFA_gen(:,p_pdf)),1)], CDF_PFA_gen_CI,...
    CP(15,:), 'FaceAlpha', 0.13, 'EdgeColor', 'none');  hold on
fill([sort(PFA_sel(:,p_pdf)); flip(sort(PFA_sel(:,p_pdf)),1)], CDF_PFA_sel_CI,...
    CP(2,:), 'FaceAlpha', 0.13, 'EdgeColor', 'none');  hold on
plot(sort(PFA_gen(:,p_pdf)), CDF_PFA_gen,'LineWidth',1.75,'Linestyle','-','Color',CP(15,:)); hold on;
plot(sort(PFA_sel(:,p_pdf)), CDF_PFA_sel,'LineWidth',1.75,'Linestyle','--','Color',CP(2,:));
ax1 = gca;
ax1.YMinorGrid = 'on';
ax1.MinorGridLineStyle = '-';
ax1.MinorGridAlpha = 0.1;
ax1.MinorGridColor = [0.5 0.5 0.5];
ax1.YAxis.Scale ="log";
xlabel(strcat('PFA$_{',num2str(p_pdf),'}$ (g)'),'fontsize',15.3);
ylabel('CCDF','fontsize',14.8);
xlim([0 3])
ylim([1e-3 1])
hold off;
set(gcf,'unit','centimeters','position',[0 0 1.45*wid 1.75*hei]);
% tightfig;


%% DF_Q

y_gen_temp = Y_samp_sv_gen(Plot_idx, :);
IDR_gen = y_gen_temp(:, 1:n_story);
PFA_gen = y_gen_temp(:, n_story+1:2*n_story);
y_sel_temp = Y_samp_sv_sel(Plot_idx, :);
IDR_sel = y_sel_temp(:, 1:n_story);
PFA_sel = y_sel_temp(:, n_story+1:2*n_story);

% Calculate errors
nRMSD_IDR_sv = zeros(n_story,1);
nMAD_IDR_sv = zeros(n_story,1);
nRMSD_PFA_sv = zeros(n_story,1);
nMAD_PFA_sv = zeros(n_story,1);
for ik = 1:n_story
    IDR_gen_sorted = sort(IDR_gen(:,ik));
    IDR_sel_sorted = sort(IDR_sel(:,ik));
    PFA_gen_sorted = sort(PFA_gen(:,ik));
    PFA_sel_sorted = sort(PFA_sel(:,ik));

    nRMSD_IDR = sqrt(1/length(IDR_gen_sorted)*sum( (IDR_gen_sorted - IDR_sel_sorted).^2 )) / mean([IDR_gen_sorted]);
    nMAD_IDR = 1/length(IDR_gen_sorted)*sum(abs(IDR_gen_sorted - IDR_sel_sorted)) / mean([IDR_gen_sorted]);
    nRMSD_PFA = sqrt(1/length(PFA_gen_sorted)*sum( (PFA_gen_sorted - PFA_sel_sorted).^2 )) / mean([PFA_gen_sorted]);
    nMAD_PFA = 1/length(PFA_gen_sorted)*sum(abs(PFA_gen_sorted - PFA_sel_sorted)) / mean([PFA_gen_sorted]);

    nRMSD_IDR_sv(ik,1) = nRMSD_IDR;
    nMAD_IDR_sv(ik,1) = nMAD_IDR;
    nRMSD_PFA_sv(ik,1) = nRMSD_PFA;
    nMAD_PFA_sv(ik,1) = nMAD_PFA;
end

figure()
subplot(1,2,1)
plot(nMAD_IDR_sv.*100, 1:n_story ,'linewidth',1.95,'linestyle','--','Marker','+','Color','k'); hold on
ax1 = gca;    
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.XMinorGrid = 'off';
ax1.FontSize = 13.2;
ax1.XTickLabelRotation = 0;
ax1.XMinorTick = 'off';
ax1.YTick = YTick_s;
ax1.YLim(1) = 0.6; 
ax1.YLim(2) = n_story + 0.4; 
ax1.XLim = [0 50];
ax1.XTick = [0 10 20 30 40 50];
xlabel('$DF_Q$ ($\%$)','fontsize',14.8);
ylabel('Story','fontsize',14.8);
title('IDR','fontsize',14.8)
hold off;

subplot(1,2,2)
plot(nMAD_PFA_sv.*100, 1:n_story ,'linewidth',1.95,'linestyle','--','Marker','+','Color','k'); hold on
ax1 = gca;    
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.XMinorGrid = 'off';
ax1.FontSize = 14.0;
ax1.XTickLabelRotation = 0;
ax1.XMinorTick = 'off';
ax1.YTick = YTick_s;
ax1.YLim(1) = 0.6; 
ax1.YLim(2) = n_story + 0.4; 
ax1.XLim = [0 50];
ax1.XTick = [0 10 20 30 40 50];
xlabel('$DF_Q$ ($\%$)','fontsize',14.8);
title('PFA','fontsize',14.8)
hold off;
set(gcf,'unit','centimeters','position',[0 0 0.80*wid 1.65*hei]);
% tightfig;


toc;




