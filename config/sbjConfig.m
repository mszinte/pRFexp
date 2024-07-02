function const = sbjConfig(const)
% ----------------------------------------------------------------------
% const = sbjConfig(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Define subject configurations (initials, gender...) following BIDS
% data structure standards.
% ----------------------------------------------------------------------
% Input(s) :
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Output(s):
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Function created by Martin SZINTE (martin.szinte@gmail.com)
% ----------------------------------------------------------------------

% Define participant
if const.expStart
    const.sjctNum = input(sprintf('\n\tParticipant number: '));
    if isempty(const.sjctNum)
        error('Incorrect participant number');
    end
    if const.sjctNum > 9
        const.sjct = sprintf('sub-%i',const.sjctNum);
    else
        const.sjct = sprintf('sub-0%i',const.sjctNum);
    end
end

% Define session
const.sesNum = input(sprintf('\n\tSession number: '));
if const.sesNum > 9
    const.session = sprintf('ses-%i',const.sesNum);
else
    const.session = sprintf('ses-0%i',const.sesNum);
end

% Define run
const.runNum = input(sprintf('\n\tRun number: '));
if isempty(const.runNum)
    error('Incorrect run number');
end

if const.runNum > 9
    const.run = sprintf('run-%i',const.runNum);
else
    const.run = sprintf('run-0%i',const.runNum);
end

% Define main modality
if const.scanner == 1
    const.modality = 'func';
else
    const.modality = 'beh';
end

% Define task
%const.task = const.expName;
const.task_num = input(sprintf('\n\tTask: (1:prf_7T,2:prf_anyso,3:prf_occl_patch,4:prf_occl_grey,5:prf_strabism): '));

switch const.task_num
    case 1
        const.task = 'prf_7T';
    case 2
        const.task = 'prf_anyso';
    case 3
        const.task = 'prf_occl_patch';
    case 4
        const.task = 'prf_occl_grey';
    otherwise
        const.task = 'prf_strabism';
end 

fprintf(1,'\n\tTask: %s\n',const.task);

% Define recording eye
const.recEye = 1;

% Debug mode
if ~const.expStart
    const.sjct = 'sub-0X';
    const.session = 'ses-0X';
    const.run = 'run-0X';
    const.modality = 'beh';
    const.recEye = 1;
end

% training
if const.training
    const.task = sprintf('%sTraining',const.task);
end
end