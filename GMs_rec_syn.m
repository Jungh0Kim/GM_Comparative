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
CP = [241 40 21; 64	86 161]/255;

%% Load data

rng(4) 

addpath('utility')

load('./Data_sv/SelectedGM_2000.mat')
target_sel = GM_target;
rup_sel = rup;
GM_sel;

load('./Data_sv/GeneratedGM_2000.mat')
target_gen = GM_target;
rup_gen = rup;
GM_gen;

%% Figure 1: Response spectra

n_pp = 1e2;
GM_pp = randperm(2e3, n_pp);
grey = 0.62.*ones(1,3);

figure()
subplot(1,2,1)
p3 = plot(GM_sel.Tn, GM_sel.Sa(GM_pp(1),:),'-','Color',grey, 'linewidth', 0.75);  hold on
plot(GM_sel.Tn, GM_sel.Sa(GM_pp(2:end),:),'-','Color',grey, 'linewidth', 0.75);  hold on
p1 = plot(target_sel.Tn ,exp(target_sel.mu_logSa),'Color',CP(2,:), 'linewidth', 2.5);  hold on
plot(target_sel.Tn, exp(target_sel.mu_logSa + 1.96*target_sel.sigma_logSa),'--','Color',CP(2,:), 'linewidth', 2.5);
p2 = plot(target_sel.Tn, exp(target_sel.mu_logSa - 1.96*target_sel.sigma_logSa),'--','Color',CP(2,:), 'linewidth', 2.5);
set(gca,'YScale','log','XScale','log')
axis([0.1, 10, 1e-4, 3.85])
xlabel('$T$ (s)','fontsize',14.8)
ylabel('Sa($T$) (g)','fontsize',14.8)
lgnd = legend([p1,p2,p3],'Median','2.5 and 97.5 percentiles','Response spectra','Location','southwest');
set(lgnd,'FontSize',13.7,'NumColumns',1);
title('(a) Recorded','fontsize',15.3)

subplot(1,2,2)
plot(GM_gen.Tn, GM_gen.Sa(GM_pp(1),:)','-','Color',grey, 'linewidth', 0.75);  hold on
plot(GM_gen.Tn, GM_gen.Sa(GM_pp(2:end),:)','-','Color',grey, 'linewidth', 0.75);
plot(target_gen.Tn ,exp(target_gen.mu_logSa),'Color',CP(2,:), 'linewidth', 2.5);  hold on
plot(target_gen.Tn, exp(target_gen.mu_logSa + 1.96*target_gen.sigma_logSa),'--','Color',CP(2,:), 'linewidth', 2.5);
plot(target_gen.Tn, exp(target_gen.mu_logSa - 1.96*target_gen.sigma_logSa),'--','Color',CP(2,:), 'linewidth', 2.5);
set(gca,'YScale','log','XScale','log')
axis([0.1, 10, 1e-4, 3.85])
xlabel('$T$ (s)','fontsize',14.8)
ylabel('Sa($T$) (g)','fontsize',14.8)
title('(b) Synthetic','fontsize',15.3)
set(gcf,'unit','centimeters','position',[0 0 1.75*wid 0.9*hei]);
% tightfig;

%% Figure 2: Spectral median and variability

figure()
subplot(1,2,1)
p1 = plot(target_gen.Tn, exp(target_gen.mu_logSa),'Color',CP(2,:),'LineStyle','-','linewidth',2.5); hold on
p2 = plot(GM_sel.Tn, exp(GM_sel.mu_logSa),'LineStyle','--','Color',CP(1,:),'linewidth',1.9);  hold on
p3 = plot(GM_gen.Tn, exp(GM_gen.mu_logSa),'LineStyle','-.','Color','k','linewidth',1.9);  hold on
set(gca,'YScale','log','XScale','log')
lgnd = legend([p1,p2,p3],'Target','Recorded ground motions','Synthetic ground motions','Location','southwest');
set(lgnd,'FontSize',13.6,'NumColumns',1);
xlim([0.1,10])
xlabel('$T$ (s)','fontsize',14.8)
ylabel('Median $S_a$ (g)','fontsize',14.8)
title('(a)','fontsize',15)

subplot(1,2,2)
p1 = plot(target_gen.Tn, target_gen.sigma_logSa,'Color',CP(2,:),'LineStyle','-','linewidth',2.5);  hold on
p2 = plot(GM_sel.Tn, GM_sel.sigma_logSa,'LineStyle','--','Color',CP(1,:),'linewidth',1.9);  hold on
p3 = plot(GM_gen.Tn, GM_gen.std_logSa,'LineStyle','-.','Color','k','linewidth',1.9);  hold on
set(gca,'YScale','linear','XScale','log')
xlim([0.1,10])
ylim([0,1])
xlabel('$T$ (s)','fontsize',14.8)
ylabel('Standard deviation of ln$S_a$','fontsize',14.8)
title('(b)','fontsize',15)
set(gcf,'unit','centimeters','position',[0 0 1.75*wid 0.9*hei]);
% tightfig;

%% Figure 3: Spectral correlations

figure()
tiledlayout(1, 3, "TileSpacing", "tight", "Padding", "tight");
nexttile;
SaCorr = [];
for i=1:length(GM_sel.Tn)
    for j=1:length(GM_sel.Tn)
        Ti = GM_sel.Tn(i);
        Tj = GM_sel.Tn(j);
        SaCorr(i,j) = gmpe_bj_2008_corr(Ti, Tj);
    end
end
contour(GM_sel.Tn, GM_sel.Tn, SaCorr,'linewidth',1.55);
grid on
colorbar('YLim',[0 1]);
set(gca,'yscale','log','xscale','log');
set(gca,'xtick',[0.1 1 10],'ytick',[0.1 1 10]);
xlabel('$T_1$ (s)','fontsize',15.3)
ylabel('$T_2$ (s)','fontsize',15.3)
axis square;
title('(a) Target','fontsize',15.9)
axis([0.05,10,0.05,10])

nexttile;
SaCorr = corrcoef(log(GM_sel.Sa));
contour(GM_sel.Tn, GM_sel.Tn, SaCorr,'linewidth',1.55);
grid on
colorbar('YLim',[0 1]);
set(gca,'yscale','log','xscale','log');
set(gca,'xtick',[0.1 1 10],'ytick',[0.1 1 10]);
xlabel('$T_1$ (s)','fontsize',15.3)
ylabel('$T_2$ (s)','fontsize',15.3)
axis square;
axis([0.05,10,0.05,10])
title('(b) Recorded','fontsize',15.9)

nexttile;
SaCorr = corrcoef(log(GM_gen.Sa));
contour(GM_gen.Tn, GM_gen.Tn, SaCorr,'linewidth',1.55);
grid on
colorbar('YLim',[0 1]);
set(gca,'yscale','log','xscale','log');
set(gca,'xtick',[0.1 1 10],'ytick',[0.1 1 10]);
xlabel('$T_1$ (s)','fontsize',15.3)
ylabel('$T_2$ (s)','fontsize',15.3)
axis square;
axis([0.05,10,0.05,10])
title('$\rho(T_1,T_2)$ of generated motions')
title('(c) Synthetic','fontsize',15.9)
colormap(flipud(viridis))
set(gcf,'unit','centimeters','position',[0 0 2.2*wid 0.95*hei]);


toc;

