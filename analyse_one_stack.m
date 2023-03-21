function points = analyse_one_stack(one_stack)

points = [];

convx=0.618546072336379;
convy=0.618546072336379;
convz = 1.5;

for iz = 1:49
    [ys_indx, xs_indx, ~ ] = find (one_stack(:,:,iz)>0);
    xs = xs_indx*convx;
    ys = ys_indx*convy;
    
    %disp([length(xs) length(ys)])
    
    zs = iz * convz * ones(length(xs),1);
    
    points_here = [xs'; ys'; zs']';
    points = [points; points_here];
end
end