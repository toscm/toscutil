# TODO: Way too slow --> Replace with "manual" version from lasso_analysis.rmd
cache <- function(expr, path, dir="cache", penv=parent.frame()) #1
{
    #1 default args are evaluated in function frame
    expr <- substitute(expr)
    code <- deparse(expr)
    fun <- eval(parse(text=c("function()", "{", code, "}")))
    globals <- mget(codetools::findGlobals(fun), inherit=T)
    md5 <- digest::digest(c(code, globals))
    if (!grepl(".rda$", path))
      path <- paste0(path, ".rda")
    if (!grepl("/", path))
      path <- file.path(dir, path)
    npath <- sub("([.]rda)$", glue("_{md5}.rda"), path)
    if (file.exists(npath)) # load cached results
      do.call(load, args=list(npath), envir=penv)
    else {
      #1 run code in new env
      #2 save new objects in new rda
      #3 delete old rda
      #4 attach new objects to provided parent env
      dir.create(dirname(npath), recursive=T, showWarnings=F)
      opath <- Sys.glob(sub("([.]rda)$", glue("_*.rda"), path))
      nenv <- new.env(parent=penv)
      eval(expr, envir=nenv) #1
      nobjs <- ls(nenv)
      do.call(save, args=list(file=npath, list=nobjs), envir=nenv) #2
      if (length(opath) > 0)
        unlink(opath) #3
      for (o in nobjs)
        assign(o, nenv[[o]], envir=penv) #4
    }
}
