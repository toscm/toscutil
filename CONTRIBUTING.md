To contribute to this package, you should follow the below steps:

1.  Create a issue at [github.com/toscm/toscutil/issues](https://github.com/toscm/toscutil/issues) describing the problem or feature you want to work on.
2.  Wait until the issue is approved by a package maintainer.
3.  Create a fork of the repository at [github.com/toscm/toscutil](https://github.com/toscm/toscutil)
4.  Make your edits as described in section [Making Edits](#making-edits)
5.  Create a pull request at [github.com/toscm/toscutil/pulls](https://github.com/toscm/toscutil/pulls)

# Making Edits

Things you can update, are:

1.  Function code in folder [R](R)
2.  Function documentation in folder [R](R)
3.  Package documentation in folder `vignettes`
4.  Test cases in folder [tests](tests)
5.  Dependencies in file [DESCRIPTION](DESCRIPTION)
6.  Authors in file [DESCRIPTION](DESCRIPTION)

Whenever you update any of those things, you should run the below commands to check that everything is still working as expected:

```R
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

# Tagging and GitHub Releases

Every version bump (a change to the `Version` field in [DESCRIPTION](DESCRIPTION))
should be marked with a git tag and an accompanying GitHub release. This is done
manually after the version bump has been merged into `master` — there is **no**
GitHub Action that creates tags or releases automatically (the workflows in
[.github/workflows](.github/workflows) only run R CMD check, test coverage and
pkgdown).

For a version `X.Y.Z`:

1.  Create an annotated tag on the `master` commit that bumped the version and
    push it (omit the commit to tag the current `HEAD`):

    ```sh
    git tag -a vX.Y.Z <commit> -m "vX.Y.Z"
    git push origin vX.Y.Z
    ```

2.  Create a GitHub release from that tag, using the version's section from
    [NEWS.md](NEWS.md) as the release notes:

    ```sh
    gh release create vX.Y.Z --title "vX.Y.Z" --notes-file <news-section.md>
    ```

    The newest version (highest semantic version) is automatically marked as
    "Latest".

Tag and release names always use the `vX.Y.Z` form, matching the `Version` field
in DESCRIPTION.

# Releasing to CRAN

Whenever a package maintainer wants to release a new version of the package to CRAN, they should:

1.  Check whether the [release requirements](https://r-pkgs.org/release.html#sec-release-initial) are fulfilled
2.  Use the following commands to do a final check of the package and release it to CRAN

```R
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
