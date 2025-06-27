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
XTick_s2 = 2:2:2*n_story;
YTick_s2 = XTick_s2 - 1;
Plot_idx = 1:n_MC_data_sel;

%% Statistical Moments

IDR_gen_MM1_sv = zeros(M_iter, n_story);
IDR_gen_MM2_sv = zeros(M_iter, n_story);
IDR_gen_MM3_sv = zeros(M_iter, n_story);
IDR_gen_MM4_sv = zeros(M_iter, n_story);
IDR_sel_MM1_sv = zeros(M_iter, n_story);
IDR_sel_MM2_sv = zeros(M_iter, n_story);
IDR_sel_MM3_sv = zeros(M_iter, n_story);
IDR_sel_MM4_sv = zeros(M_iter, n_story);
PFA_gen_MM1_sv = zeros(M_iter, n_story);
PFA_gen_MM2_sv = zeros(M_iter, n_story);
PFA_gen_MM3_sv = zeros(M_iter, n_story);
PFA_gen_MM4_sv = zeros(M_iter, n_story);
PFA_sel_MM1_sv = zeros(M_iter, n_story);
PFA_sel_MM2_sv = zeros(M_iter, n_story);
PFA_sel_MM3_sv = zeros(M_iter, n_story);
PFA_sel_MM4_sv = zeros(M_iter, n_story);
IDR_comb_MM1_sv = zeros(M_iter, n_story);
IDR_comb_MM2_sv = zeros(M_iter, n_story);
IDR_comb_MM3_sv = zeros(M_iter, n_story);
IDR_comb_MM4_sv = zeros(M_iter, n_story);
PFA_comb_MM1_sv = zeros(M_iter, n_story);
PFA_comb_MM2_sv = zeros(M_iter, n_story);
PFA_comb_MM3_sv = zeros(M_iter, n_story);
PFA_comb_MM4_sv = zeros(M_iter, n_story);
CorrIDR_gen = zeros(n_story,n_story,M_iter);
CorrIDR_sel = zeros(n_story,n_story,M_iter);
CorrPFA_gen = zeros(n_story,n_story,M_iter);
CorrPFA_sel = zeros(n_story,n_story,M_iter);
CorrIDRPFA_gen = zeros(2*n_story,2*n_story,M_iter);
CorrIDRPFA_sel = zeros(2*n_story,2*n_story,M_iter);
for it = 1:M_iter
    y_gen_temp = Y_samp_sv_gen(Plot_idx, :, it);
    IDR_gen = y_gen_temp(:, 1:n_story);
    PFA_gen = y_gen_temp(:, n_story+1:2*n_story);

    y_sel_temp = Y_samp_sv_sel(Plot_idx, :, it);
    IDR_sel = y_sel_temp(:, 1:n_story);
    PFA_sel = y_sel_temp(:, n_story+1:2*n_story);

    %%%%% Statistical moments
    IDR_gen_MM1_sv(it, :) = mean(IDR_gen);
    IDR_gen_MM2_sv(it, :) = var(IDR_gen);
    IDR_gen_MM3_sv(it, :) = skewness(IDR_gen);
    IDR_gen_MM4_sv(it, :) = kurtosis(IDR_gen);

    IDR_sel_MM1_sv(it, :) = mean(IDR_sel);
    IDR_sel_MM2_sv(it, :) = var(IDR_sel);
    IDR_sel_MM3_sv(it, :) = skewness(IDR_sel);
    IDR_sel_MM4_sv(it, :) = kurtosis(IDR_sel);

    PFA_gen_MM1_sv(it, :) = mean(PFA_gen);
    PFA_gen_MM2_sv(it, :) = var(PFA_gen);
    PFA_gen_MM3_sv(it, :) = skewness(PFA_gen);    
    PFA_gen_MM4_sv(it, :) = kurtosis(PFA_gen);    

    PFA_sel_MM1_sv(it, :) = mean(PFA_sel);
    PFA_sel_MM2_sv(it, :) = var(PFA_sel);
    PFA_sel_MM3_sv(it, :) = skewness(PFA_sel);
    PFA_sel_MM4_sv(it, :) = kurtosis(PFA_sel);  

    IDR_comb_MM1_sv(it, :) = mean([IDR_gen; IDR_sel]);
    IDR_comb_MM2_sv(it, :) = var([IDR_gen; IDR_sel]);
    IDR_comb_MM3_sv(it, :) = skewness([IDR_gen; IDR_sel]);
    IDR_comb_MM4_sv(it, :) = kurtosis([IDR_gen; IDR_sel]);

    PFA_comb_MM1_sv(it, :) = mean([PFA_gen; PFA_sel]);
    PFA_comb_MM2_sv(it, :) = var([PFA_gen; PFA_sel]);
    PFA_comb_MM3_sv(it, :) = skewness([PFA_gen; PFA_sel]);
    PFA_comb_MM4_sv(it, :) = kurtosis([PFA_gen; PFA_sel]);  

    %%%%% Correlations
    CorrIDR_gen(:,:,it) = corr(IDR_gen);
    CorrIDR_sel(:,:,it) = corr(IDR_sel);

    CorrPFA_gen(:,:,it) = corr(PFA_gen);
    CorrPFA_sel(:,:,it) = corr(PFA_sel);

    CorrIDRPFA_gen(:,:,it) = corr([IDR_gen PFA_gen]);
    CorrIDRPFA_sel(:,:,it) = corr([IDR_sel PFA_sel]);
end

%% Plot moments

p_MM = 1;

% Errors 
IDR_MM1_error_sv = abs( (IDR_gen_MM1_sv(p_MM, :) - IDR_sel_MM1_sv(p_MM, :))./IDR_gen_MM1_sv(p_MM, :) );
IDR_MM2_error_sv = abs( (IDR_gen_MM2_sv(p_MM, :) - IDR_sel_MM2_sv(p_MM, :))./IDR_gen_MM2_sv(p_MM, :) );
IDR_MM3_error_sv = abs( (IDR_gen_MM3_sv(p_MM, :) - IDR_sel_MM3_sv(p_MM, :))./IDR_gen_MM3_sv(p_MM, :) );
IDR_MM4_error_sv = abs( (IDR_gen_MM4_sv(p_MM, :) - IDR_sel_MM4_sv(p_MM, :))./IDR_gen_MM4_sv(p_MM, :) );

PFA_MM1_error_sv = abs( (PFA_gen_MM1_sv(p_MM, :) - PFA_sel_MM1_sv(p_MM, :))./PFA_gen_MM1_sv(p_MM, :) );
PFA_MM2_error_sv = abs( (PFA_gen_MM2_sv(p_MM, :) - PFA_sel_MM2_sv(p_MM, :))./PFA_gen_MM2_sv(p_MM, :) );
PFA_MM3_error_sv = abs( (PFA_gen_MM3_sv(p_MM, :) - PFA_sel_MM3_sv(p_MM, :))./PFA_gen_MM3_sv(p_MM, :) );
PFA_MM4_error_sv = abs( (PFA_gen_MM4_sv(p_MM, :) - PFA_sel_MM4_sv(p_MM, :))./PFA_gen_MM4_sv(p_MM, :) );

figure()
subplot(1,2,1)
aa = plot(IDR_MM1_error_sv.*100, 1:n_story ,'linewidth',1.45,'linestyle','-','Color','k'); hold on
scatter(IDR_MM1_error_sv.*100, 1:n_story ,30,'+','linewidth',1.0,'Markeredgecolor','k'); hold on
bb = plot(IDR_MM2_error_sv.*100, 1:n_story ,'linewidth',1.55,'linestyle','--','Color','k'); 
scatter(IDR_MM2_error_sv.*100, 1:n_story ,30,'x','linewidth',1.0,'Markeredgecolor','k'); hold on
cc = plot(IDR_MM3_error_sv.*100, 1:n_story ,'linewidth',1.55,'linestyle','-.','Color','k'); 
scatter(IDR_MM3_error_sv.*100, 1:n_story ,30,'o','linewidth',1.0,'Markeredgecolor','k'); hold on
dd = plot(IDR_MM4_error_sv.*100, 1:n_story ,'linewidth',1.55,'linestyle',':','Color','k'); 
scatter(IDR_MM4_error_sv.*100, 1:n_story ,30,'<','linewidth',1.0,'Markeredgecolor','k'); hold on
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
ax1.XLim = [0 100];
ax1.XTick = [0 25 50 75 100];
xlabel('$DF_{M_k}$ ($\%$)','fontsize',14.8);
ylabel('Story','fontsize',14.8);
title('IDR','fontsize',14.8)
lgnd = legend([aa,bb,cc,dd], 'Mean','Variance','Skewness','Kurtosis');
set(lgnd,'FontSize',13.0,'location','northeast');
legend boxoff;
hold off;

subplot(1,2,2)
aa = plot(PFA_MM1_error_sv.*100, 1:n_story ,'linewidth',1.45,'linestyle','-','Color','k'); hold on
scatter(PFA_MM1_error_sv.*100, 1:n_story ,30,'+','linewidth',1.0,'Markeredgecolor','k'); hold on
bb = plot(PFA_MM2_error_sv.*100, 1:n_story ,'linewidth',1.55,'linestyle','--','Color','k'); 
scatter(PFA_MM2_error_sv.*100, 1:n_story ,30,'x','linewidth',1.0,'Markeredgecolor','k'); hold on
cc = plot(PFA_MM3_error_sv.*100, 1:n_story ,'linewidth',1.55,'linestyle','-.','Color','k'); 
scatter(PFA_MM3_error_sv.*100, 1:n_story ,30,'o','linewidth',1.0,'Markeredgecolor','k'); hold on
dd = plot(PFA_MM4_error_sv.*100, 1:n_story ,'linewidth',1.55,'linestyle',':','Color','k'); 
scatter(PFA_MM4_error_sv.*100, 1:n_story ,30,'<','linewidth',1.0,'Markeredgecolor','k'); hold on
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
ax1.XLim = [0 100];
ax1.XTick = [0 25 50 75 100];
xlabel('$DF_{M_k}$ ($\%$)','fontsize',14.8);
title('PFA','fontsize',14.8)
hold off;
set(gcf,'unit','centimeters','position',[0 0 0.80*wid 1.65*hei]);
% tightfig;

%% Plot correlations

p_CC = 1;

YTick_str2X = {'IDR$_2$','IDR$_4$','IDR$_6$','IDR$_8$','IDR$_{10}$','IDR$_{12}$',...
    'PFA$_2$','PFA$_4$','PFA$_6$','PFA$_8$','PFA$_{10}$','PFA$_{12}$'};

YTick_str2Y = cell(1, length(YTick_str2X));
for kkk = 1:length(YTick_str2X)
    YTick_str2Y{1,kkk} = YTick_str2X{1,length(YTick_str2X) + 1 - kkk};
end

CorrIDR_gen = flip(CorrIDR_gen(:,:,p_CC));
CorrIDR_sel = flip(CorrIDR_sel(:,:,p_CC));
CorrPFA_gen = flip(CorrPFA_gen(:,:,p_CC));
CorrPFA_sel = flip(CorrPFA_sel(:,:,p_CC));
CorrIDRPFA_gen = flip(CorrIDRPFA_gen(:,:,p_CC));
CorrIDRPFA_sel = flip(CorrIDRPFA_sel(:,:,p_CC));

Corr_error_IDR = abs(CorrIDR_gen - CorrIDR_sel)./CorrIDR_gen.*100;
Corr_error_PFA = abs(CorrPFA_gen - CorrPFA_sel)./CorrPFA_gen.*100;
Corr_error_IDRPFA = abs(CorrIDRPFA_gen - CorrIDRPFA_sel)./CorrIDRPFA_gen.*100;

figure()
subplot(1,2,1)
imagesc(CorrIDRPFA_sel); 
ax_colorbar = colorbar;
ax_colorbar.FontSize = 12;
ax_colorbar.Limits = [0.30 1];
ax1 = gca;
ax1.XTick = XTick_s2;
ax1.YTick = YTick_s2;
ax1.XTickLabel = YTick_str2X;
ax1.YTickLabel = YTick_str2Y;
ax1.FontSize = 11;
ax1.XTickLabelRotation = 65;
ax1.YTickLabelRotation = 0;
colormap(flipud(viridis));
title('Recorded','fontsize',18)

subplot(1,2,2)
imagesc(CorrIDRPFA_gen); 
ax_colorbar = colorbar;
ax_colorbar.FontSize = 12;
ax_colorbar.Limits = [0.30 1];
ax1 = gca;
ax1.XTick = XTick_s2;
ax1.YTick = YTick_s2;
ax1.XTickLabel = YTick_str2X;
ax1.YTickLabel = YTick_str2Y;
ax1.FontSize = 11;
ax1.XTickLabelRotation = 65;
ax1.YTickLabelRotation = 0;
colormap(flipud(viridis));
title('Synthetic','fontsize',18)
set(gcf,'unit','centimeters','position',[0 0 2.0*wid 1.0*hei]);

figure()
imagesc(Corr_error_IDRPFA); 
ax_colorbar = colorbar;
ax_colorbar.FontSize = 12;
ax1 = gca;
ax1.XTick = XTick_s2;
ax1.YTick = YTick_s2;
ax1.XTickLabel = YTick_str2X;
ax1.YTickLabel = YTick_str2Y;
ax1.FontSize = 10.9;
ax1.XTickLabelRotation = 65;
ax1.YTickLabelRotation = 0;
colormap(flipud(bone));
title('$DF_{\rho}$ ($\%$)','fontsize',18)
set(gcf,'unit','centimeters','position',[0 0 0.85*wid 1.0*hei]);



toc;




