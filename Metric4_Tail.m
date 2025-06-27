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

n_story = 12;
YTick_s = 1:n_story;
k_Hills1 = 50;        % 2.5 percent
k_Hills2 = 100;       % 5.0 percent
k_Hills3 = 150;       % 7.5 percent
Plot_idx = 1:n_MC_data_sel;

%% Tail index

IDR_Hill1_gen = zeros(M_iter, n_story);
IDR_Hill1_sel = zeros(M_iter, n_story);
PFA_Hill1_gen = zeros(M_iter, n_story);
PFA_Hill1_sel = zeros(M_iter, n_story);
IDR_Hill2_gen = zeros(M_iter, n_story);
IDR_Hill2_sel = zeros(M_iter, n_story);
PFA_Hill2_gen = zeros(M_iter, n_story);
PFA_Hill2_sel = zeros(M_iter, n_story);
IDR_Hill3_gen = zeros(M_iter, n_story);
IDR_Hill3_sel = zeros(M_iter, n_story);
PFA_Hill3_gen = zeros(M_iter, n_story);
PFA_Hill3_sel = zeros(M_iter, n_story);
for it = 1:M_iter
    y_gen_temp = Y_samp_sv_gen(Plot_idx, :, it);
    IDR_gen = y_gen_temp(:, 1:n_story);
    PFA_gen = y_gen_temp(:, n_story+1:2*n_story);

    y_sel_temp = Y_samp_sv_sel(Plot_idx, :, it);
    IDR_sel = y_sel_temp(:, 1:n_story);
    PFA_sel = y_sel_temp(:, n_story+1:2*n_story);

    %%%%% Tail index (Hill’s Estimator)
    for ot=1:n_story
        IDR_gen_sort_des = sort(IDR_gen(:,ot), 'descend');
        IDR_sel_sort_des = sort(IDR_sel(:,ot), 'descend');
        PFA_gen_sort_des = sort(PFA_gen(:,ot), 'descend');
        PFA_sel_sort_des = sort(PFA_sel(:,ot), 'descend');

        IDR_gen_sort_topk = IDR_gen_sort_des(1:k_Hills1+1);  % Top k largest values       
        IDR_Hill1_gen(it, ot) = 1/( sum(log(IDR_gen_sort_topk(1:end-1)) - log(IDR_gen_sort_topk(end)))/k_Hills1 );
        IDR_sel_sort_topk = IDR_sel_sort_des(1:k_Hills1+1);
        IDR_Hill1_sel(it, ot) = 1/( sum( log(IDR_sel_sort_topk(1:end-1)) - log(IDR_sel_sort_topk(end)) )/k_Hills1 );
        PFA_gen_sort_topk = PFA_gen_sort_des(1:k_Hills1+1);  
        PFA_Hill1_gen(it, ot) = 1/( sum( log(PFA_gen_sort_topk(1:end-1)) - log(PFA_gen_sort_topk(end)) )/k_Hills1 );
        PFA_sel_sort_topk = PFA_sel_sort_des(1:k_Hills1+1);
        PFA_Hill1_sel(it, ot) = 1/( sum( log(PFA_sel_sort_topk(1:end-1)) - log(PFA_sel_sort_topk(end)) )/k_Hills1 );

        IDR_gen_sort_topk = IDR_gen_sort_des(1:k_Hills2+1);  % Top k largest values       
        IDR_Hill2_gen(it, ot) = 1/( sum(log(IDR_gen_sort_topk(1:end-1)) - log(IDR_gen_sort_topk(end)))/k_Hills2 );
        IDR_sel_sort_topk = IDR_sel_sort_des(1:k_Hills2+1);
        IDR_Hill2_sel(it, ot) = 1/( sum( log(IDR_sel_sort_topk(1:end-1)) - log(IDR_sel_sort_topk(end)) )/k_Hills2 );
        PFA_gen_sort_topk = PFA_gen_sort_des(1:k_Hills2+1);  
        PFA_Hill2_gen(it, ot) = 1/( sum( log(PFA_gen_sort_topk(1:end-1)) - log(PFA_gen_sort_topk(end)) )/k_Hills2 );
        PFA_sel_sort_topk = PFA_sel_sort_des(1:k_Hills2+1);
        PFA_Hill2_sel(it, ot) = 1/( sum( log(PFA_sel_sort_topk(1:end-1)) - log(PFA_sel_sort_topk(end)) )/k_Hills2 );

        IDR_gen_sort_topk = IDR_gen_sort_des(1:k_Hills3+1);  % Top k largest values       
        IDR_Hill3_gen(it, ot) = 1/( sum(log(IDR_gen_sort_topk(1:end-1)) - log(IDR_gen_sort_topk(end)))/k_Hills3 );
        IDR_sel_sort_topk = IDR_sel_sort_des(1:k_Hills3+1);
        IDR_Hill3_sel(it, ot) = 1/( sum( log(IDR_sel_sort_topk(1:end-1)) - log(IDR_sel_sort_topk(end)) )/k_Hills3 );
        PFA_gen_sort_topk = PFA_gen_sort_des(1:k_Hills3+1);  
        PFA_Hill3_gen(it, ot) = 1/( sum( log(PFA_gen_sort_topk(1:end-1)) - log(PFA_gen_sort_topk(end)) )/k_Hills3 );
        PFA_sel_sort_topk = PFA_sel_sort_des(1:k_Hills3+1);
        PFA_Hill3_sel(it, ot) = 1/( sum( log(PFA_sel_sort_topk(1:end-1)) - log(PFA_sel_sort_topk(end)) )/k_Hills3 );
    end
end

%% Plot

p_Tl = 1;
Error_IDR_Hill1 = abs((IDR_Hill1_gen(p_Tl, :) - IDR_Hill1_sel(p_Tl, :))./IDR_Hill1_gen(p_Tl, :)).*100;
Error_PFA_Hill1 = abs((PFA_Hill1_gen(p_Tl, :) - PFA_Hill1_sel(p_Tl, :))./PFA_Hill1_gen(p_Tl, :)).*100;
Error_IDR_Hill2 = abs((IDR_Hill2_gen(p_Tl, :) - IDR_Hill2_sel(p_Tl, :))./IDR_Hill2_gen(p_Tl, :)).*100;
Error_PFA_Hill2 = abs((PFA_Hill2_gen(p_Tl, :) - PFA_Hill2_sel(p_Tl, :))./PFA_Hill2_gen(p_Tl, :)).*100;
Error_IDR_Hill3 = abs((IDR_Hill3_gen(p_Tl, :) - IDR_Hill3_sel(p_Tl, :))./IDR_Hill3_gen(p_Tl, :)).*100;
Error_PFA_Hill3 = abs((PFA_Hill3_gen(p_Tl, :) - PFA_Hill3_sel(p_Tl, :))./PFA_Hill3_gen(p_Tl, :)).*100;

figure()
subplot(1,2,1)
plot(Error_IDR_Hill1, 1:n_story ,'linewidth',1.55,'linestyle','--','Color','k'); hold on
scatter(Error_IDR_Hill1, 1:n_story ,30,'+','linewidth',1.1,'Markeredgecolor','k'); hold on
plot(Error_IDR_Hill2, 1:n_story ,'linewidth',1.55,'linestyle','-.','Color','k'); hold on
scatter(Error_IDR_Hill2, 1:n_story ,30,'x','linewidth',1.1,'Markeredgecolor','k'); hold on
plot(Error_IDR_Hill3, 1:n_story ,'linewidth',1.55,'linestyle',':','Color','k'); hold on
scatter(Error_IDR_Hill3, 1:n_story ,28,'*','linewidth',1.1,'Markeredgecolor','k'); hold on
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
xlabel('$DF_{T_k}$ ($\%$)','fontsize',14.8);
ylabel('Story','fontsize',14.8);
title('IDR','fontsize',14.8);
hold off;

subplot(1,2,2)
aa = plot(Error_PFA_Hill1, 1:n_story ,'linewidth',1.55,'linestyle','--','Color','k'); hold on
scatter(Error_PFA_Hill1, 1:n_story ,30,'+','linewidth',1.1,'Markeredgecolor','k'); hold on
bb = plot(Error_PFA_Hill2, 1:n_story ,'linewidth',1.55,'linestyle','-.','Color','k'); hold on
scatter(Error_PFA_Hill2, 1:n_story ,30,'x','linewidth',1.1,'Markeredgecolor','k'); hold on
cc = plot(Error_PFA_Hill3, 1:n_story ,'linewidth',1.55,'linestyle',':','Color','k'); hold on
scatter(Error_PFA_Hill3, 1:n_story ,28,'*','linewidth',1.1,'Markeredgecolor','k'); hold on
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
xlabel('$DF_{T_k}$ ($\%$)','fontsize',14.8);
title('PFA','fontsize',14.8);
lgnd = legend([cc,bb,aa], ' 7.5\%',' 5.0\%',' 2.5\%');
set(lgnd,'FontSize',13.7,'location','northeast');
legend boxoff;
hold off;
set(gcf,'unit','centimeters','position',[0 0 0.80*wid 1.65*hei]);
% tightfig;


toc;

