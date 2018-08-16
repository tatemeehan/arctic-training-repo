# library(chron)
# library(RColorBrewer)
# library(lattice)
library(ncdf4)

## Let's Read NetCDF! ====
dataDir = "E:\\ArcticDataCenter\\Data\\Birkle"
fileName = "\\merra_t2_1979-2012_monthly.nc"
fullFile = paste0(dataDir,fileName)
merraT2nc <- nc_open(fullFile,write=FALSE)
merraT2 <- ncvar_get(merraT2nc)

# merraMBurl <- "https://cn.dataone.org/cn/v2/resolve/urn:uuid:b5171497-ee68-4928-8318-364a53064823"
# tmp = tempfile()
### Problems with download.file on windows
# download.file(merraMBurl,destfile = file.path(dataDir,'test.nc'),mode = 'wb')
# merraMBnc <-  nc_open((merraMBurl))
# merraMB <- ncvar_get(merraMBnc)
# nc_open(tmp)

### using httr ## This Works for Windows! ----
merraMBurl <- "https://cn.dataone.org/cn/v2/resolve/urn:uuid:b5171497-ee68-4928-8318-364a53064823"
tmp = tempfile()
x <- httr::GET(merraMBurl)
content <- httr::content(x)
writeBin(content,tmp)
nc <- ncdf4::nc_open(tmp)