library('move2')

source("../../src/io/rds.R")

test_that("read move2", {
  actual <- readRdsInput(sourceFile = "data/fishers_new.rds")
  expect_true(mt_is_move2(actual))
})
