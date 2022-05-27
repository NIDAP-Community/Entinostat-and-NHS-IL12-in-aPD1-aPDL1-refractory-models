Volcano_COMBO_NHS <- function(DEG_COMBO_NHS) {
    # image: png
    
   stattype<-"pval"

    if (FALSE & (("png" =='svg')))  {
        library(svglite)
        svglite::svglite(
        file="Volcano_COMBO_NHS.png",
        width=15,
        height=15,
        pointsize=1,
        bg="white",
    )}

    suppressMessages(library(ggplot2))
    suppressMessages(library(dplyr))
    suppressMessages(library(ggrepel))

    genesmat <- DEG_COMBO_NHS
    value_to_sort_the_output_dataset = "p-value"

    volcols<-colnames(genesmat)
    statcols<-volcols[grepl("logFC",volcols)]
    contrasts<-unique(gsub("_logFC","",statcols))
   
   
   
    Plots <- list()
    df_outs <- list()
    for(contrast in contrasts){
        print(paste0("Doing contrast: ",contrast))
        lfccol=paste0(contrast,"_logFC")
        pvalcol=paste0(contrast,"_",stattype)

        print(paste0("Fold change column: ",lfccol))
        print(paste0(stattype," column: ",pvalcol))
    
 

    no_genes_to_label <- 0
    if (value_to_sort_the_output_dataset=="fold-change") {
        genesmat %>% dplyr::arrange(desc(abs(genesmat[,lfccol]))) -> genesmat
    } else if (value_to_sort_the_output_dataset=="p-value") {
        genesmat %>% dplyr::arrange(genesmat[,pvalcol]) -> genesmat
    }
    print(paste0("Total number of genes included in volcano plot: ", nrow(genesmat)))
    if (TRUE){
        negative_log10_p_values <- -log10(genesmat[,pvalcol])
        ymax <- ceiling(max(negative_log10_p_values[is.finite(negative_log10_p_values)]))
    } else {
        ymax = 0
    }
    if (TRUE){
        xmax1 = ceiling(max(genesmat[,lfccol]))
        xmax2 = ceiling(max(-genesmat[,lfccol]))
        xmax=max(xmax1,xmax2)
    } else {
        xmax = 0
    }
   

    ## work with a list of genes
if (FALSE){
    gl <- trimws(unlist(strsplit(c("Csf1r, Csf2rb, Csf2rb2, Ccl9, Ccl6, Csf2ra, Csf3r, Cd86, H2-Ab1, H2-Aa, H2-Eb1, H2-Q7, Psmb8, Ciita, Cd8a, Cxcl9, Cd3d, Cd3e, Tap2, Psmb9, Nlrc5"), ",")), which=c("both"))
        ind <- match(gl, genesmat$Gene) # get the indices of the listed genes
        gene_list_ind <- c(1:no_genes_to_label,ind) # when list provided
        color_gene_label <- c(rep(c("black"), no_genes_to_label), rep(c("red"),length(ind)))
   }else if (TRUE){
        gl <- trimws(unlist(strsplit(c("Csf1r, Csf2rb, Csf2rb2, Ccl9, Ccl6, Csf2ra, Csf3r, Cd86, H2-Ab1, H2-Aa, H2-Eb1, H2-Q7, Psmb8, Ciita, Cd8a, Cxcl9, Cd3d, Cd3e, Tap2, Psmb9, Nlrc5"), ",")), which=c("both")) # unpack the gene list provided by the user and remove white spaces
        ind <- match(gl, genesmat$Gene) # get the indices of the listed genes
        gene_list_ind <- ind # when list provided
        color_gene_label <- rep(c("red"), length(ind))
    } else {
        if (no_genes_to_label>0) {
        gene_list_ind <- 1:no_genes_to_label # if no list provided label the number of genes given by the user
        color_gene_label <- rep(c("black"), no_genes_to_label)
        } else if (no_genes_to_label ==0) {
        gene_list_ind <-0
        }
        }   

## special nudge/repel of specific genes
if (TRUE){
    gn <- trimws(unlist(strsplit(c("Csf1r, Csf2rb, Csf2rb2, Ccl9, Ccl6, Csf2ra, Csf3r, Cd86, H2-Ab1, H2-Aa, H2-Eb1, H2-Q7, Psmb8, Ciita, Cd8a, Cxcl9, Cd3d, Cd3e, Tap2, Psmb9, Nlrc5"), ",")), which=c("both"))
    ind_gn <- match(gn, genesmat$Gene[gene_list_ind]) # get the indices of the listed genes
    nudge_x_all <- rep(c(0.2), length(genesmat$Gene[gene_list_ind]))
    nudge_y_all <- rep(c(0.2), length(genesmat$Gene[gene_list_ind]))
    nudge_x_all[ind_gn] <- c(3)
    nudge_y_all[ind_gn] <- c(0)
} else {
    nudge_x_all <- 3
    nudge_y_all <- 0
}
   
    ## flip contrast section
    flipVplot <- FALSE
        indc <- which(colnames(genesmat) == lfccol) # get the indice of the column that contains the contrast_logFC data

        if (length(indc)==0){
            print("Please rename the logFC column to include the contrast evaluated.")
        } else{
        old_contrast <- colnames(genesmat)[indc]
        }  
    # actually flip contrast
    if (flipVplot){
        # get the indice of the contrast to flip
        indcc <- match(old_contrast,colnames(genesmat)) 
        # create flipped contrast label
        splt1 <- strsplit(old_contrast, "_") # split by underline symbol to isolate the contrast name
        splt2 <- strsplit(splt1[[1]][1],"-") # split the contrast name in the respective components
        flipped_contrast <- paste(splt2[[1]][2], splt2[[1]][1],sep="-") #flip contrast name
        new_contrast_label <- paste(flipped_contrast, c("logFC"), sep = "_") 
        # rename contrast column to the flipped contrast
        colnames(genesmat)[indcc] <- new_contrast_label
        # flip the contrast data around y-axis
        genesmat[,indcc] <- -genesmat[indcc]
    } else{ new_contrast_label<- old_contrast}

    grm<-genesmat[,c(new_contrast_label,pvalcol)]
    grm[,"neglogpval"]<- -log10(genesmat[,pvalcol])
    colnames(grm)=c("FC","pval","neglogpval")
   # print(grm[gene_list_ind,])
    p <- ggplot(grm,
        aes_string(x = "FC", y ="neglogpval" ))+ # modified by RAS
        theme_classic() +
        geom_point(
            color='black',
            size = .5) +
        geom_vline(xintercept=c(-1,1), color='darkslategrey', alpha=1.0) + 
        geom_hline(yintercept=-log10(0.05), color='grey60', alpha=1.0) +  
        geom_point(
            data = grm[genesmat[,pvalcol] < 0.05,],
            color = 'lightgrey',
            size = .5) +
        geom_point(
            data = grm[genesmat[,pvalcol] < 0.05 & abs(grm[,"FC"])>1,], 
            color = 'plum4',
            size = .5) +
        geom_text_repel(
            data = grm[gene_list_ind,], 
           label = genesmat$Gene[gene_list_ind], 
            color = color_gene_label,
            fontface = 1,
            nudge_x = nudge_x_all,
            nudge_y = nudge_y_all,
            size = 3) +
        xlim(-xmax,xmax) +
        ylim(0,ymax) + xlab(new_contrast_label) +ylab(pvalcol)
        
        #print(p)
        Plots[[contrast]]=p
         filtered_genes =   genesmat$Gene[genesmat[,pvalcol] < 0.05 & abs(grm[,"FC"])>1]
    

        #print(filtered_genes)
        repeated_column = rep(contrast, length(filtered_genes))
        new_df <- data.frame(filtered_genes, repeated_column)
        names(new_df) <- c("Gene", "Contrast")

         df_out1 <- new_df
         df_outs[[contrast]]=df_out1
   

   }

   

   require(gridExtra)
   nplots=length(Plots)
 nrows=ceiling(nplots/ceiling(sqrt(nplots)))

 do.call("grid.arrange", c(Plots, nrow=nrows))
   print("done plotting")

    df_out <- unique(do.call("rbind", df_outs))

    return( df_out)
}

 

print("template_function_Volcano_COMBO_NHS.R #########################################################################")
library(plotly);library(ggplot2);library(jsonlite);
var_DEG_COMBO_NHS<-readRDS("var_DEG_COMBO_NHS.rds")
invisible(graphics.off())
var_Volcano_COMBO_NHS<-Volcano_COMBO_NHS(var_DEG_COMBO_NHS)
invisible(graphics.off())
saveRDS(var_Volcano_COMBO_NHS,"var_Volcano_COMBO_NHS.rds")
