Supp_Fig_5A_Part1 <- function(GSEA_Filtered_3) {
    # image: png
    suppressMessages(library(tidyr))
    suppressMessages(library(dplyr))
    suppressMessages(library(ggplot2))
    suppressMessages(library(stringr))
    suppressMessages(library(magrittr))
    goResults <- dplyr::collect(GSEA_Filtered_3)
    goResults <- as.data.frame(goResults)
    if(FALSE){
    goResults %>% top_n(10, wt=-log(padj)) %>% 
        mutate(hitsPerc=fraction_leadingEdge*100) %>%
        arrange(-log(padj)) -> goResults} 
    else{
    #var1 <- goResults %>% dplyr::slice(c(1:10)) 
    #print(dim(var1))
    #var2 <- var1 %>% mutate(hitsPerc=fraction_leadingEdge*100) 
    #print(dim(var2))
    #goResults <- var2 %>% arrange(-log(padj)) 
    #print(dim(goResults))

    goResults %>% dplyr::slice(c(1:10)) %>% 
        mutate(hitsPerc=fraction_leadingEdge*100) %>% arrange(-log(padj)) -> goResults
    
    }
    xmin = floor(min(goResults$hitsPerc)-5)
    xmax = ceiling(max(goResults$hitsPerc)+5) 
    sizemax = ceiling(max(goResults$size_leadingEdge)/10)*10  
    goResults %>% mutate(pathwayname2 = str_replace_all(pathway, "_", " ")) -> goResults
    goResults$pathwayname2 <- str_to_upper(goResults$pathwayname2)
    goResults %>% mutate(pathwayname2 = stringr::str_wrap(pathwayname2,30)) -> goResults
    goResults %>% mutate(percorder = order(goResults$hitsPerc)) -> goResults
    goResults$pathwayname2 <- factor(goResults$pathwayname2, levels = goResults$pathwayname2[goResults$percorder])

    print(class(goResults$pathwayname2))
    minp = min(goResults$pval) - 0.1*min(goResults$pval)
    maxp = max(goResults$pval) + 0.1*max(goResults$pval)
    gplot <- goResults %>% 
               ggplot(aes(x=hitsPerc,
               y=pathwayname2, 
               colour=padj, 
               size=size_leadingEdge)) +
        geom_point() +
        theme_classic() +
        theme(text = element_text(size=20)) +
        xlim(xmin,xmax) +
        expand_limits(colour = seq(minp, maxp, by = 10),
                size = seq(0, sizemax,by=10)) +
        theme(legend.position = "right", legend.key.height = unit(1, "cm")) +
        labs(x="Hits (%)", y="Pathway", colour="p value", size="Count") +
        theme(axis.title.x = element_text(size = rel(1.2)),axis.title.y = element_text(size = rel(1.2)))
    print(gplot)
    return(goResults)   
}

#################################################
## Global imports and functions included below ##
#################################################

# Functions defined here will be available to call in
# the code for any table.

print("template_function_Supp_Fig_5A_Part1.R #########################################################################")
library(plotly);library(ggplot2);library(jsonlite);
var_GSEA_Filtered_3<-readRDS("var_GSEA_Filtered_3.rds")
invisible(graphics.off())
var_Supp_Fig_5A_Part1<-Supp_Fig_5A_Part1(var_GSEA_Filtered_3)
invisible(graphics.off())
saveRDS(var_Supp_Fig_5A_Part1,"var_Supp_Fig_5A_Part1.rds")
