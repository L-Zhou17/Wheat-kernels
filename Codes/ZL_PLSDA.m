function [pp,cacc,pe,pacc,beta] = ZL_PLSDA(Xc,Lc,Xp,Lp,comp)
    [Lc_col,~]=size(Lc);
    [Lp_col,~]=size(Lp);
    yc=zeros(Lc_col,3);
    for i=1:Lc_col
        yc(i,Lc(i))=1;
    end

    yp=zeros(Lp_col,3);
    for i=1:Lp_col
        yp(i,Lp(i))=1;
    end

    [XL,yl,XS,YS,beta,PCTVAR] = plsregress(Xc,yc,comp);

    yfit_c = [ones(size(Xc,1),1) Xc]*beta;
    [~,pp]=max(yfit_c');
    pp=pp';
    cacc=sum(pp==Lc)/Lc_col;
    
    yfit_p = [ones(size(Xp,1),1) Xp]*beta;
    [~,pe]=max(yfit_p');
    pe=pe';
    pacc=sum(pe==Lp)/Lp_col;
end
