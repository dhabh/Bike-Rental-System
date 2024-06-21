wd<-"/Users/Dhanush/OneDrive/Desktop/Eng Data Analytics"
setwd(wd)
getwd()
daybikedata <- read.csv("day.csv")
View(daybikedata)
str(daybikedata)
colSums(is.na(daybikedata))
daybikedata$temp <- daybikedata$temp*100
daybikedata$atemp <- daybikedata$atemp*100
colnames(daybikedata)[10] <- "Temp(°C)"
colnames(daybikedata)[11] <- "atemp(°C)"
colnames(daybikedata)[12] <- "hum(%)"
colnames(daybikedata)[13] <- "windspeed(mph)"
daybikedata$`hum(%)` <- daybikedata$`hum(%)`*100
daybikedata$`windspeed(mph)`<- daybikedata$`windspeed(mph)`*100

##########################################
wd<-"/Users/Dhanush/OneDrive/Desktop/Eng Data Analytics"
setwd(wd)
getwd()
hrbikedata <- read.csv("hour.csv")
View(hrbikedata)
str(hrbikedata)
colSums(is.na(hrbikedata))
hrbikedata$temp <- hrbikedata$temp*100
hrbikedata$atemp <- hrbikedata$atemp*100
colnames(hrbikedata)[11] <- "Temp(°C)"
colnames(hrbikedata)[12] <- "atemp(°C)"
colnames(hrbikedata)[13] <- "hum(%)"
colnames(hrbikedata)[14] <- "windspeed(mph)"
hrbikedata$`hum(%)` <- hrbikedata$`hum(%)`*100
hrbikedata$`windspeed(mph)`<- hrbikedata$`windspeed(mph)`*100
##############correlation matrix#########################

# Select relevant columns
selected_cols <- c("Temp(°C)", "atemp(°C)", "hum(%)", "windspeed(mph)", "cnt", "weathersit")
subset_data <- daybikedata[, selected_cols]
colnames(daybikedata)
# Calculate correlation matrix
correlation_matrix <- cor(subset_data)

# Load the corrplot package
#install.packages("corrplot")  # Uncomment and run if you haven't installed corrplot
library(corrplot)
# Plot the correlation matrix
corrplot(correlation_matrix, type = "upper")
corrplot.mixed(correlation_matrix)
##################Linear regression#############################

B1 <- cov(daybikedata$`Temp(°C)`, daybikedata$cnt)/var(daybikedata$`Temp(°C)`)
B1
B0 <- mean(daybikedata$cnt) - B1 * mean(daybikedata$`Temp(°C)`)
B0

# rentals = 1214.642 + 66.4 * temperature

bikes_mod1 <- lm(data = daybikedata, cnt ~ `Temp(°C)`)
bikes_mod1
summary(bikes_mod1)
###############################################################################
# Multiple linear regression
bikes_mod2 <- lm(data = daybikedata, cnt ~   `hum(%)` + `windspeed(mph)`+ `Temp(°C)` )
summary(bikes_mod2)
##########################Multiple regression###############################

# Convert weathersit to a factor with appropriate levels
levels(daybikedata$weathersit) <- c("clear", "mist", "light rain", "heavy rain")
daybikedata$weathersit <- as.factor(daybikedata$weathersit)
#daybikedata$holiday <- as.factor(daybikedata$holiday)
#daybikedata$workingday <- as.factor(daybikedata$workingday)
# Multiple linear regression with weathersit included
bikes_mod_with_weather <- lm(cnt ~ `hum(%)` + `windspeed(mph)`+ `Temp(°C)` + weathersit, data = daybikedata)

# Display summary of the model
summary(bikes_mod_with_weather)



##########################Logistic Regression###############################

# You may need to adjust this based on the actual structure of your dataset
# Assuming 'cnt' is the original count variable in your dataset
str(daybikedata)
# Create a binary outcome variable
daybikedata <- daybikedata %>%
  mutate(bike_rental = ifelse(cnt > 0, 1, 0))

selected_cols <- c("weathersit", "Temp(°C)", "hum(%)", "windspeed(mph)", "bike_rental")
model_data <- daybikedata[, selected_cols]
logistic_model <- glm(bike_rental ~  weathersit, 
                      data = model_data, family = "binomial", maxit = 1000)
summary(logistic_model)
#weathersit + `hum(%)` + `windspeed(mph)`+ `Temp(°C)` 

###################################Final Version################################################
# Assuming your dataset is loaded into a DataFrame called bike_data
# Make sure to replace the column names and data preparation steps with your actual dataset

# Create a binary outcome variable based on the threshold
daybikedata$rental_category <- ifelse(daybikedata$cnt > 4000, 1, 0)

# Select relevant features (independent variables)
features <- c('season', 'yr', 'mnth', 'holiday', 'weekday', 'workingday',
              'weathersit', "Temp(°C)", "atemp(°C)", "hum(%)", "windspeed(mph)")

X <- daybikedata[, features]
y <- daybikedata$rental_category
daybikedata$dteday <- as.Date(daybikedata$dteday)
# Split the dataset into training and testing sets
set.seed(1234)  # Set seed for reproducibility
split_index <- sample(1:nrow(daybikedata), 0.8 * nrow(daybikedata))
train_data <- daybikedata[split_index, ]
test_data <- daybikedata[-split_index, ]



# Fit a logistic regression model
logistic_model <- glm(rental_category ~ ., data = train_data, family = binomial, maxit=1000)

# Make predictions on the test set
predictions <- predict(logistic_model, newdata = test_data, type = "response")

# Convert probabilities to binary predictions using the threshold
threshold <- 0.5
binary_predictions <- ifelse(predictions > threshold, 1, 0)

# Model evaluation
conf_matrix <- table(binary_predictions, test_data$rental_category)
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
cat("Accuracy:", accuracy, "\n")
print(conf_matrix)

# Get coefficients
coefficients <- coef(logistic_model)

# Display coefficients
print(coefficients)
##############################################################################

# Create a binary outcome variable based on the adjusted threshold
daybikedata$rental_category <- ifelse(daybikedata$cnt > 3000, 1, 0)  # Adjust threshold as needed

# Select relevant features (independent variables)
features <- c('holiday', 'weekday', 'workingday',
              'weathersit', "Temp(°C)", "hum(%)", "windspeed(mph)")

X <- daybikedata[, features]
y <- daybikedata$rental_category
daybikedata$dteday <- as.Date(daybikedata$dteday)

# Split the dataset into training and testing sets
set.seed(1234)  # Set seed for reproducibility
split_index <- sample(1:nrow(daybikedata), 0.8 * nrow(daybikedata))
train_data <- daybikedata[split_index, ]
test_data <- daybikedata[-split_index, ]

# Fit a logistic regression model
logistic_model <- glm(rental_category ~ . - season - yr - mnth - instant - dteday - casual - registered - cnt - `atemp(°C)`, 
                      data = train_data, family = binomial)

# Make predictions on the test set
predictions <- predict(logistic_model, newdata = test_data, type = "response")

# Convert probabilities to binary predictions using the threshold
threshold <- 0.5
binary_predictions <- ifelse(predictions > threshold, 1, 0)

# Model evaluation
conf_matrix <- table(binary_predictions, test_data$rental_category)
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
cat("Accuracy:", accuracy, "\n")
print(conf_matrix)

# Get coefficients (excluding specified variables)
coefficients <- coef(logistic_model)
print(coefficients)
summary(logistic_model)

############################################################################################################
#KNN
# Assuming daybikedata is your dataset

# Load necessary libraries
#install.packages(c("dplyr", "class"))  # Uncomment and run if you haven't installed these packages
library(dplyr)
library(class)

# Select relevant variables for KNN
knn_data <- daybikedata %>%
  select(`Temp(°C)`,`hum(%)`,`windspeed(mph)`,cnt)  # Adjust variable names as needed

# Create a categorical variable for demand based on count
knn_data$demand_category <- cut(knn_data$cnt, breaks = c(-Inf, 100, 500, Inf), labels = c("low", "medium", "high"))

# Select features for classification
features <- knn_data %>%
  select(`Temp(°C)`,`hum(%)`,`windspeed(mph)`)

# Select target variable for classification
target <- knn_data$demand_category

# Split the data into training and testing sets
set.seed(1234)  # Set seed for reproducibility
indices <- sample(1:nrow(knn_data), 0.8 * nrow(knn_data))  # 80% for training, 20% for testing
train_data <- knn_data[indices, ]
test_data <- knn_data[-indices, ]


#################################################
#install.packages("caret")  # Uncomment and run if you haven't installed caret
library(caret)

features <- knn_data %>%
  select(`Temp(°C)`, `hum(%)`, `windspeed(mph)`)
target <- knn_data$demand_category

# Set up the training control
ctrl <- trainControl(method = "cv", number = 5)

# Specify the tuning grid
tune_grid <- expand.grid(k = c(1, 3, 5, 7, 9))

# Train the KNN model with cross-validation
knn_model_cv <- train(target ~ ., data = features, method = "knn",
                      trControl = ctrl, tuneGrid = tune_grid)

# Display the results
print(knn_model_cv)
#########################################################

# Train the KNN model
k_value <- 5  # Set the value of k (number of neighbors)
knn_model <- knn(train = as.matrix(train_data[, c("Temp(°C)", "hum(%)", "windspeed(mph)")]),
                 test = as.matrix(test_data[, c("Temp(°C)", "hum(%)", "windspeed(mph)")]),
                 cl = train_data$demand_category,
                 k = k_value)

# Evaluate the model on the test set
conf_matrix <- table(knn_model, test_data$demand_category)
print(conf_matrix)

# Calculate accuracy
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
cat("Accuracy:", accuracy, "\n")

