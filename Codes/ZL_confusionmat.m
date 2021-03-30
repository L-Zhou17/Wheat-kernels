function ZL_confusionmat(label,prediction,fn)
    catg = length(unique(label)); 
    LL=label;
    RR=prediction;
    A=[];
    for i=1:catg
        loc=find(LL==i);
        [A(i,1:catg),~]=hist(RR(loc,:),1:catg);
    end

    ACC=(LL==RR);
    ac=sum(ACC)/length(ACC);
    B=A./repmat(sum(A')',1,catg);
    imagesc(B')
    for ii=1:catg
        for jj=1:catg
            if(ii==jj)
                text(ii-0.1,jj,num2str(A(ii,jj)),'Color','black','FontSize',6);
            else
                text(ii-0.1,jj,num2str(A(ii,jj)),'Color','black','FontSize',6);
            end
        end
    end
    map=[1 1 1;
        0.9804 0.9216 0.8431;
        0.9804 0.9216 0.8431;
        0.9804 0.9216 0.8431;
        0 0.749 1;
        0 0.749 1;
        0 0.749 1;
        0 0.749 1];
    colormap(map)
%     colorbar
    xlabel('Observation');
    ylabel('Prediction');
    title([fn ' ACC = ' num2str(ac*100) ' %'])
end

