function [model] = plot_pictures(model)

%% Training
fh1 = figure(1);
fh1.WindowState = 'maximized';
subplot(1,3,1)
imagesc(model.Iapp_learn);
colorbar; axis image;
axis off;
set(gca,'FontSize',20,'fontWeight','bold');
title('Sample');
colormap(flipud(gray(255)));

subplot(1,3,2)
imagesc(model.Freq(:,:,1));
colorbar; axis image;
axis off;
set(gca,'FontSize',20,'fontWeight','bold');
title('Neurons');

subplot(1,3,3)
imagesc(model.Ca);
colorbar; axis image;
axis off;
set(gca,'FontSize',20,'fontWeight','bold');
title('Astrocytes');

%% Test
fh2 = figure(2);
fh2.WindowState = 'maximized';
subplot(2,4,1)
imagesc(shiftdim(model.Iapp_test(1,:,:)));
colorbar; axis image;
axis off;
set(gca,'FontSize',20,'fontWeight','bold');
title('Test 1 Cue');
colormap(flipud(gray(255)));

subplot(2,4,2)
imagesc(model.Freq(:,:,2));
colorbar; axis image;
axis off;
set(gca,'FontSize',20,'fontWeight','bold');
title('Test 1 Neurons');

subplot (2,4,3)
imagesc(shiftdim(model.Iapp_test(2,:,:)));
colorbar; axis image;
axis off;
set(gca,'FontSize',20,'fontWeight','bold');
title('Test 2 Cue');

subplot (2,4,4)
imagesc(model.Freq(:,:,3));
colorbar; axis image;
axis off;
set(gca,'FontSize',20,'fontWeight','bold');
title('Test 2 Neurons');

subplot(2,4,5)
imagesc(shiftdim(model.Iapp_test(3,:,:)));
colorbar; axis image;
axis off;
set(gca,'FontSize',20,'fontWeight','bold');
title('Test 3 Cue');

subplot (2,4,6)
imagesc(model.Freq(:,:,4));
colorbar; axis image;
axis off;
set(gca,'FontSize',20,'fontWeight','bold');
title('Test 3 Neurons');

subplot (2,4,7)
imagesc(shiftdim(model.Iapp_test(4,:,:)));
colorbar; axis image;
axis off;
set(gca,'FontSize',20,'fontWeight','bold');
title('Test 4 Cue');

subplot (2,4,8)
imagesc(model.Freq(:,:,5));
colorbar; axis image;
axis off;
set(gca,'FontSize',20,'fontWeight','bold');
title('Test 4 Neurons');

end