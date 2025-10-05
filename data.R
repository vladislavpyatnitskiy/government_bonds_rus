library(rvest)

smartlab.gov.bond <- function(x){ # Get data for Russian government bonds
  
  D <- NULL
  
  for (n in 1:length(x)){
    
    l <- read_html(sprintf("https://smart-lab.ru/q/bonds/%s/", x[n])) %>%
      html_nodes("article") %>% html_nodes("div") %>% html_nodes("div") %>%
      html_text()
    
    l <- gsub('["\n"]', '', gsub('["\t"]', '',l)) # Clean and assign data
    
    L <- cbind.data.frame(
      l[seq(from = 2, to = length(l), by = 3)],
      l[seq(from = 3, to = length(l), by = 3)]
    )
    
    L <- L[c(-18, -27, -31),] # Reduce empty rows
    
    v <- L[,1] # Save values for row names
    
    L <- as.data.frame(L[,-1])
    
    rownames(L) <- v # Assign row names
    colnames(L) <- x[n]
    
    if (is.null(D)) D <- L else D <- cbind(D, L) } # Merge
  
  D # Output
}
smartlab.gov.bond(c("SU26229RMFS3", "SU26219RMFS4")) # Test
