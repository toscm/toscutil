library("testthat")

test_that("parse_pkgdown_categories works", {
    pkgdown_content <- c(
        "url: https://example.com",
        "reference:",
        "  - title: Base Extensions",
        "    desc: Extended versions of base R functions",
        "    contents: [has_keyword(\"base\")]",
        "  - title: Documentation",
        "    desc: Functions for documentation",
        "    contents: [has_keyword(\"doc\")]"
    )
    
    categories <- toscutil:::parse_pkgdown_categories(pkgdown_content)
    
    expect_true(length(categories) == 2)
    expect_equal(categories[[1]]$title, "Base Extensions")
    expect_equal(categories[[1]]$desc, "Extended versions of base R functions")
    expect_equal(categories[[1]]$keyword, "base")
    expect_equal(categories[[2]]$title, "Documentation")
    expect_equal(categories[[2]]$desc, "Functions for documentation")
    expect_equal(categories[[2]]$keyword, "doc")
})

test_that("update_reference_in_readme works", {
    # Create temporary files
    temp_dir <- tempdir()
    temp_readme <- file.path(temp_dir, "README_test.md")
    temp_pkgdown <- file.path(temp_dir, "_pkgdown_test.yml")
    
    # Create test README
    readme_content <- c(
        "# Test Package",
        "<!-- BEGIN_FUNCTION_REFERENCE -->",
        "<!-- END_FUNCTION_REFERENCE -->",
        "## End"
    )
    writeLines(readme_content, temp_readme)
    
    # Create test _pkgdown.yml
    pkgdown_content <- c(
        "reference:",
        "  - title: Base Extensions",
        "    desc: Extended versions of base R functions",
        "    contents: [has_keyword(\"base\")]"
    )
    writeLines(pkgdown_content, temp_pkgdown)
    
    # Test with tools package
    expect_message(
        update_reference_in_readme(
            readme_path = temp_readme,
            pkgdown_path = temp_pkgdown,
            pkg = "tools"
        ),
        "Successfully updated"
    )
    
    # Check that README was updated
    updated_readme <- readLines(temp_readme)
    expect_true(any(grepl("## Function Reference", updated_readme)))
    expect_true(any(grepl("BEGIN_FUNCTION_REFERENCE", updated_readme)))
    expect_true(any(grepl("END_FUNCTION_REFERENCE", updated_readme)))
    
    # Clean up
    unlink(temp_readme)
    unlink(temp_pkgdown)
})

test_that("update_reference_in_readme fails without markers", {
    temp_dir <- tempdir()
    temp_readme <- file.path(temp_dir, "README_no_markers.md")
    temp_pkgdown <- file.path(temp_dir, "_pkgdown_test.yml")
    
    # Create test README without markers
    readme_content <- c(
        "# Test Package",
        "## End"
    )
    writeLines(readme_content, temp_readme)
    
    # Create test _pkgdown.yml
    pkgdown_content <- c(
        "reference:",
        "  - title: Base Extensions",
        "    desc: Extended versions of base R functions",
        "    contents: [has_keyword(\"base\")]"
    )
    writeLines(pkgdown_content, temp_pkgdown)
    
    expect_error(
        update_reference_in_readme(
            readme_path = temp_readme,
            pkgdown_path = temp_pkgdown,
            pkg = "tools"
        ),
        "Could not find markers"
    )
    
    # Clean up
    unlink(temp_readme)
    unlink(temp_pkgdown)
})
