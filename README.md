# pMFexp
By :      Martin SZINTE<br/>
Projet :  pRFseqTest<br/>
With :    Vanessa Morita, Anna Montagnini & Guillaume Masson<br/>
Version:  1.0<br/>

## Version description
Experiment in which we first use a square full screen 4 directions (left/right/up/down) bar pass stimuli with an attention task to the bar in order to obtain pRF retinotopy of the occipital, parietal, frontal and subcortical structures.

## Acquisition sequences
* 2.0 mm isotropic<br/> 
* TR 1.2 seconds<br/>
* Multi-band 4<br/>
* 60 slices<br/>

## Experiment runner
* run the experiment using main/expLauncher.m

## MRI analysis
To define later

## Behavioral analysis
* get eye coordinates using stats/behav_analysis/extract_eyetraces.py
* get saccade parameters using stats/behav_analysis/extract_saccades.py
* plot eye traces per run using stats/behav_analysis/plot_eye_traces_run.py
* plot eye traces per saccade sequence using stats/behav_analysis/plot_eye_traces_sac_seq.py
* plot eye traces per trial using stats/behav_analysis/plot_eye_traces_trial.py
