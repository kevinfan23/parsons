function plotCompresssed(X_recovered, centroids)

  % Create a 4x4 array of sample data in the range of 0-255.
  % data = randi(255, 4, 4);
  % % Display it.
  % image(data);
  % Initialize a color map array of 256 colors.
  % colorMap = jet(256);
  % Apply the colormap and show the colorbar
  imagesc(X_recovered);
  colormap(centroids);
  colorbar;

end
