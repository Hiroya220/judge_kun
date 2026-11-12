%% マップ画像を鮮鋭化した上でHSV化し、分析

I = imread('map1.png');
Ish = imsharpen(I);
Ihsv = rgb2hsv(Ish);
imtool(Ihsv); % ここで読み取った値をもとに下のしきい値を決定した

%% 自分のチーム（青）の二値画像の作成

th1A = 0.64; th2A = 0.7; th3A = 0.84; th4A = 0.99;
key_A = (Ihsv(:,:,1) > th1A) & (Ihsv(:,:,1) < th2A) & (Ihsv(:,:,3) > th3A) & (Ihsv(:,:,3) < th4A);
figure, imshow(key_A)

%% 相手のチーム（黄緑）の二値画像の作成

th1B = 0.16; th2B = 0.19; thSBmin = 0.93; thSBmax = 1.07; th3B = 0.83; th4B = 1;
key_B = (Ihsv(:,:,1) > th1B) & (Ihsv(:,:,1) < th2B) & (Ihsv(:,:,2) > thSBmin) & (Ihsv(:,:,1) < thSBmax) & (Ihsv(:,:,3) > th3B) & (Ihsv(:,:,3) < th4B);
figure, imshow(key_B)

%% それぞれの画像のピクセル数を計算し、その値をもとに勝敗をコマンドウィンドウに表示

area_A = sum(key_A(:));
area_B = sum(key_B(:));

fprintf('\n');
disp(['自分のチームのピクセル数：', num2str(area_A)]);
disp(['相手のチームのピクセル数：', num2str(area_B)]);
fprintf('\n');

if area_A > area_B
    disp('WIN!');
elseif area_B > area_A
    disp('LOSE...');
else
    disp('draw!?');
end
fprintf('\n');