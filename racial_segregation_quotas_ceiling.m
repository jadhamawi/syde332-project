% SYDE 332
% Racial Segregation Model Attempt

% size of grid
n = 40;

% neighbourhood radius
radius = 4;

% proportion of vacancies
vacanicies_proportion = 0.1;

% number of races
T = 2;

% colors
map = [0 0 0; 1 0 0; 0 1 0; 0 0 1];

% racial dispreference parameter
% minimum fraction of friends that I need to be satisfied
sameness = 4/8;

max_iterations = 2000;

% initialize
z = zeros(n);

for i=1:n
    for j=1:n
        race_value = rand;
        if race_value > vacanicies_proportion
            if race_value < 0.76
                z(i,j) = 1; % Chinese homies
            else
                z(i,j) = 2; % Malay homies ? can add more ethnic diversity later 
            end
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
seg_index = [];

for k=1:max_iterations
    for i=randperm(n);
        for j=randperm(n);
            
            if z(i,j)~=0
                
                race = z(i,j);
                
                not_like_me = count_not_like_me(z,i,j);
                
                friends = total_neighbours - not_like_me;
                

                if friends/total_neighbours < sameness % need to move!
                    
                    idx = randperm(length(pos_vacancies));
                    
                    p = 1;
                    
                    new_x = pos_vacancies(idx(p),1);
                    new_y = pos_vacancies(idx(p),2);
                    
                    meets_quota = check_quota(z,i,j,new_x,new_y,T,radius, true);
                    
                    while meets_quota ~= 1
                        p = p+1;
                        new_x = pos_vacancies(idx(p),1);
                        new_y = pos_vacancies(idx(p),2);
                        meets_quota = check_quota(z,i,j,new_x,new_y,T,radius, true);
                    end
                    
                    if meets_quota && p <= length(pos_vacancies)
                        z(new_x,new_y) = z(i,j);
                        z(i,j) = 0;
                        number_of_moves(k) = number_of_moves(k) + 1;
                        pos_vacancies(idx(p),1) = i;
                        pos_vacancies(idx(p),2) = j;
                    end
                        

                end
            end

        end
    end
    
    seg_index = [seg_index, calculate_seg_index(z)];
    
    if number_of_moves(k) == 0
        disp('number of iterations to convergence: ')
        disp(k);
        disp('total number of moves to convergence: ')
        disp(sum(number_of_moves))
        break;
    end

end

% seg_index
%% plots
figure,
imagesc(z);
colormap(map);
title(['Simulation results of quota model, sameness = ' num2str(sameness) ', radius = ' num2str(radius)]);
axis('off');

figure,
plot(seg_index);
title('Segregation index');
axis([0 inf 0 1])

%% plot number of moves
% iterant = 1:max_iterations;
% figure,
% plot(log10(iterant), log10(number_of_moves));
