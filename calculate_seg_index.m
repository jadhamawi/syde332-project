function seg = calculate_seg_index(z)

    n = length(z);
    SAME = [];
    for i=1:n
        for j=1:n

            race = z(i,j,1);
            s = 0;
            num_neighbours = count_neighbours(z,i,j);

            % Check that z(i,j,1) isn't a vacancy
            if race
                if i > 1 
                    if z(i-1,j,1) == race
                        s = s + 1;
                    end
                    if j > 1 
                        if z(i-1,j-1,1) == race
                            s = s + 1;
                        end
                    end
                    
                    if j < n 
                        if z(i-1, j+1, 1) == race
                            s = s + 1;
                        end
                    end
                end

                if i < n 
                    if z(i+1,j,1) == race
                        s = s + 1;
                    end
                    
                    if j > 1 
                        if z(i+1,j-1,1) == race
                            s = s + 1;
                        end
                    end
                    
                    if j < n
                        if z(i+1, j+1, 1) == race
                            s = s + 1;
                        end
                    end
 
                end

                if j > 1 
                    if z(i,j-1,1) == race
                        s = s + 1;
                    end

                end

                if j < n 
                    if z(i,j+1,1) == race
                        s = s + 1;
                    end
                end 
                
            end
            
            if num_neighbours~=0
                SAME(i,j) = s/num_neighbours;
                SAME(i,j) = (SAME(i,j)-0.5)*2;                    
            else
                SAME(i,j) = 1;
        end
    end
    
    seg = mean(mean(SAME));
    
end
