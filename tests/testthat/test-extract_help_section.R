library("testthat")

test_that("check_pkg_docs works", {
    db <- tools::Rd_db("codetools")
    dbelem <- db$checkUsage.Rd
    title <- extract_help_section(dbelem, "title")
    name <- extract_help_section(dbelem, "name")
    alias <- extract_help_section(dbelem, "alias")
    allsections <- extract_help_section(dbelem)
    expect_equal(title, "Check R Code for Possible Problems")
    expect_equal(name, "checkUsage")
    expect_equal(alias, c("checkUsage", "checkUsageEnv", "checkUsagePackage"))
    expect_equal(lengths(allsections), c(title = 1L, name = 1L, alias = 3L, keyword = 1L, description = 1L, usage = 1L, arguments = 1L, details = 1L, author = 1L, examples = 1L))
})
