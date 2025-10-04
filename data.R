library(rvest)

smartlab.gov.bond <- function(x){
  
  l <- read_html(sprintf("https://smart-lab.ru/q/bonds/%s/", x)) %>%
    html_nodes("article") %>% html_nodes("div") %>% html_nodes("div") %>%
    html_text()
  
  l <- gsub('["\n"]', '', gsub('["\t"]', '',l))
  
  L <- cbind.data.frame(
    l[seq(from = 2, to = length(l), by = 3)],
    l[seq(from = 3, to = length(l), by = 3)]
  )
  
  L <- L[c(-18, -27, -31),]
  
  v <- L[,1]
    
  L <- as.data.frame(L[,-1])
  
  rownames(L) <- v
  
  colnames(L) <- x
  
  L
}
smartlab.gov.bond("SU26229RMFS3")
