%% General experimenter launcher
%  =============================
% By: Martin SZINTE
% Projet: pRFexp for MotConf
% With: Can OLUK, Pascal MAMASSIAN & Guillaume MASSON

% Version description
% ===================
% Experiment in which we first use a square full screen 4 directions 
% (left/right/up/down) bar pass stimuli with an attention task to the bar 
% in order to obtain pRF retinotopy of the occipital, parietal, frontal 
% and subcortical structures.

% To do
% -----

% First settings
Screen('CloseAll'); clear all; clear mex; clear functions; close all; ...
    home; AssertOpenGL;

% General settings
const.expName = 'pRF';          % experiment name
const.expStart = 1;             % Start of a recording exp (0 = NO, 1 = YES)
const.checkTrial = 0;           % Print trial conditions (0 = NO, 1 = YES)
const.genStimuli = 0;           % Generate the stimuli (0 = NO, 1 = YES)
const.drawStimuli = 0;          % Draw stimuli generated (0 = NO, 1 = YES)
const.mkVideo = 0;              % Make a video of a run

% External controls
const.tracker = 1;              % run with eye tracker (0 = NO, 1 = YES)
const.comp = 1;                 % run in which computer (1 = MRI; 2 = Can laptop; 3 = Diplay++)
const.scanner = 1;              % run in MRI scanner (0 = NO, 1 = YES)
const.scannerTest = 0;          % fake scanner trigger (0 = NO, 1 = YES)
const.training = 0;             % training session (0 = NO, 1 = YES)
const.run_total = 5;            % number of run in total

% Desired screen setting
const.desiredFD = 120;          % Desired refresh rate
const.desiredRes = [1920, 1080];% Desired resolution

% Path
dir = which('expLauncher');
cd(dir(1:end-18));

% Add Matlab path
addpath('config', 'main', 'conversion', 'eyeTracking', 'instructions',...
    'trials', 'stim');

% Subject configuration
const = sbjConfig(const);

% Main run
main(const);