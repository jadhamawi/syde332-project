function meets_quota = check_quota(z,old_x,old_y,new_x,new_y,T,radius,bounded)
 
meets_quota = 0;
race_quotas = [0.84, 0.22, 0.10];

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

if bounded
    race = z(old_x, old_y, 1);
  
    if race_counts(race)/neighbourhood < race_quotas(race) % Check if new neighbourbood exceeds LKY's ceilings
        meets_quota = 1;
    end
    
else
    [NUM_RACE, RACE_VALUE] = min(race_counts); % Check if will be minority in new neighbourhood
    if z(old_x,old_y,1) == RACE_VALUE
        meets_quota = 1;
    end  
end








        
    