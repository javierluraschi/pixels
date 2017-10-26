HTMLWidgets.widget({
  name: "pixels",
  type: "output",
  factory: function(el, width, height) {
    var pixels = new Pixels();
    
    pixels.onChange(function(pixels) {
      if (typeof("Shiny") !== "undefined") {
        Shiny.onInputChange("pixels", pixels);
      }
    });
    
    el.appendChild(pixels.getElement());
    
    return {
      renderValue: function(x) {
        pixels.init(x.pixels, x.gridX, x.gridY, x.width, x.height, x.brush, x.params);
      },
      resize: function(width, heigh) {
      }
    };
  }
});
