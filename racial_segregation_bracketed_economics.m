% SYDE 332
% Racial Segregation Model Attempt

% size of grid
n = 40;

% proportion of vacancies
vacanicies_proportion = 0.1;

% number of races
T = 3;

% number of economic brackets
E = 5;

% colors
map = [0 0 0; 1 0 0; 0 1 0; 0 0 1];

% racial dispreference parameter
% minimum fraction of friends that I need to be satisfied (samenes)
sameness = 4/8;


max_iterations = 2000;

% initialize
z = zeros(n,n,3);

for i=1:n
    for j=1:n
        if rand > vacanicies_proportion
            z(i,j,1) = randi(T);
            z(i,j,2) = randi(E); % individual wealth
        end
        z(i,j,3) = randi(E);    % home prices
    end
end

[row,col] = find(z(:,:,1)==0);
pos_vacancies = [row col];

figure,
imagesc(z(:,:,1));
colormap(map);
title('race initializiation - bracketed income, housing prices random');
axis('off');

% figure,
% imagesc(z(:,:,2));
% colormap(map);
% title('economics initializiation');
% axis('off');

number_of_moves = zeros(1,max_iterations);

%% run simulation
seg_index = [];
total_neighbours = 8;

for k=1:max_iterations
    for i=randperm(n);
        for j=randperm(n);
            if z(i,j)~=0
                not_like_me = count_not_like_me(z,i,j);
                
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
                        p = p+1;
                        new_x = pos_vacancies(idx(p),1);
                        new_y = pos_vacancies(idx(p),2);
                    end
                    

                    if p < length(pos_vacancies) && z(new_x,new_y,3) <= z(i,j,2)
                    
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
    
    % determine segregation index
    seg_index = [seg_index, calculate_seg_index(z)];
    
    if number_of_moves(k) == 0
        disp('number of iterations to convergence: ')
        disp(k);
        disp('total number of moves to convergence: ')
        disp(sum(number_of_moves))
        break;
<<<<<<< HEAD
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
    seg_index = [seg_index, (mean(mean(SAME))-0.5)*T*100];
    
=======
    end    
>>>>>>> 44659116a77d89befbdba47cb5f47bbb4405a114
    
end


figure,
imagesc(z(:,:,1));
colormap(map);
axis('off');
title(['Schelling model with bracketed economics, Sameness ' num2str(sameness*8) '/8']);

figure,
plot(seg_index);
title('Segregation index');
axis([0 inf 0 100]);
xlabel('Iteration'), ylabel('Segregation %');

% figure,
% imagesc(z(:,:,2));
% axis('off');
% title('final by economics');


%% plot number of moves
% iterant = 1:max_iterations;
% figure,
% plot(log10(iterant), log10(number_of_moves));
% xlabel('iteration'),ylabel('number of moves');

