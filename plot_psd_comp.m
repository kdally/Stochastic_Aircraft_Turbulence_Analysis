function [] = plot_psd_comp(Sxx_3, w3, Sxx_2, w2, Sxx_1, w1, gust_type, window)

% This function plots the PSD of the five variables for all three calculation methods

f = figure('visible', 'off','Position', [400 400 900 900]);
subplot(5,1,1);
g1 = loglog(w1,Sxx_1(:,1),'LineWidth',1,'Color',[1.0000    0.2314    0.2314]);
hold on
loglog(w2,Sxx_2(:,1),'LineWidth',1.5,'Color',[0    0.3804    0.7608]);
g3 = loglog(w3,Sxx_3(:,1),'LineWidth',1.5,'Color',[0.3922    0.8314    0.0745]);
ylabel({'$S_{\hat{u}\hat{u}}$','[1/(rad/s)]'},'Interpreter','latex');
xlim([1e-2 1e2]);
ylim([1e-15 1e0]);
set(legend,'FontName','Helvetica','Location','Northeast');
if strcmp(window,'_hann')
  legend({'Experimental (smoothed, windowed)','Experimental (windowed)','Analytical'});
else 
   legend({'Experimental (smoothed)','Experimental','Analytical'});
end
uistack(g1,'top'); uistack(g3,'top');
uistack(g3,'top');
reorderLegend([1,3,2])
grid on; grid minor;
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,2);
g1 = loglog(w1,Sxx_1(:,2),'LineWidth',1,'Color',[1.0000    0.2314    0.2314]);
hold on
loglog(w2,Sxx_2(:,2),'LineWidth',1.5,'Color',[0    0.3804    0.7608])
g3 = loglog(w3,Sxx_3(:,2),'LineWidth',1.5,'Color',[0.3922    0.8314    0.0745]);
ylabel({'$S_{\alpha\alpha}$';'[$rad^2$/(rad/s)]'},'Interpreter','latex');
ylim([1e-15 1e0]);
xlim([1e-2 1e2]);
uistack(g1,'top'); uistack(g3,'top'); uistack(g3,'top');
reorderLegend([2,1,3])
grid on; grid minor;
legend off
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,3);
g1 = loglog(w1,Sxx_1(:,3),'LineWidth',1,'Color',[1.0000    0.2314    0.2314]);
hold on
loglog(w2,Sxx_2(:,3),'LineWidth',1.5,'Color',[0    0.3804    0.7608])
g3 = loglog(w3,Sxx_3(:,3),'LineWidth',1.5,'Color',[0.3922    0.8314    0.0745]);
ylabel({'$S_{\theta\theta}$';'[$rad^2$/(rad/s)]'},'Interpreter','latex');
if strcmp(gust_type,'horz')
    ylim([1e-20 1e0]);
elseif strcmp(gust_type,'vert')
    ylim([1e-15 1e0]);
end
xlim([1e-2 1e2]);
uistack(g1,'top'); uistack(g3,'top');
reorderLegend([2,1,3])
grid on; grid minor;
legend off
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,4);
g1 = loglog(w1,Sxx_1(:,4),'LineWidth',1,'Color',[1.0000    0.2314    0.2314]);
hold on
loglog(w2,Sxx_2(:,4),'LineWidth',1.5,'Color',[0    0.3804    0.7608])
g3 = loglog(w3,Sxx_3(:,4),'LineWidth',1.5,'Color',[0.3922    0.8314    0.0745]);
ylabel({'$S_{qq}$';'[$rad^2$/(rad/s)]'},'Interpreter','latex');
if strcmp(gust_type,'horz')
    ylim([1e-17 1e-8]);
    yticks([1e-15 1e-10])
elseif strcmp(gust_type,'vert')
    ylim([1e-15 1e-5]);
end
xlim([1e-2 1e2]);
uistack(g1,'top'); uistack(g3,'top');
reorderLegend([2,1,3])
grid on; grid minor;
legend off
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,5);
g1 = loglog(w1,Sxx_1(:,5),'LineWidth',1,'Color',[1.0000    0.2314    0.2314]);
hold on
loglog(w2,Sxx_2(:,5),'LineWidth',1.5,'Color',[0    0.3804    0.7608])
g3 = loglog(w3,Sxx_3(:,5),'LineWidth',1.5,'Color',[0.3922    0.8314    0.0745]);
ylabel({'$S_{n_zn_z}$','[1/(rad/s)]'},'Interpreter','latex');
if strcmp(gust_type,'horz')
    ylim([1e-10 1e-2]);
elseif strcmp(gust_type,'vert')
    ylim([1e-8 1e0]);
end
xlim([1e-2 1e2]);
xlabel('frequency [rad/s]');
uistack(g1,'top'); uistack(g3,'top');
reorderLegend([2,1,3])
grid on; grid minor;; grid minor;; grid minor;
legend off
set(gcf,'renderer','Painters')
set(findall(gcf,'-property','FontSize'),'FontSize',15)

saveas(f, strcat('Plots\PSD_comp_', gust_type, window),'epsc')

end

