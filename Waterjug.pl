% --- Define capacities ---
capacity(4,3).

% --- Goal state ---
goal(state(2,_)).

% --- Move rules ---

% Fill 4L jug
move(state(X,Y), state(4,Y)) :-
    X < 4.

% Fill 3L jug
move(state(X,Y), state(X,3)) :-
    Y < 3.

% Empty 4L jug
move(state(X,Y), state(0,Y)) :-
    X > 0.

% Empty 3L jug
move(state(X,Y), state(X,0)) :-
    Y > 0.

% Pour 4L -> 3L
move(state(X,Y), state(X1,Y1)) :-
    X > 0,
    Y < 3,
    Transfer is min(X, 3-Y),
    X1 is X - Transfer,
    Y1 is Y + Transfer.

% Pour 3L -> 4L
move(state(X,Y), state(X1,Y1)) :-
    Y > 0,
    X < 4,
    Transfer is min(Y, 4-X),
    Y1 is Y - Transfer,
    X1 is X + Transfer.

% --- Depth First Search ---
dfs(State, _, [State]) :-
    goal(State).

dfs(State, Visited, [State|Path]) :-
    move(State, Next),
    \+ member(Next, Visited),
    dfs(Next, [Next|Visited], Path).

% --- Solve ---
solve(Path) :-
    dfs(state(0,0), [state(0,0)], Path).
