function [] = plot_poles_zeros_map(sys,sys_open)

% This function plots the pole-zero map of both the open and closed-loop systems

f = figure('visible', 'off','Position', [400 400 600 450]);
pzplot(sys,sys_open);
findobj(gca,'type','line');
a = findobj(gca,'type','line');
for i = 1:length(a)
    set(a(i),'markersize',10) %change marker size
    set(a(i), 'linewidth',2)  %change linewidth
end
xlim([-1.5 0.1]);
ylim([-2.3 2.3]);
sgrid
set(legend,'FontName','Helvetica','Location','Northeast');
legend({'Closed-Loop','Open-Loop'});
set(gcf,'renderer','Painters')
set(findall(gcf,'-property','FontSize'),'FontSize',15)
saveas(f,strcat('Plots\pzmap'),'epsc');

end

