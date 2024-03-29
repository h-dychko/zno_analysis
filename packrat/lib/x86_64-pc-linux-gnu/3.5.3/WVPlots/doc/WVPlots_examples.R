## ----echo=FALSE----------------------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.height=6)

## ------------------------------------------------------------------------
set.seed(34903490)
x = rnorm(50)
y = 0.5*x^2 + 2*x + rnorm(length(x))
frm = data.frame(x=x,y=y,yC=y>=as.numeric(quantile(y,probs=0.8)))
frm$absY <- abs(frm$y)
frm$posY = frm$y > 0

## ------------------------------------------------------------------------
WVPlots::ScatterHist(frm, "x", "y", title="Example Fit")

## ------------------------------------------------------------------------
WVPlots::ScatterHist(frm, "x", "y", smoothmethod="lm", 
                     title="Example Linear Fit", estimate_sig = TRUE)

## ------------------------------------------------------------------------
WVPlots::ScatterHist(frm, "x", "y", smoothmethod="identity", 
                     title="Example Relation Plot", estimate_sig = TRUE)

## ------------------------------------------------------------------------
set.seed(34903490)
fmScatterHistC = data.frame(x=rnorm(50),y=rnorm(50))
fmScatterHistC$cat <- fmScatterHistC$x+fmScatterHistC$y>0
WVPlots::ScatterHistC(fmScatterHistC, "x", "y", "cat", title="Example Conditional Distribution")

## ------------------------------------------------------------------------
set.seed(34903490)
frmScatterHistN = data.frame(x=rnorm(50),y=rnorm(50))
frmScatterHistN$z <- frmScatterHistN$x+frmScatterHistN$y
WVPlots::ScatterHistN(frmScatterHistN, "x", "y", "z", title="Example Joint Distribution")

## ------------------------------------------------------------------------
WVPlots::BinaryYScatterPlot(frm, "x", "posY", use_glm=FALSE,
                            title="Example 'Probability of Y' Plot (ggplot2 smoothing)")

WVPlots::BinaryYScatterPlot(frm, "x", "posY", use_glm=TRUE, 
                            title="Example 'Probability of Y' Plot (GLM smoothing)")

## ------------------------------------------------------------------------
if(requireNamespace("hexbin", quietly = TRUE)) {
  set.seed(5353636)
  
  df = rbind(data.frame(x=rnorm(1000, mean = 1), y=rnorm(1000, mean = 1, sd = 0.5 )),
             data.frame(x = rnorm(1000, mean = -1, sd = 0.5), y = rnorm(1000, mean = -1, sd = 0.5)))
  
  print(WVPlots::HexBinPlot(df, "x", "y", "Two gaussians"))
}


## ------------------------------------------------------------------------
set.seed(34903490)
y = abs(rnorm(20)) + 0.1
x = abs(y + 0.5*rnorm(20))

frm = data.frame(model=x, value=y)

frm$costs=1
frm$costs[1]=5
frm$rate = with(frm, value/costs)

frm$isValuable = (frm$value >= as.numeric(quantile(frm$value, probs=0.8)))


## ------------------------------------------------------------------------
WVPlots::GainCurvePlot(frm, "model", "value", title="Example Continuous Gain Curve")

## ------------------------------------------------------------------------

gainx = 0.10  # get the top 10% most valuable points as sorted by the model

# make a function to calculate the label for the annotated point
labelfun = function(gx, gy) {
  pctx = gx*100
  pcty = gy*100
  
  paste("The top ", pctx, "% most valuable points by the model\n",
        "are ", pcty, "% of total actual value", sep='')
}

WVPlots::GainCurvePlotWithNotation(frm, "model", "value", 
                                   title="Example Gain Curve with annotation", 
                          gainx=gainx,labelfun=labelfun) 



## ------------------------------------------------------------------------
WVPlots::GainCurvePlotC(frm, "model", "costs", "value", title="Example Continuous Gain CurveC")

## ------------------------------------------------------------------------
WVPlots::ROCPlot(frm, "model", "isValuable", TRUE, title="Example ROC plot")

## ------------------------------------------------------------------------
set.seed(34903490)
x1 = rnorm(50)
x2 = rnorm(length(x1))
y = 0.2*x2^2 + 0.5*x2 + x1 + rnorm(length(x1))
frmP = data.frame(x1=x1,x2=x2,yC=y>=as.numeric(quantile(y,probs=0.8)))
# WVPlots::ROCPlot(frmP, "x1", "yC", TRUE, title="Example ROC plot")
# WVPlots::ROCPlot(frmP, "x2", "yC", TRUE, title="Example ROC plot")
WVPlots::ROCPlotPair(frmP, "x1", "x2", "yC", TRUE, title="Example ROC pair plot")

## ------------------------------------------------------------------------
WVPlots::PRPlot(frm, "model", "isValuable", TRUE, title="Example Precision-Recall plot")

## ------------------------------------------------------------------------
WVPlots::DoubleDensityPlot(frm, "model", "isValuable", title="Example double density plot")

## ------------------------------------------------------------------------
WVPlots::DoubleHistogramPlot(frm, "model", "isValuable", title="Example double histogram plot")

## ------------------------------------------------------------------------
set.seed(34903490)

# discrete variable: letters of the alphabet
# frequencies of letters in English
# source: http://en.algoritmy.net/article/40379/Letter-frequency-English
letterFreqs = c(8.167, 1.492, 2.782, 4.253, 12.702, 2.228,
                2.015, 6.094, 6.966, 0.153, 0.772, 4.025, 2.406, 6.749, 7.507, 1.929,
                0.095, 5.987, 6.327, 9.056, 2.758, 0.978, 2.360, 0.150, 1.974, 0.074)
letterFreqs = letterFreqs/100
letterFrame = data.frame(letter = letters, freq=letterFreqs)

# now let's generate letters according to their letter frequencies
N = 1000
randomDraws = data.frame(draw=1:N, letter=sample(letterFrame$letter, size=N, replace=TRUE, prob=letterFrame$freq))

WVPlots::ClevelandDotPlot(randomDraws, "letter", title = "Example Cleveland-style dot plot")
WVPlots::ClevelandDotPlot(randomDraws, "letter", limit_n = 10,  title = "Top 10 most frequent letters")
WVPlots::ClevelandDotPlot(randomDraws, "letter", sort=0, title="Example Cleveland-style dot plot, unsorted")
WVPlots::ClevelandDotPlot(randomDraws, "letter", sort=1, stem=FALSE, title="Example with increasing sort order + coord_flip, no stem") + ggplot2::coord_flip()


## ------------------------------------------------------------------------
set.seed(34903490)
N = 1000
ncar_vec = 0:5
prob = c(1.5, 3, 3.5, 2, 1, 0.75); prob = prob/sum(prob)

df = data.frame(num_cars = sample(ncar_vec, size = N, replace = TRUE, prob=prob))
WVPlots::ClevelandDotPlot(df, "num_cars", sort = 0, title = "Distribution of household vehicle ownership")
              


## ------------------------------------------------------------------------
set.seed(354534)
N = 100

# rough proportions of eye colors
eprobs = c(0.37, 0.36, 0.16, 0.11)

eye_color  = sample(c("Brown", "Blue", "Hazel", "Green"), size = N, replace = TRUE, prob = eprobs)
sex = sample(c("Male", "Female"), size = N, replace = TRUE)

# A data frame of eye color by sex
dframe = data.frame(eye_color = eye_color, sex = sex)

WVPlots::ShadowPlot(dframe, "eye_color", "sex", title = "Shadow plot of eye colors by sex")


## ------------------------------------------------------------------------
set.seed(354534)
N = 100

dframe = data.frame(x = rnorm(N), gp = "region 2", stringsAsFactors = FALSE)
dframe$gp = with(dframe, ifelse(x < -0.5, "region 1", 
                                ifelse(x > 0.5, "region 3", gp)))

WVPlots::ShadowHist(dframe, "x", "gp", title = "X values by region")


## ------------------------------------------------------------------------
ngp = length(unique(dframe$gp))

WVPlots::ShadowHist(dframe, "x", "gp", title = "X values by region", palette = NULL) + 
  ggplot2::scale_fill_manual(values = rep("darkblue", ngp))

## ------------------------------------------------------------------------
classes = c("a", "b", "c")
means = c(2, 4, 3)
names(means) = classes
label = sample(classes, size=1000, replace=TRUE)
meas = means[label] + rnorm(1000)
frm2 = data.frame(label=label,
                  meas = meas)

WVPlots::ScatterBoxPlot(frm2, "label", "meas", pt_alpha=0.2, title="Example Scatter/Box plot")
WVPlots::ScatterBoxPlotH(frm2, "meas", "label",  pt_alpha=0.2, title="Example Scatter/Box plot")

## ------------------------------------------------------------------------
frmx = data.frame(x = rbinom(1000, 20, 0.5))
WVPlots::DiscreteDistribution(frmx, "x","Discrete example")

## ------------------------------------------------------------------------
set.seed(52523)
d <- data.frame(wt=100*rnorm(100))
WVPlots::PlotDistCountNormal(d,'wt','example')
WVPlots::PlotDistDensityNormal(d,'wt','example')

## ------------------------------------------------------------------------
y = c(1,2,3,4,5,10,15,18,20,25)
x = seq_len(length(y))
df = data.frame(x=x,y=y)

WVPlots::ConditionalSmoothedScatterPlot(df, "x", "y", NULL, title="centered smooth, one group")
WVPlots::ConditionalSmoothedScatterPlot(df, "x", "y", NULL, title="left smooth, one group", align="left")
WVPlots::ConditionalSmoothedScatterPlot(df, "x", "y", NULL, title="right smooth, one group", align="right")

n = length(x)
df = rbind(data.frame(x=x, y=y+rnorm(n), gp="times 1"),
           data.frame(x=x, y=0.5*y + rnorm(n), gp="times 1/2"),
           data.frame(x=x, y=2*y + rnorm(n), gp="times 2"))

WVPlots::ConditionalSmoothedScatterPlot(df, "x", "y", "gp", title="centered smooth, multigroup")
WVPlots::ConditionalSmoothedScatterPlot(df, "x", "y", "gp", title="left smooth, multigroup", align="left")
WVPlots::ConditionalSmoothedScatterPlot(df, "x", "y", "gp", title="right smooth, multigroup", align="right")

## ------------------------------------------------------------------------
set.seed(52523)
d = data.frame(meas=rnorm(100))
threshold = -1.5
WVPlots::ShadedDensity(d, "meas", threshold, 
                       title="Example shaded density plot, left tail")
WVPlots::ShadedDensity(d, "meas", -threshold, tail="right", 
                       title="Example shaded density plot, right tail")


## ------------------------------------------------------------------------
set.seed(52523)
d = data.frame(meas=rnorm(100))
# first and third quartiles of the data (central 50%)
boundaries = quantile(d$meas, c(0.25, 0.75))
WVPlots::ShadedDensityCenter(d, "meas", boundaries, 
                       title="Example center-shaded density plot")


