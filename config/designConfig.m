function expDes = designConfig(const)
% ----------------------------------------------------------------------
% expDes = designConfig(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Define experimental design
% ----------------------------------------------------------------------
% Input(s) :
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Output(s):
% expDes : struct containg experimental design
% ----------------------------------------------------------------------
% Function created by Martin SZINTE (martin.szinte@gmail.com)
% ----------------------------------------------------------------------

% Experimental random variables
% Var 1 : bar direction (9 modalities)
expDes.oneV = [1;3;5;7];
expDes.txt_var1 = {'180 deg', '225 deg', '270 deg', '315 deg', '0 deg',...
    '45 deg','90 deg','135 deg','none'};
% 01 = 180 deg
% 02 = 225 deg
% 03 = 270 deg
% 04 = 315 deg
% 05 = 0 deg
% 06 = 45 deg
% 07 = 90 deg
% 08 = 135 deg
% 09 = none

% Rand 1: stim orientation (2 modalities)
expDes.oneR = [1;2];
expDes.txt_rand1 = {'cw', 'ccw', 'none'};
% 01 = tilt cw
% 02 = tilt ccw
% 03 = none

% Rand 2: fixation position (5 modalities) 
expDes.twoR = [1;2;3;4;5];
expDes.txt_rand2 = {'center', 'up-left', 'up-right', 'down-left', 'down-right'};
% 01 = center, 02 = up-left, 03 = up-right, 04 = down-left, 05 = down-right


% Staircase
if const.runNum == 1
    % create staircase starting value
    expDes.stim_stair_val = const.stim_stair_val;
    expDes.cor_count_stim = 0;
    expDes.incor_count_stim = 0;
else
    % load staircase of previous blocks
    load(const.staircase_file);
    expDes.stim_stair_val = staircase.stim_stair_val;
    expDes.cor_count_stim = staircase.cor_count_stim;
    expDes.incor_count_stim = staircase.incor_count_stim;
end

%% Experimental configuration :
expDes.nb_var = 1;
expDes.nb_rand = 2;

% Fixation position of this run (same shuffled order across all runs of a subject)
expDes.fix_pos_run = expDes.twoR(randperm(numel(expDes.twoR)));
rand_rand2 = expDes.fix_pos_run(const.runNum);

t_trial = 0;
for t_bar_pass = 1:size(const.bar_dir_run, 2)
    rand_var1 = const.bar_dir_run(t_bar_pass);
    
    if rand_var1 == 9
        bar_pos_per_pass  = const.blk_step;
    else
        if rand_var1 == 1 || rand_var1 == 5
            bar_pos_per_pass = const.bar_step_hor;
        elseif rand_var1 == 3 || rand_var1 == 7
            bar_pos_per_pass = const.bar_step_ver;
        end
    end
    
    for bar_step = 1:bar_pos_per_pass
        rand_rand1 = expDes.oneR(randperm(numel(expDes.oneR), 1));

        % no bar
        if rand_var1 == 9
            rand_rand1 = 3;
        end
    
        t_trial = t_trial + 1;
        expDes.expMat(t_trial, :) = [NaN, NaN, const.runNum, t_trial, ...
            rand_rand2, rand_var1, t_bar_pass, bar_step, rand_rand1, NaN, NaN, NaN, ...
            NaN, NaN];
        
        % 01: trial onset
        % 02: trial duration
        % 03: run number
        % 04: trial number
        % 05: fixation position   % new
        % 06: bar direction
        % 07: bar pass period
        % 08: bar step
        % 09: stimulus orientation
        % 10: trial offset time
        % 11: stimulus noise staircase value
        % 12: reponse value (correct/incorrect)
        % 13: Probe time
        % 14: Reaction time
    end
end

expDes.nb_trials = size(expDes.expMat,1);


end