Tools for working with Pixels in R
================

This package provides an `htmlwidget` and `shinywidget` to render and draw pixels with ease.

To draw pixels run `get_pixels()` which will start a [Shiny Gadget](https://shiny.rstudio.com/articles/gadgets.html) to retrieve an array of numeric values representing each pixel in the image:

``` r
library(pixels)
get_pixels()
```

<img src="tools/readme/get_pixels.gif" width=364 />

To display pixels, use `show_pixels()` with a row-first vector as follows:

``` r
show_pixels(
  round(runif(400, 0, 1)),
  grid = c(40, 10),
  size = c(800, 200),
  params = list(fill = list(color = "#FF3388"))
)
```

<img src="tools/readme/show_pixels.png" width=364 />
