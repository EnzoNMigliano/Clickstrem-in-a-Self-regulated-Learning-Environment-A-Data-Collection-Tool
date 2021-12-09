##### Welcome! Enjoy the source code!  This work is licensed under the MIT License

# loading the libraries

library(shiny)
library(plotly)
library(shinycssloaders)
library(tidyverse)
library(shinyjs)
library(shinythemes)
library(scales)
library(shinyalert)
library(RCurl)


data <- read.csv("final_stem_data.csv")



data$Gender <- as.factor(data$Gender)
data$Ethnicity <- as.factor(data$Ethnicity)

data <- data %>% select(-X)

Continuous_variables <- colnames(data)[1:40]
categorical_variables <- colnames(data)[41:43]

# Define UI for application that draws a histogram
ui <- fluidPage(  
  
  # Application title
  titlePanel(title = HTML("<center>Explore STEM Majors: An Interactive Web Application
                          </center>"),
             windowTitle = "Explore STEAM Majors!"),
                 
  
  # Initializing shinyjs
  
       useShinyjs(),
  
  # first survey ######
  
  #shinyalert()
  
  ##### Top Part of the Web Page #####
  
  
  HTML("<center><h4><i> Enzo Novi Migliano <sup>1</sup> 
  and Dr. Sean Mondesire <sup>2</sup>, 2021 
  </br> </br>  <sup>1</sup>Saint Thomas University and
  <sup>2</sup>University of Central Florida </center></h4></i>
  </br>
  </br>
       <center><img src='nasa_robot.jpg'
       alt='Flooding in Brickell' width='640' height='424'></center>
</br>
          <center><h6>Image Source: National Aeronautics
       and Space Administration, 2012</h6></center>"),
  
  br(),
  
  
  
  
  ##### Tab Set Panels #######
  
  tabsetPanel(
    
    ##### Welcome Panel #######
    
    tabPanel(title = "Welcome!",
             
             HTML("</br>
             <center><h4>What is this App?</h4></center>
      <P ALIGN=Left>&nbsp;&nbsp; This application is a visualization tool of the undergraduate degrees awarded in
      science, technologies, engineering, and mathematics 2008 to 2018.
      The application is written in R and powered through Shiny App.
      Shiny App is an interactive application.
      Therefore, you will be able to explore the different cases scenarios on the various graphs.
      Find instructions below on how to explore the app.
      </p>
      <center><h4>How to navigate the App?</h4></center>
      <P ALIGN=Left>&nbsp;&nbsp; There are two navigation panels. In the first panel, 
      you will explore the data gathered from the National Science Foundation.
      Take your time to get familiarized with the data and its variables through an interactive
      table. In the second panel, you will find a menu where you can build your own graph.
      There are four different graphs available: Histogram, Scatter Plot, Line Plot, and
      Box Plot. There is an optional description of the graph underneath the vizualization with
      instruction on how to construct your own.
      Feel free to explore the graphs in whatever order you would like. 
      Finally, The visualizations are interactive ones where you can select data points by 
      clicking on them. 
      </p>
      </br>
      <center><h4><strong>Enjoy the App!</strong></h4></center>")
             
             ),
    
    
    ##### Explore the Data ######
    
    tabPanel(title = "Explore the Data",
           
             br(),
               
             dataTableOutput('table')
             
    ),
    
    
    
    ##### BUild Your Graph ######
    
    tabPanel(title = "Build Your Graph",
    
             br(),
             
             ##### Side Bar Panel #####
             sidebarLayout(
             sidebarPanel(
              
               selectInput(inputId = "plot_type",
                                      label = "Plot Type",
                                      choices = c("",
                                                  "Histogram",
                                                  "Scatter Plot",
                                                  "Line Plot",
                                                  "Box Plot")),
               
               ##### Condition histogram inputs #####
               
               conditionalPanel(condition = "input.plot_type == 'Histogram'",
                                
                                HTML("<center><h4><strong> Create your graph!
                                     </center></h4></strong>"),
                                
                                br(),
                                
                                HTML("<h5><strong> Filter the Data
                                     </h5></strong>"),
                                
                                sliderInput(inputId = "histogram_filter",
                                            label = "Year Range",
                                            min = 2008, max = 2018, 
                                            value = c(2008, 2018),
                                            sep = ""), 
                                
                                br(),
                                
                                HTML("<h5><strong> Horizontal (X) Axis variable
                                     </h5></strong>"),
                                
                                selectInput(inputId = "histogram_x",
                                            label = "Categorical Variable",
                                            choices = c("", categorical_variables)),
                                br(),
                                
                                HTML("<h5><strong> Vertical (Y) Axis variable
                                     </h5></strong>"),
                                
                                selectInput(inputId = "histogram_y",
                                            label = "Continuous Variable",
                                            choices = c("", Continuous_variables)),
                                
                                br(),
                                
                                HTML("<h5><strong> Group & Color
                                     </h5></strong>"),
                                
                                selectInput(inputId = "histogram_color",
                                            label = "Categorical Variable",
                                            choices = c("", categorical_variables))
                                
                                ),
               
               ##### Condition Scatter Plot inputs #####
               
               conditionalPanel(condition = "input.plot_type == 'Scatter Plot'",
                                
                                
                                HTML("<center><h4><strong> Create your graph!
                                     </center></h4></strong>"),
                                
                                br(),
                                
                                HTML("<h5><strong> Filter the Data
                                     </h5></strong>"),
                                
                                sliderInput(inputId = "scatter_filter",
                                            label = "Year Range",
                                            min = 2008, max = 2018, 
                                            value = c("2008", "2018"),
                                            sep = ""), 
                                
                                br(),
                                
                                HTML("<h5><strong> Horizontal (X) Axis variable
                                     </h5></strong>"),
                                
                                selectInput(inputId = "scatter_x",
                                            label = "Continuous Variable",
                                            choices = c("", Continuous_variables)),
                                br(),
                                
                                HTML("<h5><strong> Vertical (Y) Axis variable
                                     </h5></strong>"),
                                
                                selectInput(inputId = "scatter_y",
                                            label = "Continuous Variable",
                                            choices = c("", Continuous_variables)),
                                
                                br(),
                                
                                HTML("<h5><strong> Group & Color
                                     </h5></strong>"),
                                
                                selectInput(inputId = "scatter_color",
                                            label = "Categorical Variable",
                                            choices = c("", categorical_variables)),
                                
                                br(),
                                
                                HTML("<h5><strong> Point Shape
                                     </h5></strong>"),
                                
                                selectInput(inputId = "scatter_shape",
                                            label = "Categorical Variable",
                                            choices = c("", categorical_variables))
                                
                                
               ),
               
               
               
               ##### Condition line Plot inputs #####
               
               conditionalPanel(condition = "input.plot_type == 'Line Plot'",
                                
                                HTML("<center><h4><strong> Create your graph!
                                     </center></h4></strong>"),
                                
                                br(),
                                
                                HTML("<h5><strong> Filter the Data
                                     </h5></strong>"),
                                
                                sliderInput(inputId = "line_filter",
                                            label = "Year Range",
                                            min = 2008, max = 2018, 
                                            value = c("2008", "2018"),
                                            sep = ""), 
                                
                                br(),
                                
                                HTML("<h5><strong> Horizontal (X) Axis variable
                                     </h5></strong>"),
                                
                                selectInput(inputId = "line_x",
                                            label = "Continuous Variable",
                                            choices = c("", Continuous_variables)),
                                br(),
                                
                                HTML("<h5><strong> Vertical (Y) Axis variable
                                     </h5></strong>"),
                                
                                selectInput(inputId = "line_y",
                                            label = "Continuous Variable",
                                            choices = c("", Continuous_variables)),
                                
                                br(),
                                
                                HTML("<h5><strong> Group & Color
                                     </h5></strong>"),
                                
                                selectInput(inputId = "line_color",
                                            label = "Categorical Variable",
                                            choices = c("", categorical_variables))      
                                
               ),
               
               
               
               
               ##### Condition Box Plot inputs #####
               
               conditionalPanel(condition = "input.plot_type == 'Box Plot'",
                                
                                HTML("<center><h4><strong> Create your graph!
                                     </center></h4></strong>"),
                                
                                br(),
                                
                                HTML("<h5><strong> Filter the Data
                                     </h5></strong>"),
                                
                                sliderInput(inputId = "box_filter",
                                            label = "Year Range",
                                            min = 2008, max = 2018, 
                                            value = c("2008", "2018"),
                                            sep = ""), 
                                
                                br(),
                                
                                HTML("<h5><strong> Horizontal (X) Axis variable
                                     </h5></strong>"),
                                
                                selectInput(inputId = "box_x",
                                            label = "Continuous Variable",
                                            choices = c("", Continuous_variables)),
                                br(),
                                
                                HTML("<h5><strong> Vertical (Y) Axis variable
                                     </h5></strong>"),
                                
                                selectInput(inputId = "box_y",
                                            label = "Categorical Variable",
                                            choices = c("", categorical_variables)),
                                
                                br(),
                                
                                HTML("<h5><strong> Group & Color
                                     </h5></strong>"),
                                
                                selectInput(inputId = "box_color",
                                            label = "Categorical Variable",
                                            choices = c("", categorical_variables)) 
                                
               ),
               
               
               
               
               
                          ),
             
             
             ##### Main Panel ####
             
             
             mainPanel(
               
               ##### No Graph Condition #####
               
               conditionalPanel(
                 
                 condition = "input.plot_type == ''",
                 
                 
                 
                 HTML("<center><h3><strong>Select a Plot Type </br></br>
                 
                 No Plot Type Selected
                      </strong></h3></center>")
                 
                 
               ),
               
               
               ##### Histogram Condition #####
               
               
               conditionalPanel(
                 
                 condition = "input.plot_type == 'Histogram'",
                 
                 
                 
                 HTML("<center><h3><strong>Plot Type: Histogram
                      </strong></h3></center>"),
                 
                 br(),
                 
                 # conditionals for the inputs
                 
                 conditionalPanel(condition = "input.histogram_x != '' &
                                  input.histogram_y != '' &
                                  input.histogram_color != ''",
                       
                                  
                                  plotlyOutput("histogram")
                                  
                                  ),
                 
                 conditionalPanel(condition = "input.histogram_x == '' |
                                  input.histogram_y == '' |
                                  input.histogram_color == ''",
                                  
                                  HTML("<center><h3><strong>Please fill your graph with all
                                  the variables located on the left panel
                      </strong></h3></center>") 
                                  
                 ),
                 
                 br(),
                 
                 
                 div(id = "histogramText", 
                     HTML("<h3> What is a Histogram?</h3> 
                          &nbsp; &nbsp; 
                          
                          </br>
                          
                          <h3> How to build your own Histogram?</h3>
                          
                          ")),
                 
                 HTML("<center>"),
                
                 checkboxInput(inputId = "checkHistogramToggle",
                               label = "",
                               FALSE),
                 
                 HTML("<h5>
                    Learn More About This Graph
                   </h5></center>")
                 
               ),
               
               
               
              
               
               ##### Scatter plot Condition #####
               
               conditionalPanel(
                 
                 condition = "input.plot_type == 'Scatter Plot'",
                 
                 
                 
                 HTML("<center><h3><strong>Plot Type: Scatter Plot
                      </strong></h3></center>"),
                
                 
                 br(),
                 
                 # conditionals for the inputs
                 
                 conditionalPanel(condition = "input.scatter_x != '' &
                                  input.scatter_y != '' &
                                  input.scatter_color != '' &
                                  input.scatter_shape != ''",
                                  
                                  
                                  plotlyOutput("scatter")
                                  
                 ),
                 
                 conditionalPanel(condition = "input.scatter_x == '' |
                                  input.scatter_y == '' |
                                  input.scatter_color == '' |
                                  input.scatter_shape == ''",
                                  
                                  HTML("<center><h3><strong>Please fill your graph with all
                                  the variables located on the left panel
                      </strong></h3></center>") 
                                  
                 ),
                 
                 br(),
                 
                 
                 div(id = "scatterText", 
                     HTML("<h3> What is a Scatter Plot?</h3> 
                          &nbsp; &nbsp; 
                          
                          </br>
                          
                          <h3> How to build your own Scatter Plot?</h3>
                          
                          ")),
                 
                 HTML("<center>"),
                 
                 checkboxInput(inputId = "checkScatterToggle",
                               label = "",
                               FALSE),
                 
                 HTML("<h4>
                    Learn More About This Graph
                   </h4></center>")
                 
               ),
               
               
               ##### Line plot Condition #####
               
               conditionalPanel(
                 
                 condition = "input.plot_type == 'Line Plot'",
                 
                 
                 
                 HTML("<center><h3><strong>Plot Type: Line Plot
                      </strong></h3></center>"),
                 
                 br(),
                 
                 # conditionals for the inputs
                 
                 conditionalPanel(condition = "input.line_x != '' &
                                  input.line_y != '' &
                                  input.line_color != ''",
                                  
                              
                                  plotlyOutput("line")
                                  
                 ),
                 
                 conditionalPanel(condition = "input.line_x == '' |
                                  input.line_y == '' |
                                  input.line_color == ''",
                                  
                                  HTML("<center><h3><strong>Please fill your graph with all
                                  the variables located on the left panel
                      </strong></h3></center>") 
                                  
                 ),
                 
                 br(),
                 
                 
                 div(id = "lineText", 
                     HTML("<h3> What is a Line Plot?</h3> 
                          &nbsp; &nbsp; 
                          
                          </br>
                          
                          <h3> How to build your own Line Plot?</h3>
                          
                          ")),
                 
                 HTML("<center>"),
                 
                 checkboxInput(inputId = "checkLineToggle",
                               label = "",
                               FALSE),
                 
                 HTML("<h4>
                    Learn More About This Graph
                   </h4></center>")
                 
                 
               ), 
               
               
               ##### Box plot Condition #####
               
               conditionalPanel(
                 
                 condition = "input.plot_type == 'Box Plot'",
                 
                 
                 
                 HTML("<center><h3><strong>Plot Type: Box Plot
                      </strong></h3></center>"),
                 
                 br(),
                 
                 # conditionals for the inputs
                 
                 conditionalPanel(condition = "input.box_x != '' &
                                  input.box_y != '' &
                                  input.box_color != ''",
                              
                                    
                                  
                                  plotOutput("box")
                                  
                 ),
                 
                 conditionalPanel(condition = "input.box_x == '' |
                                  input.box_y == '' |
                                  input.box_color == ''",
                                  
                                  HTML("<center><h3><strong>Please fill your graph with all
                                  the variables located on the left panel
                      </strong></h3></center>") 
                                  
                 ),
                 
                 br(),
                 
                 
                 div(id = "BoxText", 
                     HTML("<h3> What is a Box Plot?</h3> 
                          &nbsp; &nbsp; 
                          
                          </br>
                          
                          <h3> How to build your own Box Plot?</h3>
                          
                          ")),
                 
                 HTML("<center>"),
                 
                 checkboxInput(inputId = "checkBoxToggle",
                               label = "",
                               FALSE),
                 
                 HTML("<h4>
                    Learn More About This Graph
                   </h4></center>")
                 
               ),
               
               
             )
             
             
             ))),
  
  
##### Botton of the Application #####



hr(),

HTML("<center><h5><strong>External Links</strong></h5></center>"),

HTML("<center><a href='https://ncsesdata.nsf.gov/sere/2018/'>National Science Foundation </a>&nbsp; &nbsp; 
       <a href='https://www.unicef.org/globalinsight/stories/mapping-gender-equality-stem-school-work'> UNICEF </a>
     
     &nbsp; &nbsp; 
       <a href='https://www.census.gov/library/publications/2013/acs/acs-24.html'> United States Census Bureau </a>
     </center>"),

##### Footer ####


shinythemes::themeSelector(),

)

############ Server Side ###################


server <- function(input, output) {

  
  ##### data #####
  
  data <- read.csv("final_stem_data.csv")


  data$Gender <- as.factor(data$Gender)
  data$Ethnicity <- as.factor(data$Ethnicity)
  
  data <- data %>% select(-X)
  
 
  
  # Table #####
  
  
  output$table <- renderDataTable(data,
                                  options = list(
                                    pageLength = 5))
  
  
  #Histogram #####
    
  
  output$histogram <- renderPlotly({
    
    url <- paste0("https://bigdataforall.com/store/?key=shiny&graph=histogram&input1=",
                  input$histogram_y,"&input2=",
                  input$histogram_x,
                  "&input3=",
                  input$histogram_color)
    
    RCurl::getURL(url,
                  .opts = RCurl::curlOptions(ssl.verifypeer = FALSE))
    
    data <- data %>%
      filter(Year >= input$histogram_filter[1],
             Year <= input$histogram_filter[2])
    
    data$Year <- as.factor(data$Year)
      
    
    gg <- ggplot(data = data) +
      geom_histogram(mapping = aes(x = data[,input$histogram_x],
                                   y = data[,input$histogram_y],
                                   group = data[,input$histogram_color],
                                   fill = data[,input$histogram_color]),
                     stat = "identity",
                     position = "dodge") +
      scale_y_continuous(labels = comma) +
      labs(title = paste("Histogram:", 
                         input$histogram_x,
                         "&",
                         input$histogram_y,
                         "-", "Colored by",
                         input$histogram_color),
           y = input$histogram_y,
           x = input$histogram_x,
           fill = input$histogram_color)+
      theme_minimal()
    
    
    plotly_histogram <- ggplotly(gg)
    
   
    
      return(plotly_histogram)
      
  })
  
  
   observe({
    toggle(id = "histogramText",
           condition = input$checkHistogramToggle,
           anim = TRUE,
           animType = "fade",
           time = 1)
     
     
     RCurl::getURL("https://bigdataforall.com/store/?key=shiny&graph=histogram&learnmore=TRUE",
                   .opts = RCurl::curlOptions(ssl.verifypeer = FALSE))
  })
  
  
  # Scatter #######
  
  
   output$scatter <- renderPlotly({
     
     url <- paste0("https://bigdataforall.com/store/?key=shiny&graph=scatterplot&input1=",
                   input$scatter_y,"&input2=",
                   input$scatter_x,
                   "&input3=",
                   input$scatter_color)
     
     RCurl::getURL(url,
                   .opts = RCurl::curlOptions(ssl.verifypeer = FALSE))
     
     data <- data %>%
       filter(Year >= input$scatter_filter[1],
              Year <= input$scatter_filter[2])
     
     data$Year <- as.factor(data$Year)
     
     
     gg <- ggplot(data = data) +
       geom_point(mapping = aes(x = data[,input$scatter_x],
                                    y = data[,input$scatter_y],
                                    group = data[,input$scatter_color],
                                    fill = data[,input$scatter_color]),
                      stat = "identity",
                      position = "dodge") +
       scale_y_continuous(labels = comma) +
       scale_x_continuous(labels = comma) +
       labs(title = paste("Scatter:", 
                          input$scatter_x,
                          "&",
                          input$scatter_y,
                          "-", "Colored by",
                          input$scatter_color),
            y = input$scatter_y,
            x = input$scatter_x,
            fill = input$scatter_color)+
       theme_minimal()
     
     
     plotly_scatter <- ggplotly(gg)
     
     return(plotly_scatter)
     
   })
   
   
  observe({
    toggle(id = "scatterText",
           condition = input$checkScatterToggle,
           anim = TRUE,
           animType = "fade",
           time = 1)
    
    
    RCurl::getURL("https://bigdataforall.com/store/?key=shiny&graph=scatterplot&learnmore=TRUE",
                  .opts = RCurl::curlOptions(ssl.verifypeer = FALSE))
  })
  
  
  # Line #######
  
  
  output$line <- renderPlotly({
    
    url <- paste0("https://bigdataforall.com/store/?key=shiny&graph=line&input1=",
                  input$line_y,"&input2=",
                  input$line_x,
                  "&input3=",
                  input$line_color)
    
    RCurl::getURL(url,
                  .opts = RCurl::curlOptions(ssl.verifypeer = FALSE))
    
    data <- data %>%
      filter(Year >= input$line_filter[1],
             Year <= input$line_filter[2])
    
    data$Year <- as.factor(data$Year)
    
    
    gg <- ggplot(data = data) +
      geom_line(mapping = aes(x = data[,input$line_x],
                                 y = data[,input$line_y],
                                 group = data[,input$line_color],
                                 fill = data[,input$line_color]),
                   stat = "identity",
                   position = "dodge") +
      scale_y_continuous(labels = comma) +
      scale_x_continuous(labels = comma) +
      labs(title = paste("Line:", 
                         input$line_x,
                         "&",
                         input$line_y,
                         "-", "Colored by",
                         input$line_color),
           y = input$line_y,
           x = input$line_x,
           fill = input$line_color)+
      theme_minimal()
    
    
    plotly_line <- ggplotly(gg)
    
    return(plotly_line)
    
  })
  
  
  observe({
    toggle(id = "lineText", 
           condition = input$checkLineToggle,
           anim = TRUE,
           animType = "fade",
           time = 1)
    
    
    RCurl::getURL("https://bigdataforall.com/store/?key=shiny&graph=line&learnmore=TRUE",
                  .opts = RCurl::curlOptions(ssl.verifypeer = FALSE))
  })
  
  
  # Box #######
  
  
  
  output$box <- renderPlot({
    
    url <- paste0("https://bigdataforall.com/store/?key=shiny&graph=boxplot&input1=",
                  input$box_y,"&input2=",
                  input$box_x,
                  "&input3=",
                  input$box_color)
    
    RCurl::getURL(url,
                  .opts = RCurl::curlOptions(ssl.verifypeer = FALSE))
    
    data <- filter(data, Year >= input$box_filter[1],
             Year <= input$box_filter[2]) 
      
      data$Year <- as.factor(data$Year) 
      
      
    gg <- ggplot(data = data,
                 mapping = aes(x = data[,input$box_x],
                               y = data[,input$box_y],
                               group = data[,input$box_color],
                               fill = data[,input$box_color])) +
      geom_boxplot() +
      scale_x_continuous(labels = comma) +
      labs(title = paste("Box Plot:", 
                         input$box_x,
                         "&",
                         input$box_y,
                         "-", "Colored by",
                         input$box_color),
           y = input$box_y,
           x = input$box_x,
           fill = input$box_color)+
      theme_minimal()
    
    
    return(gg)
    
  })
  
  
  observe({
    toggle(id = "BoxText", 
           condition = input$checkBoxToggle,
           anim = TRUE,
           animType = "fade",
           time = 1)
    
    
    RCurl::getURL("https://bigdataforall.com/store/?key=shiny&graph=boxplot&learnmore=TRUE",
                  .opts = RCurl::curlOptions(ssl.verifypeer = FALSE))
  })
  
  
}



### Thank you for your interest

### Copyright Enzo Novi Migliano 2021 - You may use the App under MIT Lincense

##### Code to run the application ###########

# Run the application 
shinyApp(ui = ui, server = server)
