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

# Extract the Data from ncobject
merraMB <- ncvar_get(nc,"mb")
merraMBmat1980 <- merraMB[1:720,1:361,1]
merraLon <- ncvar_get(nc,"lon")
merraLat <- ncvar_get(nc,"lat")
merraTime <- ncvar_get(nc,"time")

# View the Massbalance data for 1980
image(merraLon, merraLat,merraMBmat1980, col=terrain.colors(100),axes=TRUE)
contour(merraLon, merraLat,merraMBmat1980, levels=seq(min(merraMBmat1980), max(merraMBmat1980), by=5), add=TRUE, col="black")

# Just Get Greenland
GreenlandLon <- which(merraLon > 275)
GreenlandLat <- which(merraLat>50)
merraMB1980Greenland <- merraMB[GreenlandLon,GreenlandLat,1]
image(merraLon[GreenlandLon], merraLat[GreenlandLat],merraMB1980Greenland, col=terrain.colors(100),axes=TRUE)
title("Surface Mass Balance")
# Image T2 for Greenland
image(merraLon[GreenlandLon], merraLat[GreenlandLat],merraT2[GreenlandLon,GreenlandLat,1], col=heat.colors(100),axes=TRUE)
title('2m Air Temperature')