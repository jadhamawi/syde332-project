% SYDE 332
% Racial Segregation Model Attempt


%% initialize

% size of grid
n = 40;

% proportion of vacancies
vacanicies_proportion = 0.1;

% number of races
T = 2;

% number of economic brackets
E = 5;

% colors
map = [0 0 0; 1 0 0; 0 1 0; 0 0 1];

% racial dispreference parameter
% minimum fraction of friends that I need to be satisfied (samenes)
sameness = 4/8;

max_iterations = 10000;

% initialize
z = zeros(n,n,3);

for i=1:n
    for j=1:n
        if rand > vacanicies_proportion
            z(i,j,1) = randi(T);
            if rand < 0.5
                z(i,j,2) = 1; % individual wealth
            elseif rand < 0.8
                z(i,j,2) = 2;
            elseif rand < 0.95
                z(i,j,2) = 3;
            elseif rand < 0.99
                z(i,j,2) = 4;
            else 
                z(i,j,2) = 5;
            end
        end
        
        % power law housing prices
%         if rand < 0.5
%             z(i,j,3) = 1; % home prices
%         elseif rand < 0.8
%             z(i,j,3) = 2;
%         elseif rand < 0.95
%             z(i,j,3) = 3;
%         elseif rand < 0.99
%             z(i,j,3) = 4;
%         else 
%             z(i,j,3) = 5;
%         end
        
        % random housing
        %z(i,j,3) = randi(E);
        
        % slight affordable housing
%         if rand < 0.55
%             z(i,j,3) = 1; % home prices
%         elseif rand < 0.82
%             z(i,j,3) = 2;
%         elseif rand < 0.95
%             z(i,j,3) = 3;
%         elseif rand < 0.99
%             z(i,j,3) = 4;
%         else 
%             z(i,j,3) = 5;
%         end
        
        % more affordable housing
%         if rand < 0.6
%             z(i,j,3) = 1; % home prices
%         elseif rand < 0.85
%             z(i,j,3) = 2;
%         elseif rand < 0.97
%             z(i,j,3) = 3;
%         elseif rand < 0.995
%             z(i,j,3) = 4;
%         else 
%             z(i,j,3) = 5;
%         end

        % rent control
%         if rand < 0.7
%             z(i,j,3) = 1; % home prices
%         elseif rand < 0.9
%             z(i,j,3) = 2;
%         elseif rand < 0.98
%             z(i,j,3) = 3;
%             disp('lol')
%         elseif rand < 0.995
%             z(i,j,3) = 4;
%         else 
%             z(i,j,3) = 5;
%         end
            
        
        
    end
end

[row,col] = find(z(:,:,1)==0);
pos_vacancies = [row col];

% figure,
% imagesc(z(:,:,1));
% colormap(map);
% title('race initializiation - bracketed income, housing prices random');
% axis('off');

% figure,
% imagesc(z(:,:,2));
% title('economics initializiation');
% axis('off');

number_of_moves = zeros(1,max_iterations);

%% run simulation

seg_index = [];
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
                    
                    %%% start option A: 
                    %%% find a vacancy. If I can afford, move there. else,
                    %%% stop.
                    
%                     new_x = pos_vacancies(idx(p),1);
%                     new_y = pos_vacancies(idx(p),2);
%                     
%                     if z(new_x,new_y,3) <= z(i,j,2)
%                         z(new_x,new_y,1) = z(i,j,1);
%                         z(new_x,new_y,2) = z(i,j,2);
%                         z(i,j,1) = 0;
%                         z(i,j,2) = 0;
%                         number_of_moves(k) = number_of_moves(k) + 1;
%                         pos_vacancies(idx(p),1) = i;
%                         pos_vacancies(idx(p),2) = j;
%                     end
                    
                    %%% end option A
                    
                    
                    %%% start option B:
                    %%% find a vacancy. If I can afford, move there.
                    %%% else, find another vacancy
                    %%% loop until I can afford to move OR I've exhausted
                    %%% vacancies.
                    
                    new_x = pos_vacancies(idx(p),1);
                    new_y = pos_vacancies(idx(p),2);
                    
                    while z(new_x,new_y,3) > z(i,j,2) && p < length(pos_vacancies)
                    %while z(new_x,new_y,3) - z(i,j,2) > 0 && p < length(pos_vacancies)
                        p = p+1;
                        new_x = pos_vacancies(idx(p),1);
                        new_y = pos_vacancies(idx(p),2);
                    end
                    

                    if p < length(pos_vacancies) && z(new_x,new_y,3) <= z(i,j,2)
                    %if p < length(pos_vacancies) && (z(i,j,2) - z(new_x,new_y,3) >= 0 && z(i,j,2) - z(new_x,new_y,3) <= 1)
                        z(new_x,new_y,1) = z(i,j,1);
                        z(new_x,new_y,2) = z(i,j,2);
                        z(i,j,1) = 0;
                        z(i,j,2) = 0;
                        number_of_moves(k) = number_of_moves(k) + 1;
                        pos_vacancies(idx(p),1) = i;
                        pos_vacancies(idx(p),2) = j;
                    end
                    
                    %%% end option B

                end
            end
%             imagesc(z(:,:,1));
%             colormap(map);
%             axis('off');
%             pause(0.001);

        end
    end
    
    if number_of_moves(k) == 0
        disp('number of iterations to convergence: ')
        disp(k);
        disp('total number of moves to convergence: ')
        disp(sum(number_of_moves))
        break;
    end
    
    
    % determine segregation index
    SAME = [];

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
            
            SAME(i,j) = s/num_neighbours;
        end
    end
    
    mean(mean(SAME));
    seg_index = [seg_index, (mean(mean(SAME))-0.5)*2];
     
end

seg_index

figure,
imagesc(z(:,:,1));
colormap(map);
axis('off');
title('final by race - power law income, power law housing prices');

figure,
plot(seg_index);
title('segregation index');
axis([0 inf 0 1])

% figure,
% imagesc(z(:,:,2));
% axis('off');
% title('final by economics');


%% plot number of moves
% iterant = 1:max_iterations;
% figure,
% plot(log10(iterant), log10(number_of_moves));
% xlabel('iteration'),ylabel('number of moves');

