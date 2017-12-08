close all
clear all

%% INITIALIZE TIMERS

% create timers for measuring time
global mytimers
%mytimers = Timers();
mytimers = Timers('buffer');

% start to measure whole application run
mytimers.start('all');

%% EXAMPLE - evaluate quadratic function on a grid

% create meshgrid
disp('-> creating mesh')
mytimers.start('meshgrid');
 h = 5e-2;
 [X,Y] = meshgrid(0:h:10,0:h:10);
mytimers.stop('meshgrid');

% compute function value in every grid point
disp('-> computing function values')
A = [3 1; 1 2];
b = [19;13];
mytimers.start('func_eval');
 F = zeros(size(X));
 for i=1:size(F,1)
    for j=1:size(F,2)
        XX = [X(i,j);Y(i,j)];
        F(i,j) = 0.5*dot(A*XX,XX) - dot(b,XX);
    end
 end
mytimers.stop('func_eval');

% plot the result
disp('-> plotting results')
mytimers.start('plot');
 figure
 hold on
 mesh(X,Y,F)
 hold off
mytimers.stop('plot');

% stop to measure whole application run
mytimers.stop('all');

%% PRINT MEASURED TIMES
mytimers.print();

%% TEST .GET METHODS
mytimers.get_value('all') % get value of timer with name 'all'

mytimers.get_values() % get vector with values
mytimers.get_names() % get cell of all names
mytimers.get_types() % get type of this timer

mytimers.isrunning('all') % check if timer with name 'plot' is running
