// Set default static loading text for each charts
export const canvasLoading = (canvases) => {
  $.each( canvases, function(index, canvas) {
    var ctx = canvas.getContext("2d");
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillStyle = '#888';
    ctx.font = "16px normal 'Helvetica Nueue'";
    ctx.fillText(gon.no_data, canvas.width / 2, canvas.height / 2);
    ctx.restore();
  });
}
