function num_neighbours = count_neighbours(z, i, j)
    num_neighbours = 0;
    n = length(z);

    if i > 1 

        if z(i-1,j,1)
            num_neighbours = num_neighbours + 1;
        end

        if j > 1 
            if z(i-1,j-1,1)
                num_neighbours = num_neighbours + 1;
            end
        end

        if j < n 
            if z(i-1, j+1, 1)
                num_neighbours = num_neighbours + 1;
            end
        end
    end

    if i < n 
        if z(i+1, j, 1)
            num_neighbours = num_neighbours + 1;
        end

        if j > 1 

            if z(i+1, j-1, 1)
                num_neighbours = num_neighbours + 1;
            end
        end

        if j < n
            if z(i+1, j+1, 1)
                num_neighbours = num_neighbours + 1;
            end
        end

    end

    if j > 1 
        if z(i, j-1, 1)
            num_neighbours = num_neighbours + 1;
        end
    end

    if j < n 
        if z(i, j+1, 1)
            num_neighbours = num_neighbours + 1;
        end
    end 
end