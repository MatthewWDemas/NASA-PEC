
matb_track.Run = categorical(matb_track.Run);

matb_sl = matb_track(matb_track.Run == 'SL',:);
matb_15k = matb_track(matb_track.Run == '15k',:);

s05_sl = matb_sl.S05(isfinite(matb_sl.S05(:,1)),:);
s05_15k = matb_15k.S05(isfinite(matb_15k.S05(:,1)),:);

plot(s05_sl, s05_15k)
hold off
plot(s05_15k)
Y_sl = fft(s05_sl);
[l, w] = size(s05_sl);
Fs = 1/5;

P2 = abs(Y/l);
P1 = P2(1:l/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(l/2))/l;

plot(f, P1)

Y_15k = fft(s05_15k);
[l, w] = size(s05_15k);
Fs = 1/5;

P2 = abs(Y_15k/l);
P1 = P2(1:l/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(l/2))/l;

plot(f, P1)

[lfft, wfft] = size(Y_15k);

plot(1:lfft, real(Y_15k), 1:lfft, imag(Y_15k))
ylim([-200 2000])
xlim([2 20])
legend('Location', 'best')

plot(1:lfft, abs(Y_sl), 1:lfft, abs(Y_15k))