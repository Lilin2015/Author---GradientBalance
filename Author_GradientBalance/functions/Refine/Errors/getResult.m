function error=getResult(dis)
%remove the best and worst 5%
num_levels=size(dis,1);
num_repeats=size(dis,2);
num_types=size(dis,3);
%num_remove=round(0.1*num_repeats);
num_remove=0;

error=zeros(num_levels,num_types);
for t=1:num_types
    d=dis(:,:,t);
    d=sort(d,2);
    d=d(:,1+num_remove:end-num_remove);
    d=mean(d,2);  
    error(:,t)=d;
end
end