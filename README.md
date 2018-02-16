# shinyrunmodule

The goal of **shinyrunmodule** is to allow quick iteration when developing [Shiny modules](http://shiny.rstudio.com/articles/modules.html).

Instead of doing 

```
shiny::shinyApp(
    ui = simpleModuleUI("test"), 
    server = function(input, output, session) callModule(simpleModule, "test")
)
```

now do

```
shinyrunmodule::run_module("simpleModule")
```

For now, **shinyrunmodule** requires the module (ui and server) to be **in the global environment**.

## Installation

**shinyrunmodule** is only available on Github for now so use `devtools` / `remotes` :

```
devtools::install_github("tutuchan/shinyrunmodule")
```

or

```
remotes::install_github("tutuchan/shinyrunmodule")
```

## Examples

There are several examples in the `inst/examples` directory, use `run_example()`:

+ 01-simple: `shinyrunmodule::run_example("simple")`
+ 02-shinydashboard: `shinyrunmodule::run_example("shinydashboard")`
+ 03-params: 
    + `shinyrunmodule::run_example("params")`
    + `shinyrunmodule::run_example("params", label = "Pick another CSV file")`


