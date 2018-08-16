library(dataone)
library(datapack)

# Receiving a Data Package from the Repository ====
doi <- "doi:10.5063/F1Z036CP"
client <- D1Client("PROD", "urn:node:KNB")
# Get Data Package
pkg <- getDataPackage(client, doi)
getIdentifiers(pkg)
do <- getMember(pkg, getIdentifiers(pkg)[3])
csvtext <- rawToChar(getData(do))
dframe <- read.csv(textConnection(csvtext), stringsAsFactors = FALSE)
head(dframe)

## Uploading a Package to the repository ====
client <- D1Client("STAGING", "urn:node:mnTestARCTIC")

  data("co2") # Built-in dataset in R
write.csv(co2, "./co2.csv")

  my_object <- new("DataObject", 
                   filename = "./co2.csv",
                   format = "text/csv")

  uploadDataObject(client, my_object)
