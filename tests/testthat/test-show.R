context("show")

test_that("test_show() works", {
  widget <- pixels::show_pixels(
    round(runif(400, 0, 1)),
    grid = c(40, 10),
    size = c(800, 200),
    params = list(fill = list(color = "#FF3388"))
  )
  
  expect_true("htmlwidget" %in% class(widget))
})