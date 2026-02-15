# Return help for topic

Returns the help text for the specified topic formatted either as plain
text, html or latex.

## Usage

``` r
help2(topic, format = "text", package = NULL)
```

## Arguments

- topic:

  character, the topic for which to return the help text. See argument
  `topic` of function [`help()`](https://rdrr.io/r/utils/help.html) for
  details.

- format:

  character, either `"text"`, `"html"` or `"latex"`

- package:

  character, the package for which to return the help text. This
  argument will be ignored if topic is specified. Package must be
  attached to the search list first, e.g. by calling
  [`library(package)`](https://rdrr.io/r/base/library.html).

## Value

The help text for the specified topic in the specified format as string.

## Examples

``` r
htm <- help2("sum", "html")
txt <- help2(topic = "sum", format = "text")
cat2(txt)
#> _S_u_m _o_f _V_e_c_t_o_r _E_l_e_m_e_n_t_s
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      ‘sum’ returns the sum of all the values present in its arguments.
#> 
#> _U_s_a_g_e:
#> 
#>      sum(..., na.rm = FALSE)
#>      
#> _A_r_g_u_m_e_n_t_s:
#> 
#>      ...: numeric or complex or logical vectors.
#> 
#>    na.rm: logical (‘TRUE’ or ‘FALSE’).  Should missing values
#>           (including ‘NaN’) be removed?
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      This is a generic function: methods can be defined for it directly
#>      or via the ‘Summary’ group generic.  For this to work properly,
#>      the arguments ‘...’ should be unnamed, and dispatch is on the
#>      first argument.
#> 
#>      If ‘na.rm’ is ‘FALSE’ an ‘NA’ or ‘NaN’ value in any of the
#>      arguments will cause a value of ‘NA’ or ‘NaN’ to be returned,
#>      otherwise ‘NA’ and ‘NaN’ values are ignored.
#> 
#>      Logical true values are regarded as one, false values as zero.
#>      For historical reasons, ‘NULL’ is accepted and treated as if it
#>      were ‘integer(0)’.
#> 
#>      Loss of accuracy can occur when summing values of different signs:
#>      this can even occur for sufficiently long integer inputs if the
#>      partial sums would cause integer overflow.  Where possible
#>      extended-precision accumulators are used, typically well supported
#>      with C99 and newer, but possibly platform-dependent.
#> 
#> _V_a_l_u_e:
#> 
#>      The sum.  If all of the ‘...’ arguments are of type integer or
#>      logical, then the sum is ‘integer’ when possible and is ‘double’
#>      otherwise.  Integer overflow should no longer happen since R
#>      version 3.5.0.  For other argument types it is a length-one
#>      numeric (‘double’) or complex vector.
#> 
#>      *NB:* the sum of an empty set is zero, by definition.
#> 
#> _S_4 _m_e_t_h_o_d_s:
#> 
#>      This is part of the S4 ‘Summary’ group generic.  Methods for it
#>      must use the signature ‘x, ..., na.rm’.
#> 
#>      ‘plotmath’ for the use of ‘sum’ in plot annotation.
#> 
#> _R_e_f_e_r_e_n_c_e_s:
#> 
#>      Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) _The New S
#>      Language_.  Wadsworth & Brooks/Cole.
#> 
#> _S_e_e _A_l_s_o:
#> 
#>      ‘colSums’ for row and column sums.
#> 
#> _E_x_a_m_p_l_e_s:
#> 
#>      ## Pass a vector to sum, and it will add the elements together.
#>      sum(1:5)
#>      
#>      ## Pass several numbers to sum, and it also adds the elements.
#>      sum(1, 2, 3, 4, 5)
#>      
#>      ## In fact, you can pass vectors into several arguments, and everything gets added.
#>      sum(1:2, 3:5)
#>      
#>      ## If there are missing values, the sum is unknown, i.e., also missing, ....
#>      sum(1:5, NA)
#>      ## ... unless  we exclude missing values explicitly:
#>      sum(1:5, NA, na.rm = TRUE)
#>      
```
