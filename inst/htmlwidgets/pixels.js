HTMLWidgets.widget({
  name: "pixels",
  type: "output",
  factory: function(el, width, height) {
    return {
      renderValue: function(x) {
        var pixels = new Pixels(x.pixels, x.gridX, x.gridY, x.width, x.height, x.brush, x.params);
        
        pixels.onChange(function(pixels) {
          if (typeof("Shiny") !== "undefined") {
            Shiny.onInputChange("pixels", pixels);
          }
        });
        
        el.appendChild(pixels.getElement());
      },
      resize: function(width, heigh) {
      }
    };
  }
});
