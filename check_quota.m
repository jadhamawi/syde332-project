function meets_quota = check_quota(z,old_x,old_y,new_x,new_y,T,radius)
    
meets_quota = 0;

n = length(z);

neighbourhood = 0;
race_counts = zeros(1,T);

xbounds = new_x-radius:new_x+radius;   
ybounds = new_y-radius:new_y+radius;

if new_x - radius < 1
    xbounds = 1:new_x+radius;
end
if new_x + radius > n
    xbounds = new_x-radius:n;
end
if new_y - radius < 1
    ybounds = 1:new_y+radius;
end
if new_y + radius > n
    ybounds = new_y-radius:n;
end

for i = xbounds
    for j = ybounds
        for k = 1:T
            if z(i,j,1) ~=0
                neighbourhood = neighbourhood + 1;
            end
            if z(i,j,1) == k
                race_counts(k) = race_counts(k) + 1;
            end
        end
    end
end

[Y, I] = min(race_counts);

if z(old_x,old_y,1) == I
    meets_quota = 1;
end
    






        
    