function [] = plot_psd(Sxx_1, w, name)

f = figure('visible', 'off','Position', [400 400 900 900]);
subplot(5,1,1);
loglog(w,Sxx_1(:,1),'LineWidth',1.5,'Color',[0.2 0.8 0.8])
ylabel({'$S_{\hat{u}\hat{u}}$','[1/(rad/s)]'},'Interpreter','latex');
% set(legend,'FontName','Helvetica','Location','Northeast','Interpreter','latex');
% legend({'$S_{\hat{u}\hat{u}}$'});
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,2);
loglog(w,Sxx_1(:,2),'LineWidth',1.5,'Color',[0.2 0.8 0.8])
ylabel({'$S_{\alpha\alpha}$';'[$rad^2$/(rad/s)]'},'Interpreter','latex');
% set(legend,'FontName','Helvetica','Location','Northeast','Interpreter','latex');
% legend({'$S_{\alpha\alpha}$'});
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,3);
loglog(w,Sxx_1(:,3),'LineWidth',1.5,'Color',[0.2 0.8 0.8])
ylabel({'$S_{\theta\theta}$';'[$rad^2$/(rad/s)]'},'Interpreter','latex');
% set(legend,'FontName','Helvetica','Location','Northeast','Interpreter','latex');
% legend({'$S_{\theta\theta}$'});
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,4);
loglog(w,Sxx_1(:,4),'LineWidth',1.5,'Color',[0.2 0.8 0.8])
ylabel({'$S_{qq}$';'[$rad^2$/(rad/s)]'},'Interpreter','latex');
% set(legend,'FontName','Helvetica','Location','Northeast','Interpreter','latex');
% legend({'$S_{qq}$'});
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,5);
loglog(w,Sxx_1(:,5),'LineWidth',1.5,'Color',[0.2 0.8 0.8])
ylabel({'$S_{n_zn_z}$','[1/(rad/s)]'},'Interpreter','latex');
xlabel('frequency [rad/s]','Interpreter','latex');
% set(legend,'FontName','Helvetica','Location','Northeast','Interpreter','latex');
% legend({'$S_{n_zn_z}$'});
grid on
set(gcf,'renderer','Painters')
set(findall(gcf,'-property','FontSize'),'FontSize',15)

saveas(f, strcat('Extra plots\PSD_', name),'epsc')

end

