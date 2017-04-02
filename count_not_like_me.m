function not_like_me = count_not_like_me(z, i, j)

    not_like_me = 0;
    n = length(z);

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
    
end