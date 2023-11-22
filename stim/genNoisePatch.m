function noiseMatFiltNorm = genNoisePatch(const, kappa)
% ----------------------------------------------------------------------
% noiseMatFiltNorm = genNoisePatch(const, kappa)
% ----------------------------------------------------------------------
% Goal of the function :
% Create noise patches
% ----------------------------------------------------------------------
% Input(s) :
% const : struct containing constant configurations
% kappa : dispersion parameter of the von misses filter
% ----------------------------------------------------------------------
% Output(s):
% noiseMatFiltNorm: patch
% ----------------------------------------------------------------------
% Function created by Martin SZINTE (martin.szinte@gmail.com)
% ----------------------------------------------------------------------

% define original noise patch size
noiseDim = const.native_noise_dim;                                          % starting size of the patch

% create pink noise stimuli
if strcmp(const.noise_color, 'pink')                                        % pink 1/f noise
    colVal = 1;                                                                                  
elseif strcmp(const.noise_color, 'brownian')                                % brownian 2/f noise
    colVal = 2;
elseif strcmp(const.noise_color, 'white')                                   % white 0/f noise
    colVal = 0;
end

freqD1 = repmat([(0:floor(noiseDim(1) / 2)) - ...                           % set of frequencies along the first dimension
    (ceil(noiseDim(1) / 2) - 1:-1:1)]' / noiseDim(1), 1, noiseDim(2));
freqD2 = repmat([(0:floor(noiseDim(2) / 2)) - ...                           % set of frequencies along the second dimension.
    (ceil(noiseDim(2) / 2) - 1:-1:1)] / noiseDim(2), noiseDim(1), 1);
pSpect = (freqD1.^2 + freqD2.^2).^(-colVal/2);                              % power spectrum
pSpect(pSpect==inf) = 0;                                                    % set any infinities to zero
phi = rand(noiseDim);                                                       % generate a grid of random phase shifts
noiseMat = real(ifft2(pSpect.^0.5 .* (cos(2*pi*phi) + 1i * ...              % real component of inverse Fourier transform to obtain the the spatial pattern
    sin(2 * pi * phi))));
fftNoiseMat = fftshift(fft2(noiseMat - mean(noiseMat(:)), noiseDim(1), ...  % fast fourier transform
    noiseDim(2)));

% Generate von misses distribution
alphaVonMisses = linspace(0, 2 * pi, size(fftNoiseMat, 1))';                % alpha angle of von misses
vonMisses = (1 / (2* pi * besseli(0, kappa))) * exp(kappa * ...             % von misses formula
    cos(alphaVonMisses + pi));                      
vonMisses = repmat(vonMisses, 1, size(fftNoiseMat, 2));                     % repeat the matrix over the other dimension

% Convolve both and normalize
noiseMatFilt = real(ifft2(ifftshift(fftNoiseMat .* vonMisses)));            % convolution
noiseMatFiltNorm = (noiseMatFilt - min(noiseMatFilt(:))) / ...              % normalization
    (max(noiseMatFilt(:)) - min(noiseMatFilt(:)));

end