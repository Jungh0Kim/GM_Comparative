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

%% Load data

load('./Data_sv/241029_MDOF12_qMCS_GSA.mat','Si_E_gen_mu_sv','Si_E_sel_mu_sv','Si_GM_gen_mu_sv','Si_GM_sel_mu_sv')

n_story = 12;
YTick_s = 1:n_story;

%% Plot

CP1 = [0.2510, 0.3373, 0.6314; 0.3010, 0.3873, 0.6814; 0.2010, 0.2873, 0.5814; 0.2510, 0.3373, 0.5314];
CP2 = [0.8500, 0.3300, 0.1000; 0.9000, 0.3800, 0.1500; 0.8000, 0.2800, 0.0500; 0.8500, 0.3300, 0.1500];
lineset = {'-','-.','--',':'};

figure()
subplot(1,4,1)
for kk=1:4
    plot(Si_E_sel_mu_sv(kk,1:n_story), 1:n_story,'linewidth', 1.9,'Color',CP1(kk,:),'linestyle',lineset{1,kk}); hold on
end
lgnd = legend('Case 1','Case 2','Case 3','Case 4','Location','southeast');
set(lgnd,'FontSize',12.2,'location','southeast');  legend boxoff;
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 13.7;
xlabel('Sensitivity, $S_{\bf{S}}$','fontsize',14.5);
ylabel('Story','fontsize',14.5);
title('Recorded motions','fontsize',14.5)
ax1.XTick = [0 0.25 0.5 0.75 1];
axis([0 1 1 n_story])
ax1.XTickLabelRotation = 0;

subplot(1,4,2)
for kk=1:4
    plot(Si_E_gen_mu_sv(kk,1:n_story), 1:n_story,'linewidth', 1.9,'Color',CP2(kk,:),'linestyle',lineset{1,kk}); hold on
end
lgnd = legend('Case 1','Case 2','Case 3','Case 4','Location','southeast');
set(lgnd,'FontSize',12.2,'location','southeast');  legend boxoff;
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 13.7;
xlabel('Sensitivity, $S_{\bf{S}}$','fontsize',14.5);
title('Synthetic motions','fontsize',14.5)
ax1.XTick = [0 0.25 0.5 0.75 1];
axis([0 1 1 n_story])
ax1.XTickLabelRotation = 0;

subplot(1,4,3)
for kk=1:4
    plot(Si_GM_sel_mu_sv(kk,1:n_story), 1:n_story,'linewidth', 1.9,'Color',CP1(kk,:),'linestyle',lineset{1,kk}); hold on
end
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 13.7;
xlabel('Sensitivity, $S_{\bf{GM}}$','fontsize',14.5);
% ylabel('Story','fontsize',14.5);
title('Recorded motions','fontsize',14.5)
ax1.XTick = [0 0.25 0.5 0.75 1];
axis([0 1 1 n_story])
ax1.XTickLabelRotation = 0;

subplot(1,4,4)
for kk=1:4
    plot(Si_GM_gen_mu_sv(kk,1:n_story), 1:n_story,'linewidth', 1.9,'Color',CP2(kk,:),'linestyle',lineset{1,kk}); hold on
end
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 13.7;
xlabel('Sensitivity, $S_{\bf{GM}}$','fontsize',14.5);
title('Synthetic motions','fontsize',14.5)
ax1.XTick = [0 0.25 0.5 0.75 1];
axis([0 1 1 n_story])
ax1.XTickLabelRotation = 0;
set(gcf,'unit','centimeters','position',[0 0 1.50*wid 1.45*hei]);
% tightfig;


%%%% PFA
figure()
subplot(1,4,1)
for kk=1:4
    plot(Si_E_sel_mu_sv(kk,n_story+1:2*n_story), 1:n_story,'linewidth', 1.9,'Color',CP1(kk,:),'linestyle',lineset{1,kk}); hold on
end
lgnd = legend('Case 1','Case 2','Case 3','Case 4','Location','southeast');
set(lgnd,'FontSize',13.2,'location','southeast');  legend boxoff;
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 13.7;
xlabel('Sensitivity, $S_{\bf{S}}$','fontsize',14.5);
ylabel('Story','fontsize',14.5);
title('Recorded motions','fontsize',14.5)
ax1.XTick = [0 0.25 0.5 0.75 1];
axis([0 1 1 n_story])
ax1.XTickLabelRotation = 0;

subplot(1,4,2)
for kk=1:4
    plot(Si_E_gen_mu_sv(kk,n_story+1:2*n_story), 1:n_story,'linewidth', 1.9,'Color',CP2(kk,:),'linestyle',lineset{1,kk}); hold on
end
lgnd = legend('Case 1','Case 2','Case 3','Case 4','Location','southeast');
set(lgnd,'FontSize',13.2,'location','southeast');  legend boxoff;
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 13.7;
xlabel('Sensitivity, $S_{\bf{S}}$','fontsize',14.5);
title('Synthetic motions','fontsize',14.5)
ax1.XTick = [0 0.25 0.5 0.75 1];
axis([0 1 1 n_story])
ax1.XTickLabelRotation = 0;

subplot(1,4,3)
for kk=1:4
    plot(Si_GM_sel_mu_sv(kk,n_story+1:2*n_story), 1:n_story,'linewidth', 1.9,'Color',CP1(kk,:),'linestyle',lineset{1,kk}); hold on
end
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 13.7;
xlabel('Sensitivity, $S_{\bf{GM}}$','fontsize',14.5);
title('Recorded motions','fontsize',14.5)
ax1.XTick = [0 0.25 0.5 0.75 1];
axis([0 1 1 n_story])
ax1.XTickLabelRotation = 0;

subplot(1,4,4)
for kk=1:4
    plot(Si_GM_gen_mu_sv(kk,n_story+1:2*n_story), 1:n_story,'linewidth', 1.9,'Color',CP2(kk,:),'linestyle',lineset{1,kk}); hold on
end
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 13.7;
xlabel('Sensitivity, $S_{\bf{GM}}$','fontsize',14.5);
title('Synthetic motions','fontsize',14.5)
ax1.XTick = [0 0.25 0.5 0.75 1];
axis([0 1 1 n_story])
ax1.XTickLabelRotation = 0;
set(gcf,'unit','centimeters','position',[0 0 1.50*wid 1.45*hei]);
% tightfig;

%% Errors

Error_Si_E = abs(Si_E_sel_mu_sv - Si_E_gen_mu_sv)./Si_E_gen_mu_sv.*100;
Error_Si_GM = abs(Si_GM_sel_mu_sv - Si_GM_gen_mu_sv)./Si_GM_gen_mu_sv.*100;

figure()
subplot(1,2,1)
for kk=1:4
    plot(Error_Si_E(kk,1:n_story), 1:n_story,'linewidth', 1.50,'Color','k','linestyle',lineset{1,kk}); hold on
end
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 14;
ax1.XTickLabelRotation = 0;
xlabel('$DF_{S_{\bf{S}}}$ ($\%$)','fontsize',14.6);
ylabel('Story','fontsize',14.8);
axis([0 100 0.8 n_story + 0.2])
ax1.XTick = [0 25 50 75 100];

subplot(1,2,2)
for kk=1:4
    plot(Error_Si_GM(kk,1:n_story), 1:n_story,'linewidth', 1.50,'Color','k','linestyle',lineset{1,kk}); hold on
end
lgnd = legend('Case 1','Case 2','Case 3','Case 4');
set(lgnd,'FontSize',13.5,'location','southeast');  legend boxoff;
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 14;
ax1.XTickLabelRotation = 0;
xlabel('$DF_{S_{\bf{GM}}}$ ($\%$)','fontsize',14.6);
axis([0 100 0.8 n_story + 0.2])
ax1.XTick = [0 25 50 75 100];
set(gcf,'unit','centimeters','position',[0 0 0.80*wid 1.45*hei]);
% tightfig;


figure()
subplot(1,2,1)
for kk=1:4
    plot(Error_Si_E(kk,n_story+1:2*n_story), 1:n_story,'linewidth', 1.50,'Color','k','linestyle',lineset{1,kk}); hold on
end
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 14;
ax1.XTickLabelRotation = 0;
xlabel('$DF_{S_{\bf{S}}}$ ($\%$)','fontsize',14.6);
ylabel('Story','fontsize',14.8);
axis([0 80 0.8 n_story + 0.2])
ax1.XTick = [0 20 40 60 80];

subplot(1,2,2)
for kk=1:4
    plot(Error_Si_GM(kk,n_story+1:2*n_story), 1:n_story,'linewidth', 1.50,'Color','k','linestyle',lineset{1,kk}); hold on
end
lgnd = legend('Case 1','Case 2','Case 3','Case 4');
set(lgnd,'FontSize',13.5,'location','southeast');  legend boxoff;
ax1 = gca;
ax1.YTick = YTick_s;
ax1.XGrid = 'on';
ax1.GridLineStyle = '-';
ax1.GridAlpha = 0.15;
ax1.GridColor = [0.25 0.25 0.25];
ax1.FontSize = 14;
ax1.XTickLabelRotation = 0;
xlabel('$DF_{S_{\bf{GM}}}$ ($\%$)','fontsize',14.6);
axis([0 80 0.8 n_story + 0.2])
ax1.XTick = [0 20 40 60 80];
set(gcf,'unit','centimeters','position',[0 0 0.80*wid 1.45*hei]);
% tightfig;

toc;

