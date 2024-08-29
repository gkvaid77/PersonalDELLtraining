function ProcessNPlot_eps(sig,E_mat,E_Cumm_mat,e_per,Eb_eps,perceptionT,f,p,io)

     lt1 = sprintf('SE %2.1f %% ,%3.2f',e_per(1),E_Cumm_mat(1));
     lt2 = sprintf('MCE %2.1f %%, %3.2f',e_per(2),E_Cumm_mat(2));
     lt3 = sprintf('FCE %2.1f %%, %3.2f',e_per(3),E_Cumm_mat(3));
     lt4 = sprintf('FDCE %2.1f %%, %3.2f',e_per(4),E_Cumm_mat(4));

    N = length(sig.in);
    p_limit_text = sprintf('Percp Thr %2.2f',perceptionT);

    
    % plot figure
    Eb_eps_max = 1000;
    figure(77)
    s1 = subplot(2,p,io)
    hold on; grid minor;
    plot(sig.time,sig.in,'k-','linewidth',1.5);
    plot(sig.time,sig.out,'b-','linewidth',1.5);
    plot(sig.time,perceptionT*ones(1,N),'r--')
    plot(sig.time,-perceptionT*ones(1,N),'r--')
    ylabel('units')
    legend('In','Out',p_limit_text,'Location','northwest')
    title(f(io,5:end-4))
    xlabel('time [s]')
    s2 = subplot(2,p,io+p)
    yyaxis left
    area(sig.time,E_mat(1:end,1),'FaceColor',[0.3 0.3 0],'EdgeColor',[0.3 0.3 0])
    hold all
    area(sig.time,E_mat(1:end,2),'FaceColor',[1 1 0],'EdgeColor',[1 1 0])
    area(sig.time,E_mat(1:end,3),'FaceColor',[0.9290 0.6940 0.1250],'EdgeColor',[0.9290 0.6940 0.1250])
    area(sig.time,E_mat(1:end,4),'FaceColor',[0.8500 0.3250 0.0980],'EdgeColor',[0.8500 0.3250 0.0980])
    xlabel('time [s]')
    ylabel('\epsilon  diff')
%     ylim([0 1])
    title('Errors')
    grid minor
    yyaxis right
    hold all
    plot(sig.time,Eb_eps(:,1)/0.5,'m-','LineWidth',2)
    plot(sig.time,Eb_eps(:,2)/1,'c-','LineWidth',2)
    plot(sig.time,Eb_eps(:,3)/2,'g-','LineWidth',2)
    plot(sig.time,Eb_eps(:,4)/5,'Color',[0.6350 0.0780 0.1840],'LineWidth',2,'LineStyle','-')
%     ylim([0 3600])   
    legend(lt1,lt2,lt3,lt4,'nWSE0.5','nWSE1','nWSE2','nWSE5')
    ylabel('nWSE')
    linkaxes([s1 s2],'x')
    hold off
    sgtitle('Error Classification')

end