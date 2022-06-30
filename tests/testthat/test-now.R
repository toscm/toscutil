test_that("now_ms works", {
  now_str <- now()
  expect_true(grepl("....-..-.. ..:..:.. .+", now_str))
})
