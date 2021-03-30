function [acc,ml] = ZL_kfold_PLSDA(k,Xc,Lc,maxcopm)
    indices = crossvalind('Kfold',length(Lc),k);
    for comp=1:maxcopm
        ylist=[];
        y_list=[];
        for i=1:k 
            test=(indices==i);
            train=~test;
            data_train=Xc(train,:);
            label_train=Lc(train,:);
            data_test=Xc(test,:);
            label_test=Lc(test,:);
            [yc,cacc,yp,pacc,beta] = ZL_PLSDA(data_train,label_train,data_test,label_test,comp);
            ylist=[ylist;label_test];
            y_list=[y_list;yp];

        end
        acc(comp)=sum(ylist==y_list)/length(y_list);
    end 
    figure
    plot(1:maxcopm,acc,'ko');
    hold on
    plot(1:maxcopm,acc,'k');
    [mv,ml]=max(acc);
    text(ml,mv-0.2,['Best-comp: ',num2str(ml),sprintf('\n'),'Acc-CV: ',num2str(mv)]);
    plot(ml,mv,'LineStyle','none','Marker','o','MarkerSize',5,'MarkerFace','c','MarkerEdge',[0,0,0],'LineWidth',0.5);
    xlabel('Numbers of component used for modeling');
    ylabel('Accuracy of K-fold validation');
end
