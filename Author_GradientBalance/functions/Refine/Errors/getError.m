function [dis,nanNum] = getError(p_refined,p_true)
nanNum=sum(isnan(p_refined(:,1)));
if nanNum==size(p_refined,1)
    dis=0;
    return;
end
p_diff=p_refined-p_true;
p_diff=p_diff.^2;
p_diff=sum(p_diff,2);
p_diff=sqrt(p_diff);
dis=mean(p_diff,'omitnan');
end