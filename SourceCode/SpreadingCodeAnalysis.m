PNCode = m_squence([0 1 1 0 1 1]);
plot(app.PN, PNCode);
tcf('D:\Matlab_file\huangningjie\pn31_cycle_signal_seq.mat');
cycle = reprocessed_power_spectrum('D:\Matlab_file\huangningjie\pn31_cycle_signal_seq.mat');
plot(app.SpreadingCodePlotAxe, cycle);
xlim(app.SpreadingCodePlotAxe, ([0, inf]));
ylim(app.SpreadingCodePlotAxe, ([-1, -0.9]));
