##Introduction to R and RStudio

### The working metaphor

Scientists are **data journalists** who tell stories of their data.     
They type text to instruct a *human* reader how to recreate the story his/her mind.  
They type text to instruct a *copmuter* how to manipulate data, evaluate models, print graphs, and  assemble output.   

**Documents** that contain typed instructions for both human and computer consumption that recreate a story about the data are called **DYNAMIC**.

See an example of a dynamic document in this [markdown simulator](https://demo.ocpu.io/markdownapp/www/), created in javascript by  [Jeroen Ooms](http://jeroenooms.github.io/). 

**markdown** language uses special combinations of characters to make text strings appear differently: in bold, italics, as a heading, or as a name of the column in the table. This language is very simple and straightforward, but may take a little bid to get used to. To help you get proficient with markdown consider some of the following resources.  

- [markdown guide](http://daringfireball.net/projects/markdown/) : a well-written "breaking into" guide. Gives ample verbal description. Recommended for newbies. By John Gruber.  
- [markdown cheet-sheet](http://support.mashery.com/docs/customizing_your_portal/Markdown_Cheat_Sheet) : brief, simple, parallel view of what the code is doing.By Mashery group.   
- [markdown in R](http://jeromyanglim.blogspot.ca/2012/05/getting-started-with-r-markdown-knitr.html) : a blog entry on getting started with **rmarkdown** - a version of markdown enchanced for the use with RStudio.  By Jeromy Anglim.


You will need markdown to complete homework assignments and we won't spend any dedicated lab time on it, so please, pick it up on your own. 


### Goals in Data Science projects
Adapting reproducible research standards, each project in data science could be conceptualized as having the following objectives:  

- **Strategic Goal**   
Tell a *story about your data*. 

- **Tactical Goal**  
Develop, evaluate, and interpret statistical models with which you tell a *story about your data*.

- **Technical Assignment**  
Write a computer script that generates an electronic document reporting the statistical models with which you tell a *story about your data*.


We'll have the total of **8 LABS**:  
  
  Date|Week|Class | Topic   
-------|----|------|--
  08 Jan | 1  |2 |**Lab 1** : Introduction to R   
15 Jan | 2  |4 |**Lab 2** : Matrix algebra: basic operations   
22 Jan | 3  |6 |**Lab 3** : Matrix Algebra to GLM     
29 Jan | 4  |8 |**Lab 4** : Eigenvalues, decomposition, & inverses  
05 Feb | 5  |10|**Lab 5** : Exploratory Data Analysis a& data screening  
---|---|---|---
  26 Feb | 8  |14|**Lab 6** : Exploratory Factor Analysis (Common factor model)
12 Mar | 10 |18|**Lab 7** : Confirmatory Factor Analysis
26 Mar | 12  |22|**Lab 8** : Structural Equation Modeling

As you see, the stories we'll tell will be technical: they will involve matrices and vectors, their transposes and inversions, decompositions, and projections. **markdown** will help us style text for human consumption, but all the instructions to the computer about what to do with matrices, datasets, and other objects will be given in  **R language**.  

Learning enough **R language** in order to work with statistical models of multivariate data is the purpose of these 8 labs. 

### Learning R 

[A GOOD PLACE TO START LEARNING R](http://www.rstudio.com/resources/training/online-learning/) - terrific resouce by RStudio team collects the best online resources. Check out every link they mention, it's worth it. In fact, do it right now. 

Now we'll use one of the resources mentioned in the link above, [swirl](http://swirlstats.com/students.html).  
Open your RStudio and execute the following code:  

```
install.packages("swirl")  
install.packages("Rtools")  
install.packages("devtools")  
devtools::install_github(c("swirldev/swirl", "swirldev/swirlify"))  
library(swirlify)  
```

Follow the prompt and complete the first lesson.


### FOR INSPIRATION:  
  
  Working with data is becoming its own science:    
  - [Coursera](https://www.coursera.org/specialization/jhudatascience/1)  
- [DataCamp](https://www.datacamp.com/)  
- [O'Reilly](http://shop.oreilly.com/product/0636920034834.do)  
   
   It's also becoming a high art:  
     - [Bostock](http://bost.ocks.org/mike/)  
   - [D3](https://github.com/mbostock/d3/wiki/Gallery)  