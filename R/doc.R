# RD Files #####

#' @export
#' @title Check Documented Functions in a Package
#' @description Lists all documented functions in a package and checks their documentation elements for potential issues. The following checks are performed:
#' 1. Title is present and doesn't start with regex "Function".
#' 2. Description is present and doesn't start with "This function".
#' 3. Value is present.
#' 4. Example is present.
#' @param pkg The package name. If NULL, the package name is inferred from the DESCRIPTION file in the current directory or any parent directory. If no DESCRIPTION file is found, the function stops with an error message.
#' @return Returns a dataframe with columns `title`, `description`, `value`, `examples` and rows corresponding to the documented functions in the package. Each cell contains a string describing the check result for the corresponding documentation element of that function.
#' @examples
#' df <- check_pkg_docs("tools")
#' try(df <- check_pkg_docs())
#' @keywords doc
check_pkg_docs <- function(pkg = NULL) {
    Y <- X <- get_pkg_docs(pkg)
    Y[, ] <- "ok"
    Y$class <- X$class
    Y$title[grepl("^Function", X$title, ignore.case = TRUE)] <- "Starts with 'Function'"
    Y$title[X$title == ""] <- "Missing"
    Y$description[grepl("^This function", X$description, ignore.case = TRUE)] <- "Starts with 'This function'"
    Y$description[X$description == ""] <- "Missing"
    Y$value[Y$class == "function" & X$value == ""] <- "Missing"
    Y$value[Y$class != "function" & X$format == ""] <- "Missing"
    Y$examples[X$examples == ""] <- "Missing"
    Y
}

#' @export
#' @title Get Documented Functions in a Package
#' @description Lists all documented functions in a package together with some of their documentation elements as raw text. Only works for installed packages.
#' @param pkg The package name. If NULL, the package name is inferred from the DESCRIPTION file in the current directory or any parent directory. If no DESCRIPTION file is found, the function stops with an error message.
#' @param unload Whether to unload a potential currently developed package using [devtools::unload()] before checking the documentation. Required when the package was loaded with [devtools::load_all()] as the documentation database only exists for installed packages.
#' @param reload Whether to reload the package using [devtools::load_all()] after checking the documentation.
#' @return Returns a dataframe with columns `title`, `description`, `value`, `examples` and rows corresponding to the documented functions in the package.
#' @examples
#' df <- get_pkg_docs("tools")
#' nchars <- as.data.frame(apply(df, 2, function(col) sapply(col, nchar)))
#' head(nchars)
#' @keywords doc
get_pkg_docs <- function(pkg = NULL, unload = TRUE, reload = TRUE) {
    if (is.null(pkg)) {
        tryCatch(
            pkg <- read_description_file()$Package,
            error = function(e) stop("Could not infern package name. Please provide it manually.")
        )
    }
    db <- tools::Rd_db(pkg)
    if (identical(db, structure(list(), names = character(0))) && isTRUE(unload) && "devtools_shims" %in% search()) {
        if (!requireNamespace("devtools", quietly = TRUE)) stop("Unloading requires the 'devtools'. Please install first.")
        devtools::unload()
        db <- tools::Rd_db(pkg)
        if (reload) devtools::load_all(quiet = TRUE)
    }
    rds <- names(db)
    tags <- c("title", "description", "value", "format", "examples")
    cols <- c("class", tags)
    syms <- sapply(rds, function(rd) strsplit(rd, "\\.")[[1]][1])
    ns <- asNamespace(pkg)
    rds <- rds[syms %in% ls(ns)]
    syms <- syms[syms %in% ls(ns)]
    m <- matrix(nrow = length(rds), ncol = length(cols), dimnames = list(syms, cols))
    df <- as.data.frame(m)
    df$class <- sapply(syms, function(sym) mode(ns[[sym]]))
    for (i in seq_along(rds)) {
        for (tag in tags) {
            df[i, tag] <- extract_help_section(db[[rds[i]]], tag)
        }
    }
    df
}

#' @noRd
#' @title Extract a Specific Section From a Documentation Database
#' @description Helper function for [get_pkg_docs()] to extract a specific tag from a documentation database.
#' @keywords doc
#' @param tag The tag to extract.
#' @param db The documentation database.
#' @return Returns the extracted tag as raw text.
#' @examples
#' db <- tools::Rd_db("codetools")
#' dbelem <- db$checkUsage.Rd
#' title <- extract_help_section(dbelem, "title")
#' name <- extract_help_section(dbelem, "name")
#' alias <- extract_help_section(dbelem, "alias")
#' allsections <- extract_help_section(dbelem)
#' @keywords doc
extract_help_section <- function(dbelem = tools::Rd_db("base")$sum.Rd,
                                 tag = NULL,
                                 default = "") {
    tagID <- paste0("\\", tag)
    tagIDs <- sapply(dbelem, function(subelem) attributes(subelem)$Rd_tag)
    if (is.null(tag)) {
        tags <- unique(gsub("\\\\", "", tagIDs))
        textlist <- lapply(tags, function(tag) extract_help_section(dbelem, tag))
        names(textlist) <- tags
        return(textlist)
    } else {
        idx <- which(tagIDs == tagID)
        texts <- character(length(idx))
        for (i in seq_along(idx)) {
            lines <- if (length(idx) > 0) unlist(dbelem[[idx[i]]]) else default
            if (lines[1] == "\n") lines <- lines[-1]
            lines <- gsub("^  ", "", lines)
            texts[i] <- paste(lines, collapse = "")
        }
        if (length(texts) == 0) texts <- default
        return(texts)
    }
}

#' @export
#' @title Read DESCRIPTION File into a List
#' @description Reads the DESCRIPTION file of an R package and converts it into a list where each element corresponds to a field in the DESCRIPTION file.
#' @param p The path to the DESCRIPTION file. If `NULL`, the function attempts to find the DESCRIPTION file by searching upwards from the current directory.
#' @return A list where each element is a field from the DESCRIPTION file.
#' @examples
#' # Read DECRIPTION file from a specific path
#' graphics_pkg_dir <- system.file(package = "graphics")
#' graphics_pkg_descfile <- find_description_file(graphics_pkg_dir)
#' desc_list <- read_description_file(graphics_pkg_descfile)
#' str(desc_list)
#'
#' \dontrun{
#' # Below example will only work if executed from a package directory
#' read_description_file()
#' }
#' @keywords doc
read_description_file <- function(p = NULL) {
    if (is.null(p)) p <- find_description_file()
    if (!file.exists(p)) stop(p, "does not exist.")
    obj <- read.dcf(p) # Dataframe of dimension 1xN
    as.list(obj[1, ])
}

#' @export
#' @title Find DESCRIPTION File
#' @description Searches for a DESCRIPTION file starting from the current or specified directory and moving upwards through the directory hierarchy until the file is found or the root directory is reached.
#' @param start_dir The starting directory for the search. Defaults to the current working directory.
#' @return The path to the DESCRIPTION file if found. If not found, the function stops with an error message.
#' @examples
#' # Start search from a specific directory
#' graphics_pkg_dir <- system.file(package = "graphics")
#' find_description_file(graphics_pkg_dir)
#'
#' \dontrun{
#' # Below example will only work if executed from a package directory
#' find_description_file()
#' }
#' @keywords doc
find_description_file <- function(start_dir = getwd()) {
    if (!dir.exists(start_dir)) stop("Directory `start_dir` does not exist.")
    current_dir <- normalizePath(start_dir, winslash = "/")
    root_dir <- normalizePath("/", winslash = "/")
    while (TRUE) {
        description_path <- file.path(current_dir, "DESCRIPTION")
        if (file.exists(description_path)) {
            return(description_path)
        } else {
            if (identical(current_dir, root_dir)) stop("No DESCRIPTION file found in any parent directory.")
            current_dir <- dirname(current_dir)
        }
    }
}

# Docstring #####

#' @export
#' @title Update docstring for a Function
#' @description The [roxygen2](https://roxygen2.r-lib.org/) package makes it
#' possible to write documentation for R functions directly above the
#' corresponding function. This function can be used to update the parameter
#' list of a documentation string (docstring) of a valid function of a valid R
#' file. The update is done by comparing the currently listed parameters with
#' the actual function parameters. Outdated parameters are removed and missing
#' parameters are added to the docstring.
#' @param uri Path to R file.
#' @param func Function name. If a function is defined multiple times inside the
#' provided file, only the last occurence will be considered.
#' @param content R code as string. If provided, uri is ignored.
#' @return A character vector of length 1 containing the updated docstring.
#' @examples
#' uri <- system.file("testfiles/funcs.R", package = "toscutil")
#' func <- "f4"
#' update_docstring(uri, func)
#' @keywords doc
update_docstring <- function(uri, func, content = NULL) {
    content <- readLines(uri)
    param_names <- names(get_formals(uri, content, func))
    docstring <- get_docstring(content, func, collapse = TRUE)
    dfs <- split_docstring(docstring)
    # list(head = c(header = "",
    #               title = "#' @title The Title\n",
    #               description = "#' @description The description.\n"),
    #      param = c(a = "#' @param a Already documented\n",
    #                b = "#' @param b TODO\n",
    #                z = "#' @param z Bla\n"),
    #      tail = c(details = "#' @details Bla Bla\n",
    #               export = "#' @export"))
    for (param_name in param_names) {
        if (!(param_name %in% names(dfs$param))) {
            dfs$param[[param_name]] <- paste("#' @param", param_name, "TODO\n")
        }
    }
    dfs$param <- dfs$param[param_names]
    paste(c(dfs$head, dfs$param, dfs$tail), collapse = "")
}

#' @export
#' @title Get docstring for a Function
#' @description The [roxygen2](https://roxygen2.r-lib.org/) package makes it
#' possible to write documentation for R functions directly above the
#' corresponding function. This function can be used to retrieve the full
#' documentation string (docstring).
#' @param content R code as string.
#' @param func Name of function to get docstring for.
#' @param collapse Whether to collapse all docstring into a single string.
#' @param template String to return in case no docstring could be found.
#' @return A character vector of length 1 containing either the docstring or the
#' empty string (in case no documentation could be detected).
#' @examples
#' uri <- system.file("testfiles/funcs.R", package = "toscutil")
#' content <- readLines(uri)
#' func <- "f2"
#' get_docstring(content, func)
#' get_docstring(content, func, collapse = TRUE)
#' @keywords doc
get_docstring <- function(content,
                          func,
                          collapse = TRUE,
                          template = DOCSTRING_TEMPLATE) {
    pattern <- paste0(func, "\\s*(<-|=)\\s*function")
    func_lines <- grep(pattern, content)
    func_line <- func_lines[length(func_lines)]
    start_line <- func_line
    while (start_line >= 2 && grepl("^\\s*#'", content[[start_line - 1]])) {
        start_line <- start_line - 1
    }
    docstring <- template
    if (start_line < func_line) {
        docstring <- content[start_line:(func_line - 1)]
        if (collapse) {
            docstring <- paste(docstring, collapse = "\n")
            docstring <- paste0(docstring, "\n")
        }
    }
    return(docstring)
}

#' @export
#' @title Split a docstring into a Head, Param and Tail Part
#' @description Split a docstring into a head, param and tail part.
#' @param docstring Docstring of a R function as string, i.e. as character
#' vector of length 1.
#' @return List with 3 elements: head, param and tail.
#' @examples
#' uri <- system.file("testfiles/funcs.R", package = "toscutil")
#' func <- "f4"
#' content <- readLines(uri)
#' docstring <- get_docstring(content, func)
#' split_docstring(docstring)
#' @keywords doc
split_docstring <- function(docstring) {
    # Split docstring into substrings after each tag.
    # Implementation detail: We add an additional word at the end of the
    # docstring to ensure we get n+1 substrings for n tags. E.g. this docstring:
    # "#' @title Sum of Elements\n#' @param ... Summands\n#' @export"
    # should return these substrings
    # c("", "Sum of Elements", "... Summands", "")
    # Adding a leading word is not necessary, as this strsplit handles this
    # correctly by default.
    pattern <- "#'\\s+@\\w+"
    word <- "REMOVEME"
    docstring <- paste(docstring, word)
    substrings <- strsplit(docstring, pattern, perl = TRUE)[[1]]
    n <- length(substrings)
    w <- nchar(substrings[n]) - nchar(word) - 1
    substrings[n] <- substr(substrings[n], 1, w)
    tags <- regmatches(docstring, gregexpr(pattern, docstring, perl = TRUE))[[1]]
    tags <- c("", tags)
    matches <- regmatches(tags, gregexpr("@\\S+", tags))
    tag_names <- sapply(matches, function(match) {
        if (length(match) == 0) "header" else gsub("@", "", match)
    })
    # Extract params names for all substrings corresponding to a param tag. Then
    # group substrings together into symbols `head`, `param` and `tail` as
    # follows: Every param substring goes into `param.` Everything before the
    # first param substring into `head.` Everythin else into `tail`. Example:
    # #' @title The Title --> head
    # #' @description Abc --> head
    # #' @param a DescA   --> param
    # #' @param b DescB   --> param
    # #' @export          --> tail
    # #' @param c DescC   --> param
    # #' @details blablaa --> tail
    param_names <- sapply(strsplit(substrings, "\\s+"), function(words) words[2])
    param_names[tag_names != "param"] <- NA
    ids <- seq_along(tags)
    ids_params <- which(tag_names == "param")
    ids_head <- ids[ids < min(ids_params, length(tags) + 1)]
    ids_tail <- ids[!ids %in% c(ids_head, ids_params)]
    head <- paste0(tags[ids_head], substrings[ids_head])
    param <- paste0(tags[ids_params], substrings[ids_params])
    tail <- paste0(tags[ids_tail], substrings[ids_tail])
    names(head) <- tag_names[ids_head]
    names(param) <- param_names[ids_params]
    names(tail) <- tag_names[ids_tail]
    list(head = head, param = param, tail = tail)
}

#' @export
#' @title Get formals of a Function
#' @description Returns the arguments of a function from a valid R file.
#' @param uri Path to R file.
#' @param content R code as string.
#' @param func Function name. If a function is defined multiple times inside the
#' provided file, only the last occurence will be considered.
#' @return A named character vector as returned by [formals()].
#' @examples
#' uri <- system.file("testfiles/funcs.R", package = "toscutil")
#' content <- readLines(uri)
#' func <- "f2"
#' if (requireNamespace("languageserver", quietly = TRUE)) {
#'     get_formals(uri, content, func)
#' }
#' @keywords doc
get_formals <- function(uri, content, func) {
    if (!requireNamespace("languageserver", quietly = TRUE)) {
        if (interactive()) {
            x <- askYesNo("Parsing formals requires package 'languageserver'. Install?")
            if (isTRUE(x)) install.packages("languageserver")
            if (isFALSE(x) || is.na(x)) return()
        } else {
            stop("Package 'languageserver' is required for parsing formals. Please install first.")
        }
    }
    # unused <- languageserver::run # define to avoid R CMD check
    env <- loadNamespace("languageserver")
    pobj <- env$parse_document(uri, content)
    # We use this loadNamespace construct instead of calling the function
    # directly, because R CMD check throws warnings when using unexported
    # functions from other packages. However, in this case, we don't really have
    # a choice, unless we want to redefine approx. 20 functions from
    # languageserver inside this package.
    formals <- if ("formals" %in% names(pobj)) {
        pobj$formals[[func]]
    } else if ("functions" %in% names(pobj)) {
        formals(pobj$functions[[func]])
    } else {
        stop(paste(
            "Could not find function definition.",
            "This might be caused by an update of the languageserver package.",
            "Please create an issue at https://github.com/toscm/toscutil/issues.",
            sep = "\n"
        ))
    }
    return(formals)
}

#' @export
#' @title Docstring Template
#' @description A minimal docstring template
#' @format A single string, i.e. a character vector of length 1.
#' @keywords doc
#' @examples cat(DOCSTRING_TEMPLATE)
DOCSTRING_TEMPLATE <- paste0(
    "#' @title TODO (e.g. 'Sum of Vector Elements')\n",
    "#' @description TODO (e.g. 'sum returns the sum of all the values present in its arguments.'\n"
)
