function dist = nearest_distance(a_point, set_of_points)

distances  = (set_of_points(:,1) -  a_point(1)).^2+...
    (set_of_points(:,2) -  a_point(2)).^2;

x_center=mean(set_of_points(:,1));
y_center=mean(set_of_points(:,2));




dist=min(distances);

% indx=find(dist==dist); % what is this?!
indx=find(distances==dist); % what is this?!

indx=indx(1);

r_border2 = (set_of_points(indx,1)-x_center)^2+...
    (set_of_points(indx,2)-y_center)^2;

r_cell2 = (a_point(1)-x_center)^2+...
    (a_point(2)-y_center)^2;


if r_cell2>r_border2
    dist=sqrt(dist);
else
    dist=-sqrt(dist);
end

%dist_center = 

end