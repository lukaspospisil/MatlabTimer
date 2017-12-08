classdef Timer < handle
    % Timer single node of Timers
    %
    % Lukas Pospisil (USI Lugano)
    % published under MIT Licence, 2017
    %
    
    properties(SetAccess = private)
        name   % name of timer (for futher reference)
        value  % sum of times between start() and stop()
        type   % type of timer ('additive' / 'buffer')
    end
    
    properties(Access = private)
        tStart = 0      % tic start
        running = false % is the timer running or not?
    end
    
    methods
        function timer = Timer(name,varargin)
            % constructor - create timer with name
            timer.name = name;
            
            % set the type
            if nargin == 1
                type = 'additive';
            else
                type = varargin{1};
                if ~strcmp(type,'additive') && ~strcmp(type,'buffer')
                    disp('Warning: Timer.type can be only additive or buffer')
                    type = 'additive';
                end
            end
            timer.type = type;

            % set initial values
            if strcmp(type,'additive')
                timer.value = 0;
            end
            if strcmp(type,'buffer')
                timer.value = [];
            end
        end
        
        function start(mytimer)
            % start to measure time
            if mytimer.running % maybe this time is already running
                disp(['Warning: Timer ' mytimer.name ' is already running'])
            else
                mytimer.tStart = tic;
                mytimer.running = true;
            end
        end
        
        function stop(mytimer)
            % stop to measure time and store result
            if mytimer.running
                if strcmp(mytimer.type,'additive')
                    mytimer.value = mytimer.value + toc(mytimer.tStart);
                end
                if strcmp(mytimer.type,'buffer')
                    mytimer.value(end+1) = toc(mytimer.tStart);
                end
                mytimer.running = false;
            else
                disp(['Warning: Timer ' mytimer.name ' is not running'])
            end
        end
        
        function out = ismyname(mytimer,new_name)
            % check if input is the name of this timer
            if issame(new_name,mytimer.name)
                out = true;
            else
                out = false;
            end
        end
        
        function out = isrunning(mytimer)
            % check if the timer is running or not
            out = mytimer.running;
        end
        
        function out = get_value(mytimer)
            % return value of timer
            out = mytimer.value;
        end
        
        function out = get_name(mytimer)
            % return name of timer
            out = mytimer.name;
        end
        
        function out = get_type(mytimer)
            % return type of timer
            out = mytimer.type;
        end
        
        function print(mytimer)
            % print values of this timer
            if mytimer.isrunning()
                mymark = '*'; % if Timer is still running, then add this mark
            else
                mymark = '';
            end
            
            if strcmp(mytimer.type,'additive')
                disp(['  - ' mytimer.name mymark ': ' num2str(mytimer.value) 's '])
            end
            
            if strcmp(mytimer.type,'buffer')
                mystr = '[';
                for i=1:length(mytimer.value)
                    mystr = [mystr num2str(mytimer.value(i))];
                    if i<length(mytimer.value)
                        mystr = [mystr ','];
                    end
                end
                mystr = [mystr ']'];
                disp(['  - ' mytimer.name mymark ': ' mystr])
            end
        end
    end
    
end

