test_that("now_ms works", {
  now_str <- now_ms()
  expect_true(grepl("....-..-.. ..:..:..\\... .+", now_str))
})
