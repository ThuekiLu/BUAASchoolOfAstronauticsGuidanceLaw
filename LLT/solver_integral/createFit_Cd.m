function [fitresult_Cd, gof] = createFit_Cd(x, y, Z2)
%CREATEFIT(X,Y,Z2)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : x
%      Y Input : y
%      Z Output: Z2
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 28-Sep-2022 15:48:26 自动生成


%% Fit: 'untitled fit 1'.
[xData, yData, zData] = prepareSurfaceData( x, y, Z2 );

% Set up fittype and options.
ft = 'biharmonicinterp';

% Fit model to data.
[fitresult_Cd, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );




