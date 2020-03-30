function [] = plot_time_response(sys, u_turb, gust_type,t_max,dt)

% Plot the time response for all five variables based on the input signal and time vector parameters

t = [0:dt:t_max];

y_lsim = lsim(sys, u_turb, t);

f = figure('visible', 'off','Position', [400 400 900 900]);
subplot(6,1,1);

if strcmp(gust_type,'horz')
    plot(t,u_turb(2,:),'LineWidth',1.5,'Color',[0.9098    0.4353    0.4353])
    ylabel({'$w_1$','[m/s]'},'Interpreter','latex');
elseif strcmp(gust_type,'vert')
    plot(t,u_turb(3,:),'LineWidth',1.5,'Color',[0.9098    0.4353    0.4353])
    ylabel({'$w_3$','[m/s]'},'Interpreter','latex');
end

xlim([0 50]);
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(6,1,2);
plot(t,y_lsim(:,1),'LineWidth',1.5,'color',[0 0.5 1])
grid on
ylabel({'$\hat{u}$','[-]'},'Interpreter','latex');
xlim([0 50]);
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(6,1,3);
plot(t,y_lsim(:,2),'LineWidth',1.5,'color',[0 0.5 1])
grid on
ylabel({'$\alpha$','[rad]'},'Interpreter','latex');
xlim([0 50]);
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(6,1,4);
plot(t,y_lsim(:,3),'LineWidth',1.5,'color',[0 0.5 1])
grid on
ylabel({'$\theta$','[rad]'},'Interpreter','latex');
xlim([0 50]);
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(6,1,5);
plot(t,y_lsim(:,4),'LineWidth',1.5,'color',[0 0.5 1])
grid on
ylabel({'$\frac{q\bar{c}}{V}$','[rad]'},'Interpreter','latex');
xlim([0 50]);
set(findall(gcf,'-property','FontSize'),'FontSize',15)

subplot(6,1,6);
plot(t,y_lsim(:,5),'LineWidth',1.5,'color',[0 0.5 1])
grid on
ylabel({'$n_z$','[-]'},'Interpreter','latex');
xlim([0 50]);
xlabel('time [s]');
set(gcf,'renderer','Painters')
set(findall(gcf,'-property','FontSize'),'FontSize',15)

saveas(f,strcat('Plots\time_response_', gust_type),'epsc')
close(f)

end

