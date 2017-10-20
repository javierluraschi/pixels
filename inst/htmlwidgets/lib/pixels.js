function Pixels(gridX, gridY, width, height, brush) {
  var canvas = document.createElement("canvas");

  canvas.width = width;
  canvas.height = height;
  canvas.style.width = Math.floor(width / 2) + "px";
  canvas.style.height = Math.floor(height / 2) + "px";

  context = canvas.getContext("2d");

  context.fillStyle = "#555";

  var deltaX = (width - 2) / gridX;
  var deltaY = (height - 2) / gridY;

  var mouseIsDown = false;
  var onChangeCallback;

  var initArray = function(rows, cols) {
    var a = [];
    for (var r = 0; r < rows; r++) {
      a[r] = [];
      for (var c = 0; c < cols; c++) {
        a[r][c] = false;
      }
    }
    return a;
  };

  var pixels = initArray(gridY, gridX);

  var drawGrid = function() {
    context.strokeStyle = "#DDD";
    context.lineWidth = 1;

    for (var posX = 1; posX < width; posX += deltaX) {
      context.moveTo(posX, 1);
      context.lineTo(posX, height);
    }

    for (var posY = 1; posY < height; posY += deltaY) {
      context.moveTo(1, posY);
      context.lineTo(width, posY);
    }

    context.stroke();
  };

  var redrawCanvas = function() {
    context.clearRect(0, 0, context.canvas.width, context.canvas.height);
    drawGrid();

    for (var r = 0; r < gridY; r++)
      for (var c = 0; c < gridX; c++)
        if(pixels[r][c]) context.fillRect(1 + deltaX * c, 1 + deltaY * r, deltaX, deltaY);
  };

  var setPixelFromMouse = function(e, left, top) {
    var rect = canvas.getBoundingClientRect();
    var pixelX = Math.floor(1.0 * gridX * (e.clientX - rect.left) / (width / 2));
    var pixelY = Math.floor(1.0 * gridY * (e.clientY - rect.top) / (height / 2));

    var offsetY = Math.floor(brush.length / 2);
    for (var br = 0; br < brush.length; br++) {
      var offsetX = Math.floor(brush[br].length / 2);
      for (var bc = 0; bc < brush[br].length; bc++) {
        var r = pixelY - offsetY + br;
        var c = pixelX - offsetX + bc;
        
        if (r >= 0 && r < gridX && c >= 0 && c < gridY && brush[br][bc]) {
          pixels[r][c] = true;
        }
      }
    }
    
    pixels[Math.min(pixelY + 1, gridY - 1)][pixelX] = true;
    pixels[Math.max(0, pixelY - 1)][pixelX] = true;
    pixels[pixelY][Math.min(pixelX + 1, gridX - 1)] = true;
    pixels[pixelY][Math.max(0, pixelX - 1)] = true;
  };

  var canvasMouseDown = function(e) {
    setPixelFromMouse(e, this.offsetLeft, this.offsetTop);
    mouseIsDown = true;

    redrawCanvas();
  };

  var canvasMouseMove = function(e) {
    if (mouseIsDown) setPixelFromMouse(e, this.offsetLeft, this.offsetTop);
    redrawCanvas();
  };

  var canvasMouseUp = function(e) {
    mouseIsDown = false;
    if (onChangeCallback) onChangeCallback(pixels);
  };

  canvas.addEventListener("mousedown", canvasMouseDown, false);
  canvas.addEventListener("mousemove", canvasMouseMove, false);
  document.addEventListener("mouseup", canvasMouseUp, false);

  redrawCanvas();

  this.getElement = function() {
    return canvas;
  };

  this.getPixels = function() {
    return pixels;
  };
  
  this.onChange = function(callback) {
    onChangeCallback = callback;
  };
}