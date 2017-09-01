function [ solved ] = recursiveMaze( maze )
start = find(maze == 'O');
[movesList] = nextMove(maze, start, []);
mask = movesList == 'o';
maze(mask) = 'o';
solved = maze;
end

function [newmaze, finalpos] = nextMove(maze, pos, prevstep)
finalpos = false;
[r, c] = size(maze);
newmaze = maze
prevstep = [prevstep pos];
if any(pos == [1:r])
    if maze(pos-1) == 'X' | maze(pos+1) == 'X' | maze(pos+r) == 'X'   
        newmaze = maze;
        finalpos = true;
    elseif maze(pos-1) == ' ' %check up
        nextPos = pos-1;
        newmaze(nextPos) = 'o';
        [newmaze] = nextMove(newmaze,nextPos, prevstep);
    elseif maze(pos+1) == ' ' %check down
        nextPos = pos+1;
        newmaze(nextPos) = 'o';
        [newmaze] = nextMove(newmaze, nextPos, prevstep);
    elseif maze(pos+r) == ' ' %check right
        nextPos = pos+r;
        newmaze(nextPos) = 'o';
        [newmaze] = nextMove(newmaze, nextPos, prevstep);
    else
        newmaze(pos) = '#';
    end
    if ~finalpos
        if ~(length(prevstep) < 2)
            [newmaze, finalpos] = nextMove(newmaze, prevstep(end-1), prevstep(1:end-2));
        end
    end
elseif any(pos == [(r.*(c-1)):(r.*c)]);
    if maze(pos-1) == 'X' | maze(pos+1) == 'X' | maze(pos-r) == 'X'
        newmaze = maze;
        finalpos = true;
    elseif maze(pos-1) == ' ' %check up
        nextPos = pos-1;
        newmaze(nextPos) = 'o';
        [newmaze] = nextMove(newmaze,nextPos, prevstep);
    elseif maze(pos+1) == ' ' %check down
        nextPos = pos+1;
        newmaze(nextPos) = 'o';
        [newmaze] = nextMove(newmaze, nextPos, prevstep);
    elseif maze(pos-r) == ' ' %check left
        nextPos = pos-r;
        newmaze(nextPos) = 'o';
        [newmaze] = nextMove(newmaze, nextPos, prevstep);
    elseif maze(pos-1) == 'X' | maze(pos+1) == 'X' | maze(pos-r) == 'X'
        finalpos = true;
    else
        newmaze(pos) = '#';
    end
    if ~finalpos;
        if ~(length(prevstep) < 2)
            [newmaze, finalpos] = nextMove(newmaze, prevstep(end-1), prevstep(1:end-2));
        end
    end
else
    if maze(pos-1) == 'X' | maze(pos+1) == 'X' | maze(pos-r) == 'X' | maze(pos+r) == 'X'
        newmaze = maze;
        finalpos = true;
    elseif maze(pos-1) == ' ' %check up
        nextPos = pos-1;
        newmaze(nextPos) = 'o';
        [newmaze,finalpos] = nextMove(newmaze,nextPos,prevstep);
    elseif maze(pos+1) == ' ' %check down
        nextPos = pos+1;
        newmaze(nextPos) = 'o';
        [newmaze,finalpos] = nextMove(newmaze, nextPos, prevstep);
    elseif maze(pos-r) == ' ' %check left
        nextPos = pos-r;
        newmaze(nextPos) = 'o';
        [newmaze, finalpos] = nextMove(newmaze, nextPos, prevstep);
    elseif maze(pos+r) == ' ' %check right
        nextPos = pos+r;
        newmaze(nextPos) = 'o';
        [newmaze, finalpos] = nextMove(newmaze, nextPos, prevstep);
    else
        newmaze(pos) = '#';
    end
    if ~finalpos
        if ~(length(prevstep) < 2)
            [newmaze, finalpos] = nextMove(newmaze, prevstep(end-1), prevstep(1:end-2));
        end
    end
end
end
