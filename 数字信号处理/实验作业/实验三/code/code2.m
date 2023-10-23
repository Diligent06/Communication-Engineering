clear all; clc;
w = [-500:1:500]*4*pi/1000;
%% x(n)=(0.9exp(jpi/3))^n
n1 = 0:10;
x_n1 = (0.9*exp(j*pi/3)).^n1;
W1 = dtft(x_n1, n1, w);
figure;
subplot(2, 2, 1); plot(w/pi, abs(W1)); xlabel('频率'); ylabel('幅度'); title('幅度部分');
subplot(2, 2, 2); plot(w/pi, angle(W1)); xlabel('频率'); ylabel('幅度'); title('相角部分');
subplot(2, 2, 3); plot(w/pi, real(W1)); xlabel('频率'); ylabel('幅度'); title('实部');
subplot(2, 2, 4); plot(w/pi, imag(W1)); xlabel('频率'); ylabel('幅度'); title('虚部');

%% x(n)=(-0.9)^n
n2 = -5:1:5;
x_n2 = (-0.9).^n2;
W2 = dtft(x_n2, n2, w);
figure;
subplot(2, 2, 1); plot(w/pi, abs(W2)); xlabel('频率'); ylabel('幅度'); title('幅度部分');
subplot(2, 2, 2); plot(w/pi, angle(W2)); xlabel('频率'); ylabel('幅度'); title('相角部分');
subplot(2, 2, 3); plot(w/pi, real(W2)); xlabel('频率'); ylabel('幅度'); title('实部');
subplot(2, 2, 4); plot(w/pi, imag(W2)); xlabel('频率'); ylabel('幅度'); title('虚部');