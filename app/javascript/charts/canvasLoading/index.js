// Set default static loading text for each charts
export const canvasLoading = (canvases) => {
  let ctx;

  $.each( canvases, function(index, canvas) {
    canvas = updateCanvas(canvas);
    ctx = styleContext(canvas);
    ctx.fillText(gon.no_data, canvas.width / 2, canvas.height / 2);
  });
}

const updateCanvas = (canvas) => {
  let canvasWidth = 492, canvasHeight = 246;
  canvas.width = canvasWidth
  canvas.height = canvasHeight
  canvas.style.width = canvas.width;
  canvas.style.height = canvas.height;
  return canvas;
}

const styleContext = (canvas) => {
  let ctx = canvas.getContext("2d");
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillStyle = '#888';
  ctx.font = "16px 'Helvetica Nueue'";
  return ctx;
}
