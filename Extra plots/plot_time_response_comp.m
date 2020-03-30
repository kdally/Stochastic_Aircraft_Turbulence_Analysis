function [] = plot_time_response_comp(sys, u_turb_h, u_turb_v,t_max,dt)

t = [0:dt:t_max];

y_h = lsim(sys, u_turb_h, t);
y_v = lsim(sys, u_turb_v, t);

f = figure('visible', 'off','Position', [400 400 900 900]);
subplot(5,1,1);
plot(t,y_h(:,1),'LineWidth',1.5,'color',[0 0.5 1])
hold on
plot(t,y_v(:,1),'LineWidth',1.5,'color',[1 0 0])
grid on
ylabel({'$\hat{u}$','[-]'},'Interpreter','latex');
xlim([0 50]);
set(legend,'FontName','Helvetica','Location','Northeast','Interpreter','latex');
legend({'horizontal','vertical'});
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,2);
plot(t,y_h(:,2),'LineWidth',1.5,'color',[0 0.5 1])
hold on
plot(t,y_v(:,2),'LineWidth',1.5,'color',[1 0 0])
grid on
ylabel({'$\alpha$','[rad]'},'Interpreter','latex');
xlim([0 50]);
% set(legend,'FontName','Helvetica','Location','Northeast','Interpreter','latex');
% legend('$\alpha$,hor','$\alpha$,ver');
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,3);
plot(t,y_h(:,3),'LineWidth',1.5,'color',[0 0.5 1])
hold on
plot(t,y_v(:,3),'LineWidth',1.5,'color',[1 0 0])
grid on
ylabel({'$\theta$','[rad]'},'Interpreter','latex');
xlim([0 50]);
% set(legend,'FontName','Helvetica','Location','Northeast','Interpreter','latex');
% legend('$\theta$,hor','$\theta$,ver');
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,4);
plot(t,y_h(:,4),'LineWidth',1.5,'color',[0 0.5 1])
hold on
plot(t,y_v(:,4),'LineWidth',1.5,'color',[1 0 0])
grid on
ylabel({'$\frac{q\bar{c}}{V}$','[rad]'},'Interpreter','latex');
xlim([0 50]);
% set(legend,'FontName','Helvetica','Location','Northeast','Interpreter','latex');
% legend({'$\frac{q\bar{c}}{V}$,hor','$\frac{q\bar{c}}{V}$,ver'});
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(5,1,5);
plot(t,y_h(:,5),'LineWidth',1.5,'color',[0 0.5 1])
hold on
plot(t,y_v(:,5),'LineWidth',1.5,'color',[1 0 0])
grid on
ylabel({'$n_z$','[rad]'},'Interpreter','latex');
xlim([0 50]);
xlabel('time [s]');
% set(legend,'FontName','Helvetica','Location','Northeast','Interpreter','latex');
% legend({'$n_z$,hor','$n_z$,ver'});
set(gcf,'renderer','Painters')
set(findall(gcf,'-property','FontSize'),'FontSize',15)

saveas(f,strcat('Extra plots\time_response_comp'),'epsc')

end

