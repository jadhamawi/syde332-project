% SYDE 332
% Racial Segregation Model Attempt

% size of grid
n = 40;

% proportion of vacancies
vacanicies_proportion = 0.1;

% number of races
T = 2;

% colors
map = [0 0 0; 1 0 0; 0 1 0; 0 0 1];

% racial dispreference parameter
% minimum fraction of friends that I need to be satisfied
sameness = 7/8;

max_iterations = 10000;

% initialize
z = zeros(n);

for i=1:n
    for j=1:n
        if rand > vacanicies_proportion
            z(i,j) = randi(T);
        end
    end
end

[row,col] = find(z(:,:,1)==0);
pos_vacancies = [row col];

figure,
imagesc(z);
colormap(map);
axis('off');

number_of_moves = zeros(1,max_iterations);

%% run simulation
total_neighbours = 8;

for k=1:max_iterations
    x = randperm(n);
    for i=x
        y = randperm(n);
        for j=y
            if z(i,j)~=0
                not_like_me = 0;

                if i~=1 && z(i-1,j) ~= z(i,j) && z(i-1,j) ~=0
                    not_like_me = not_like_me +1;
                end
                if i~=n && z(i+1,j) ~= z(i,j) && z(i+1,j) ~=0
                    not_like_me = not_like_me +1;
                end
                if j~=1 && z(i,j-1) ~= z(i,j) && z(i,j-1) ~=0
                    not_like_me = not_like_me +1;
                end
                if j~=n && z(i,j+1) ~= z(i,j) && z(i,j+1) ~=0
                    not_like_me = not_like_me +1;
                end
                if i~=1 && j~=1 && z(i-1,j-1) ~= z(i,j) && z(i-1,j-1) ~= 0
                    not_like_me = not_like_me +1;
                end
                if i~=1 && j~=n && z(i-1,j+1) ~= z(i,j) && z(i-1,j+1) ~= 0
                    not_like_me = not_like_me +1;
                end
                if i~=n && j~=1 && z(i+1,j-1) ~= z(i,j) && z(i+1,j-1) ~= 0
                    not_like_me = not_like_me +1;
                end
                if i~=n && j~=n && z(i+1,j+1) ~= z(i,j) && z(i+1,j+1) ~= 0
                    not_like_me = not_like_me +1;
                end
                
                friends = total_neighbours - not_like_me;

                if friends/total_neighbours < sameness
                    
                    idx = randperm(length(pos_vacancies));
                    
                    p = 1;
                    
                    new_x = pos_vacancies(idx(p),1);
                    new_y = pos_vacancies(idx(p),2);

                    z(new_x,new_y) = z(i,j);
                    z(i,j) = 0;
                    number_of_moves(k) = number_of_moves(k) + 1;
                    pos_vacancies(idx(p),1) = i;
                    pos_vacancies(idx(p),2) = j;
                    

                end
            end
%             imagesc(z);
%             colormap(map);
%             axis('off');
%             pause(0.0001);

        end
    end
%     if number_of_moves(k) == 0
%         disp('number of iterations to convergence: ')
%         disp(k);
%         disp('total number of moves to convergence: ')
%         disp(sum(number_of_moves))
%         break;
%     end
    
    SAME = [];
    temp=[];

    for i=1:n
        for j=1:n

            race = z(i,j,1);
            s = 0;

            % Check that z(i,j,1) isn't a vacancy
            if race
                num_neighbours = 0;

                if i > 1 
                    if z(i-1,j,1) == race
                        s = s + 1;
                    end
                    
                    if z(i-1,j,1)
                        num_neighbours = num_neighbours + 1;
                    end
                    
                    if j > 1 
                        if z(i-1,j-1,1) == race
                            s = s + 1;
                        end
                        
                        if z(i-1,j-1,1)
                            num_neighbours = num_neighbours + 1;
                        end
                    end
                    
                    if j < n 
                        if z(i-1, j+1, 1) == race
                            s = s + 1;
                        end
                        
                        if z(i-1, j+1, 1)
                            num_neighbours = num_neighbours + 1;
                        end
                    end
                end

                if i < n 
                    if z(i+1,j,1) == race
                        s = s + 1;
                    end
                    
                    if z(i+1, j, 1)
                        num_neighbours = num_neighbours + 1;
                    end
                    
                    if j > 1 
                        if z(i+1,j-1,1) == race
                            s = s + 1;
                        end
                        
                        if z(i+1, j-1, 1)
                            num_neighbours = num_neighbours + 1;
                        end
                    end
                    
                    if j < n
                        if z(i+1, j+1, 1) == race
                            s = s + 1;
                        end
                        
                        if z(i+1, j+1, 1)
                            num_neighbours = num_neighbours + 1;
                        end
                    end
 
                end

                if j > 1 
                    if z(i,j-1,1) == race
                        s = s + 1;
                    end
                    
                    if z(i, j-1, 1)
                        num_neighbours = num_neighbours + 1;
                    end
                end

                if j < n 
                    if z(i,j+1,1) == race
                        s = s + 1;
                    end
                    
                    if z(i, j+1, 1)
                        num_neighbours = num_neighbours + 1;
                    end
                end 
                
            end
            
            SAME = [SAME;s/num_neighbours];
        end
    end
    temp = [temp; mean(SAME)];
    disp((mean(SAME)));
end

figure,
imagesc(z);
colormap(map);
axis('off');

figure,
plot(1:k,temp);
title('segregation temp');

%% plot number of moves
iterant = 1:max_iterations;
figure,
plot(log10(iterant), log10(number_of_moves));
