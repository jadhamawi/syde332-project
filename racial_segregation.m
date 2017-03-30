% SYDE 332
% Racial Segregation Model Attempt

% size of grid
n = 10;

% proportion of vacancies
vacanicies_proportion = 0.1;

% number of races
T = 3;

% colors
map = [0 0 0; 1 0 0; 0 1 0; 0 0 1];

% racial dispreference parameter
% minimum fraction of friends that I need to be satisfied
F = 4/8;

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

                if friends/total_neighbours < F

                    new_x = randi(n);
                    new_y = randi(n);
                    while z(new_x,new_y) ~= 0
                        new_x = randi(n);
                        new_y = randi(n);
                    end

                    z(new_x,new_y) = z(i,j);
                    z(i,j) = 0;
                    number_of_moves(k) = number_of_moves(k) + 1;

                end
            end
%             imagesc(z);
%             colormap(map);
%             axis('off');
%             pause(0.0001);

        end
    end
    if number_of_moves(k) == 0
        disp('number of iterations to convergence: ')
        disp(k);
        disp('total number of moves to convergence: ')
        disp(sum(number_of_moves))
        break;
    end
end

figure,
imagesc(z);
colormap(map);
axis('off');

%% plot number of moves
iterant = 1:max_iterations;
figure,
plot(log10(iterant), log10(number_of_moves));