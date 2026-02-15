# Making Edits

To contribute to this package, you should follow the below steps:

1.  Create a issue at
    [github.com/toscm/toscutil/issues](https://github.com/toscm/toscutil/issues)
    describing the problem or feature you want to work on.
2.  Wait until the issue is approved by a package maintainer.
3.  Create a fork of the repository at
    [github.com/toscm/toscutil](https://github.com/toscm/toscutil)
4.  Make your edits as described in section [Making
    Edits](#making-edits)
5.  Create a pull request at
    [github.com/toscm/toscutil/pulls](https://github.com/toscm/toscutil/pulls)

Things you can update, are:

1.  Function code in folder [R](https://toscm.github.io/toscutil/R)
2.  Function documentation in folder
    [R](https://toscm.github.io/toscutil/R)
3.  Package documentation in folder `vignettes`
4.  Test cases in folder [tests](https://toscm.github.io/toscutil/tests)
5.  Dependencies in file
    [DESCRIPTION](https://toscm.github.io/toscutil/DESCRIPTION)
6.  Authors in file
    [DESCRIPTION](https://toscm.github.io/toscutil/DESCRIPTION)

Whenever you update any of those things, you should run the below
commands to check that everything is still working as expected:

``` r
devtools::document() # Build files in man folder
devtools::spell_check() # Check spelling (add false positives to inst/WORDLIST)
urlchecker::url_check() # Check URLs
devtools::test() # Execute tests from tests folder
devtools::install() # Install as required by next command
toscutil::check_pkg_docs() # Check function documentation for missing tags
devtools::check() # Check package formalities
pkgdown::build_site() # Build website in docs folder
```

After doing these steps, you can push your changes to Github.

# Releasing to CRAN

Whenever a package maintainer wants to release a new version of the
package to CRAN, they should:

1.  Check whether the [release
    requirements](https://r-pkgs.org/release.html#sec-release-initial)
    are fulfilled
2.  Use the following commands to do a final check of the package and
    release it to CRAN

``` r
# Check spelling and URLs. False positive findings of spell check should be
# added to inst/WORDLIST.
devtools::spell_check()
urlchecker::url_check()

# Slower, but more realistic tests than devtools::check()
rcmdcheck::rcmdcheck(args = c("--no-manual", "--as-cran"), build_args = ("--no-manual"), error_on = ("warning"), check_dir = "../toscutil-RCMDcheck")
devtools::check(remote = TRUE, manual = TRUE, run_dont_test = TRUE)

# Check reverse dependencies. For details see:
# https://r-pkgs.org/release.html#sec-release-revdep-checks
# If revdepcheck is broken, follow the instructions at
# https://cran.r-project.org/web/packages/policies.html
revdepcheck::revdep_check(num_workers = 8)

# Send your package to CRAN's builder services. You should receive an e-mail
# within about 30 minutes with a link to the check results. Checking with
# check_win_devel is required by CRAN policy and will (also) be done as part
# of CRAN's incoming checks.
devtools::check_win_oldrelease()
devtools::check_win_release()
devtools::check_win_devel()
devtools::check_mac_release()

# Use the following command to submit the package to CRAN or submit via the web
# interface available at https://cran.r-project.org/submit.html.
devtools::submit_cran()
```
