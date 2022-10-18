function [fitresult_Cl, gof] = createFit_Cl(x, y, z1)
%CREATEFIT(X,Y,Z1)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : x
%      Y Input : y
%      Z Output: z1
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 28-Sep-2022 15:37:24 自动生成


%% Fit: 'untitled fit 1'.
[xData, yData, zData] = prepareSurfaceData( x, y, z1 );

% Set up fittype and options.
ft = 'biharmonicinterp';

% Fit model to data.
[fitresult_Cl, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );



