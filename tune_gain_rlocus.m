function [] = tune_gain_rlocus(sys_MIMO,output1,state1)

% This function plots the root-locus of the open-loop system, in order to determine the right gains

sys_SISO = sys_MIMO(output1,state1);
f = figure('visible', 'off','Position', [400 400 500 450]);
rlocusplot(-sys_SISO);
findobj(gca,'type','line');
a = findobj(gca,'type','line');
for i = 1:length(a)
    set(a(i),'markersize',10) %change marker size
    set(a(i), 'linewidth',2)  %change linewidth
end
xlim([-1.5 0.1]);
ylim([-2.5 2.5]);
%set(legend,'FontName','Helvetica','Location','Northeast');
% legend({'Closed-Loop','Open-Loop'});
set(gcf,'renderer','Painters')
set(findall(gcf,'-property','FontSize'),'FontSize',15)
saveas(f,strcat('Plots\rlocus'),'epsc');

end

