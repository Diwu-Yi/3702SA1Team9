#   ____________________________________________________________________________
#   UI                                                                      ####

library(shiny)
library(leaflet)
library(plotly)
library(shinyjs)
library(shinyBS)

source("appParts.R")
source("readData.R")


### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### Colors                                                                  ####

#C10250 purple
#03BCC0 green
#D2D945 yellow/green
#FCB040 orange
#FF5850 red
#436983 hipster blue

shinyUI(navbarPage(title = "IntelliShare",
                   theme = "style/style.css",
                   footer = includeHTML("footer-new.html"),
                   fluid = TRUE, 
                   collapsible = TRUE,
                   
                   # ----------------------------------
                   # tab panel 1 - Home
                   tabPanel("Home",
                            includeHTML("home-new.html"),
                            tags$script(src = "plugins/scripts.js"),
                            tags$head(
                              tags$link(rel = "stylesheet", 
                                        type = "text/css", 
                                        href = "plugins/font-awesome-4.7.0/css/font-awesome.min.css"),
                              tags$link(rel = "icon", 
                                        type = "image/png", 
                                        href = "images/logo_icon.png")
                            )
                   ),
                   
                   # ----------------------------------
                   # tab panel 2 - Car Model Recommendation Browser
                   tabPanel(div(img(src='images/car.png',
                                    style="margin-top: -5px; padding-left:0px; padding-right:5px;padding-bottom:0px; height: 30px", height = 60),
                                HTML('<span style="font-size: 14px; text-align:right; font-weight:bold">Car Model Recommendation</span>')),
                                class = "container",
                                h1("Car Model Recommendation", class = "title fit-h1"),
                                p("Let us help with your purhcase decisions for renting car!"),
                            sidebarLayout (
                              sidebarPanel(
                                selectInput("Model",
                                            "Model details:",
                                            choices = model,
                                            selected = "Kia Sorento"),
                                uiOutput("img"),
                                hr(),
                                textOutput("Price")
                              ),
                              
                              mainPanel (
                                navlistPanel(
                                  tabPanel("Basic Info",withSpinner(dataTableOutput("basicInfo"))),
                                  tabPanel("Body & Dimension",withSpinner(dataTableOutput("bodyDimension"))),
                                  tabPanel("Engine & Transmission",withSpinner(dataTableOutput("engineTrasmission"))),
                                  tabPanel("Steering",withSpinner(dataTableOutput("steering"))),
                                  tabPanel("Tires",withSpinner(dataTableOutput("tires"))),
                                  tabPanel("Wheels",withSpinner(dataTableOutput("wheels"))),
                                  tabPanel("Brake Systems",withSpinner(dataTableOutput("brake"))),
                                  tabPanel("Suspensions",withSpinner(dataTableOutput("suspensions"))),
                                  tabPanel("Weight and Towing",withSpinner(dataTableOutput("weightTowing"))),
                                  tabPanel("Connectivity Features",withSpinner(dataTableOutput("connectivity"))),
                                  tabPanel("Comfort Features",withSpinner(dataTableOutput("comfort"))),
                                  tabPanel("Safety Features",withSpinner(dataTableOutput("safety"))),
                                  tabPanel("Other Features",withSpinner(dataTableOutput("other")))
                                )
                              )
                            )
                   ),
                   
                   # ----------------------------------
                   # tab panel 3 - Location Comparison
                   tabPanel("Location Comparison",
                            propertyComparison()
                   ),
                   
                   # ----------------------------------
                   # tab panel 4 - About
                   tabPanel("Hi",
                            includeHTML("about.html"),
                            shinyjs::useShinyjs(),
                            tags$head(
                                tags$link(rel = "stylesheet", 
                                          type = "text/css", 
                                          href = "plugins/carousel.css"),
                                tags$script(src = "plugins/holder.js")
                            ),
                            tags$style(type="text/css",
                                       ".shiny-output-error { visibility: hidden; }",
                                       ".shiny-output-error:before { visibility: hidden; }"
                            )
                   )
                   
))