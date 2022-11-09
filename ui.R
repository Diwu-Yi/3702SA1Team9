#   ____________________________________________________________________________
#   UI                                                                      ####

library(shiny)
library(leaflet)
library(plotly)
library(shinyjs)
library(shinyBS)
library(slickR)

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
                   tabPanel(div(img(src='images/home.png',
                                    style="margin-top: -5px; padding-left:0px; padding-right:5px;padding-bottom:0px; height: 30px", height = 60),
                                HTML('<span style="font-size: 14px; text-align:right; font-weight:bold">Home</span>')),
                            includeHTML("home-new.html"),
                            tags$script(src = "plugins/scripts.js"),
                            tags$head(
                              tags$link(rel = "stylesheet", 
                                        type = "text/css", 
                                        href = "plugins/font-awesome-4.7.0/css/font-awesome.min.css"),
                              tags$link(rel = "icon", 
                                        type = "image/png", 
                                        href = "images/logo1.png")
                            )
                   ),
                   # ----------------------------------
                   # tab panel 2 - Customer Demand
                   tabPanel(div(img(src='images/customer.png',
                                    style="margin-top: -5px; padding-left:0px; padding-right:5px;padding-bottom:0px; height: 30px", height = 60),
                                HTML('<span style="font-size: 14px; text-align:right; font-weight:bold">Market Demand Analysis</span>')),
                            class = "container",
                            h1("Customer Demand", class = "title fit-h1"),
                            pageWithSidebar(
                              headerPanel("View Car Demand"),
                              sidebarPanel(  
                                radioButtons(inputId = "format",label="View Days",
                                             choices = c("Weekday","Weekend"))
                              ),
                              
                              mainPanel (
                                leafletOutput(outputId = "demand")
                              )
                              
                            )
                   ),
                   # ----------------------------------
                   # tab panel 3 -  Fleet Recommendations Browser
                   tabPanel(div(img(src='images/car.png',
                                    style="margin-top: -5px; padding-left:0px; padding-right:5px;padding-bottom:0px; height: 30px", height = 60),
                                HTML('<span style="font-size: 14px; text-align:right; font-weight:bold">Fleet Recommendation</span>')),
                            class = "container",
                            h1("Fleet Recommendation", class = "title fit-h1"),
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
                                  tabPanel("Basic Info",shinycssloaders::withSpinner(dataTableOutput("basicInfo"))),
                                  tabPanel("Body & Dimension",shinycssloaders::withSpinner(dataTableOutput("bodyDimension"))),
                                  tabPanel("Engine & Transmission",shinycssloaders::withSpinner(dataTableOutput("engineTrasmission"))),
                                  tabPanel("Steering",shinycssloaders::withSpinner(dataTableOutput("steering"))),
                                  tabPanel("Tires",shinycssloaders::withSpinner(dataTableOutput("tires"))),
                                  tabPanel("Wheels",shinycssloaders::withSpinner(dataTableOutput("wheels"))),
                                  tabPanel("Brake Systems",shinycssloaders::withSpinner(dataTableOutput("brake"))),
                                  tabPanel("Suspensions",shinycssloaders::withSpinner(dataTableOutput("suspensions"))),
                                  tabPanel("Weight and Towing",shinycssloaders::withSpinner(dataTableOutput("weightTowing"))),
                                  tabPanel("Connectivity Features",shinycssloaders::withSpinner(dataTableOutput("connectivity"))),
                                  tabPanel("Comfort Features",shinycssloaders::withSpinner(dataTableOutput("comfort"))),
                                  tabPanel("Safety Features",shinycssloaders::withSpinner(dataTableOutput("safety"))),
                                  tabPanel("Other Features",shinycssloaders::withSpinner(dataTableOutput("other")))
                                )
                              )
                            )
                   ),
                   
                   # ----------------------------------
                   # tab panel 4 - Car Park
                   #tabPanel(div(img(src='images/location.png',
                   #                style="margin-top: -5px; padding-left:0px; padding-right:5px;padding-bottom:0px; height: 30px", height = 60),
                   #            HTML('<span style="font-size: 14px; text-align:right; font-weight:bold">Available Carpark Identification</span>')),
                   #        neighborhoodDescription()
                   #),
                   tabPanel(div(img(src='images/location.png',
                                    style="margin-top: -5px; padding-left:0px; padding-right:5px;padding-bottom:0px; height: 30px", height = 60),
                                HTML('<span style="font-size: 14px; text-align:right; font-weight:bold">Available Carparks Identification</span>')),
                            neighborhoodDescription(),
                            includeHTML("scrollToTop.html")
                   ),
                   
                   # ----------------------------------
                   # tab panel 5 - About
                   tabPanel(div(img(src='images/about.png',
                                    style="margin-top: -5px; padding-left:0px; padding-right:5px;padding-bottom:0px; height: 30px", height = 60),
                                HTML('<span style="font-size: 14px; text-align:right; font-weight:bold">About</span>')),
                            
                            mainPanel(width = 12,
                                      titlePanel(h1("IntelliShare", 
                                                    style="font-size: 50px;color:#000B9D;font-weight:bold", 
                                                    align= "center")),
                                      fluidRow(h4("Intuitive Application for Car Sharing Companies in  Israel", 
                                                  style="color:#000000; font-weight:bold; font-size: 20px"), 
                                               align= "center"), 
                                      slickROutput("slickr", width="50%", height= "5%"),
                                      fluidRow(h2("Learn More About Intellishare", 
                                                  style="font-weight:bold"), 
                                               align= "center"), 
                                      
                                      
                                      fluidRow(p("IntelliShare is an intuitive application that seeks to help car-sharing 
                                                 companies learn more about their market in Israel and how to best increase their profits. 
                                                 The Intellishare application provides information regarding car-sharing demand in Israel,
                                                 related operating costs, and possible expansion strategies. By focusing on the demand, 
                                                 supply, and expansion possibilities, these value-added services aim to help car-sharing 
                                                 companies grow. ",style="text-align: justify; width:750px; font-weight:bold; font-size: 20px"),
                                               align = "center"),
                                      br(),
                                      
                                      fluidRow(column(1),
                                               column(5, h2("Market Demand Analysis", style= "font-weight:bold; color:#003663"), 
                                                      style = "background-color:#F2DEBA; border:3px solid #0E5E6F;"),
                                               column(5, h2("Fleet Recommendations", style= "font-weight:bold; color:#003663"), 
                                                      style = "background-color:#F2DEBA; border:3px solid #0E5E6F; border-left:0px"),
                                               column(1),
                                               
                                               align = "center"),
                                      
                                      fluidRow(column(1),
                                               column(5, br(), br(), p("The Market Demand Analysis tab helps investigate the market demand for cars during weekdays and weekends. 
                                                                         With this analysis, companies are able to adjust their fleet operation to cater to the dynamic demand trends.", 
                                                                       style= "text-align: justify; width:600px;font-weight:bold;font-size: 20px; color: white"),
                                                      style = "background-color:#3A8891; height: 300px; border:3px solid #0E5E6F;border-top:0px"),
                                               
                                               
                                               column(5,br(), br(), p("The Fleet Recommendations tab helps companies determine the type of cars they should use for their fleets. 
                                                                      This service is perfect for companies looking to expand or replace their existing car-sharing fleet to 
                                                                      provide the best service while lowering costs.", 
                                                                      style= "text-align: justify; width:600px;font-weight:bold;font-size: 20px; color: white"),
                                                      style = "background-color:#3A8891; height: 300px;border:3px solid #0E5E6F;border-top:0px; border-left: 0px"),
                                               column(1),
                                               align = "center"),
                                      
                                      fluidRow(column(3),
                                               column(6, align = "center",
                                                      h2("Available Carparks Identification",style= "font-weight:bold; color:#003663"), 
                                                      style = "background-color:#F2DEBA; border:3px solid #000F7C; border-bottom:0px;;border-top:0px"),
                                               column(3),
                                      ),
                                      
                                      fluidRow(column(3),
                                               column(6,br(), br(), p("The Available Carparks Identification tab allows companies to identify locations where consumers 
                                                                      frequently park shared cars, thus helping identify the hotspots. With the ease 
                                                                      of identification, companies can plan their next move of expansion to the various hotspot areas, 
                                                                      providing their service where it is most needed.",
                                                                      style= "text-align: justify; width:600px;font-weight:bold;font-size: 20px; color: white"),
                                                      style = "background-color:#3A8891; height: 300px; border:3px solid #0E5E6F"),
                                               column(3),
                                               align = "center"
                                      ),
                                      
                                      br()
                                      
                            ),
                            
                            
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