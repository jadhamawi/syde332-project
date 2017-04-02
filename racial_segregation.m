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
sameness = 4/8;

max_iterations = 2000;

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
seg_index = [];

for k=1:max_iterations
    for i=randperm(n);
        for j=randperm(n);
            if z(i,j)~=0
                
                not_like_me = count_not_like_me(z,i,j);
                
                friends = total_neighbours - not_like_me;

                if friends/total_neighbours < sameness %going to move!
                    
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

seg_index

figure,
imagesc(z);
colormap(map);
title('Simulation results of Schelling model');
axis('off');

figure,
plot(seg_index);
title('Segregation index');
axis([0 inf 0 1])

%% plot number of moves
% iterant = 1:max_iterations;
% figure,
% plot(log10(iterant), log10(number_of_moves));
