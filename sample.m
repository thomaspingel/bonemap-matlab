[las] = lasread('in/002276.las')

%% SMRF Settings
c = 1;
s = .2;
w = 16;
et = .45;
es = 1.2;

[Zmin R] = createDSM(las.X,las.Y,las.Z,'c',c,'type','min');
[Zmax R] = createDSM(las.X,las.Y,las.Z,'c',c,'type','max');

%% Run filter
[Zground R groundFlag] = smrf(las.X,las.Y,las.Z,'c',c,'s',s,'w',w,'et',et,'es',es);

%% Create bonemaps
Bmin = bonemap(Zmin,'c',c);
Bmax = bonemap(Zmax,'c',c);
Bground = bonemap(Zground,'c',c);

%% Visualize
subplot(131); image(Bmin); axis image
subplot(132); image(Bmax); axis image
subplot(133); image(Bground); axis image

%% Write out
imwrite(Bmin,'out/Bmin.png')
imwrite(Bmax,'out/Bmax.png')
imwrite(Bground,'out/Bground.png')
worldfilewrite(R,'out/Bmin.pgw')
worldfilewrite(R,'out/Bmax.pgw');
worldfilewrite(R,'out/Bground.pgw');