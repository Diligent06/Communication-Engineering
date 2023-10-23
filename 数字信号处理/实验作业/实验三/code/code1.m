clear all; clc;
w = [-500:1:500]*pi/500;
%% x(n)=2*(0.8^n)[u(n)-u(n-20)]
n1 = 0:19;
x_n1 = 2*(0.8.^n1);
W1 = dtft(x_n1, n1, w);
figure; 
subplot(2, 2, 1); plot(w/pi, abs(W1)); xlabel('频率'); ylabel('幅度'); title('幅度部分');
subplot(2, 2, 2); plot(w/pi, angle(W1)); xlabel('频率'); ylabel('幅度'); title('相角部分');
subplot(2, 2, 3); plot(w/pi, real(W1)); xlabel('频率'); ylabel('幅度'); title('实部');
subplot(2, 2, 4); plot(w/pi, imag(W1)); xlabel('频率'); ylabel('幅度'); title('虚部');

%% x(n)=n(0.9)^n[u(n)-u(n-50)]
n2 = 0:49;
x_n2 = n2.*(0.9).^n2;
W2 = dtft(x_n2, n2, w);
figure;
subplot(2, 2, 1); plot(w/pi, abs(W2)); xlabel('频率'); ylabel('幅度'); title('幅度部分');
subplot(2, 2, 2); plot(w/pi, angle(W2)); xlabel('频率'); ylabel('幅度'); title('相角部分');
subplot(2, 2, 3); plot(w/pi, real(W2)); xlabel('频率'); ylabel('幅度'); title('实部');
subplot(2, 2, 4); plot(w/pi, imag(W2)); xlabel('频率'); ylabel('幅度'); title('虚部');

%% x(n)={4,3,2,1,2,3,4}
n3 = 0:6;
x_n3 = [4, 3, 2, 1, 2, 3, 4];
W3 = dtft(x_n3, n3, w);
figure;
subplot(2, 2, 1); plot(w/pi, abs(W3)); xlabel('频率'); ylabel('幅度'); title('幅度部分');
subplot(2, 2, 2); plot(w/pi, angle(W3)); xlabel('频率'); ylabel('幅度'); title('相角部分');
subplot(2, 2, 3); plot(w/pi, real(W3)); xlabel('频率'); ylabel('幅度'); title('实部');
subplot(2, 2, 4); plot(w/pi, imag(W3)); xlabel('频率'); ylabel('幅度'); title('虚部');

%% x(n)={4,3,2,1,1,2,3,4}
n4 = 0:7;
x_n4 = [4, 3, 2, 1, 1, 2, 3, 4];
W4 = dtft(x_n4, n4, w);
figure;
subplot(2, 2, 1); plot(w/pi, abs(W4)); xlabel('频率'); ylabel('幅度'); title('幅度部分');
subplot(2, 2, 2); plot(w/pi, angle(W4)); xlabel('频率'); ylabel('幅度'); title('相角部分');
subplot(2, 2, 3); plot(w/pi, real(W4)); xlabel('频率'); ylabel('幅度'); title('实部');
subplot(2, 2, 4); plot(w/pi, imag(W4)); xlabel('频率'); ylabel('幅度'); title('虚部');

%% x(n)={4,3,2,1,0,-1,-2,-3,-4}
n5 = 0:8;
x_n5 = [4, 3, 2, 1, 0, -1, -2, -3, -4];
W5 = dtft(x_n5, n5, w);
figure;
subplot(2, 2, 1); plot(w/pi, abs(W5)); xlabel('频率'); ylabel('幅度'); title('幅度部分');
subplot(2, 2, 2); plot(w/pi, angle(W5)); xlabel('频率'); ylabel('幅度'); title('相角部分');
subplot(2, 2, 3); plot(w/pi, real(W5)); xlabel('频率'); ylabel('幅度'); title('实部');
subplot(2, 2, 4); plot(w/pi, imag(W5)); xlabel('频率'); ylabel('幅度'); title('虚部');

%% x(n)={4,3,2,1,-1,-2,-3,-4}
n6 = 0:7;
x_n6 = [4, 3, 2, 1, -1, -2, -3, -4];
W6 = dtft(x_n6, n6, w);
figure;
subplot(2, 2, 1); plot(w/pi, abs(W6)); xlabel('频率'); ylabel('幅度'); title('幅度部分');
subplot(2, 2, 2); plot(w/pi, angle(W6)); xlabel('频率'); ylabel('幅度'); title('相角部分');
subplot(2, 2, 3); plot(w/pi, real(W6)); xlabel('频率'); ylabel('幅度'); title('实部');
subplot(2, 2, 4); plot(w/pi, imag(W6)); xlabel('频率'); ylabel('幅度'); title('虚部');