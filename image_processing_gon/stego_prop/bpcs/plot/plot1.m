clc, clear, close all
u = [0.1 0.2 0.3 0.4 0.5 0.6 0.7];
i = [12e-3 15e-3 20e-3 30e-3 50e-3 80e-3 100e-3]; plot(u, i, 'd--r', 'LineWidth', 2)
xlabel('emitter-base voltage U_{BE}, V') 
ylabel('base current I_B, A')
title('Base current vs emitter-base voltage of BJT') 
grid on
grid minor
set(gca, 'FontName', 'Purisa' , 'FontSize', 14)
% Purisa is only available for Linux
xlim([0 0.8])
ylim([0 110e-3])
%axis([0 0.8 0 110e-3])