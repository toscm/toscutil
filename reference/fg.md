# Foreground Color Codes

Provides ANSI escape codes as a named list for changing terminal text
colors and style resetting. These codes can modify the foreground color
and reset styles to defaults (incl. background color and text
formatting).

## Usage

``` r
fg
```

## Format

A named list of ANSI escape codes for text coloring and style resetting
in the terminal. Includes colors: GREY, RED, GREEN, YELLOW, BLUE,
PURPLE, CYAN, WHITE, and RESET for default style restoration.

## Examples

``` r
cat(fg$RED, "This text will be red.", fg$RESET, "\n")
#>  This text will be red.  
cat(fg$GREEN, "This text will be green.", fg$RESET, "\n")
#>  This text will be green.  
cat(fg$RESET, "Text back to default.", "\n")
#>  Text back to default. 
```
