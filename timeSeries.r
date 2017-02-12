require(gdata)
#OSX index
#df = read.xls ("c:/users/ivarb/Downloads/data (5).xlsx", header = FALSE)
#dateso = as.Date(rev((df$V1)),"%d.%m.%Y")
#ots = rev((as.numeric(df$V2)))

a = matrix("", 4, 3)
a[1, ] = c("NORTH", "North Energy", "2017/1/20")
a[2, ] = c("OLT", "Olav Thon", "2017/1/27")
a[3, ] = c("STB", "Storebrand", "2016/12/23")
a[4, ] = c("SNI", "Stoelt-Nilsen", "2016/11/18")

for (i in 1:dim(a)[1]) {
  URLtxt <- paste("http://ichart.finance.yahoo.com/table.csv?s=",a[i,1],".OL",sep="")
  dat <- read.csv(url(URLtxt))
  dates <- rev(as.Date(dat$Date, "%Y-%m-%d"))
  introDate = as.Date(a[i,3])
  ts = rev((as.numeric(dat$Close)))
  
  l = length(ts)
  lo = length(ots)
  sq = seq(l - 80, l - 1)
  sqo = seq(lo - 80 - 1, lo - 2)
  sqo = sqo
  dates=dates[sq]
  ratio = ts[sq] / ots[sqo]
  ratio = ratio / ratio[1]
  pdf(paste(a[i,2],".pdf",sep=""))
    plot(
    ratio,
    xaxt = 'n',
    xlab = "dag i måned",
    ylab = "kr",
    main = paste(a[i,2:3])
  )
  redIdx = which(dates==introDate)
  points(redIdx,ratio[redIdx],col="red")
  axis(1,
       at = 1:length(sq),
       labels = format(dates, "%d"))
  dev.off()
}
