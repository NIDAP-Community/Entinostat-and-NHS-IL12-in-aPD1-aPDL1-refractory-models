Figure_4I_Final <- function(DEG_All_Contrasts) {
    
    ## --------- ##
    ## Libraries ##
    ## --------- ##

    library(l2p)
    library(l2psupp)
    library(dplyr)
    library(magrittr)
    library(tidyverse)
    library(ggplot2)
    library(stringr)
    library(RCurl)
    
    detachAllPackages <- function() {
        basic.packages <- c("package:stats","package:graphics","package:grDevices","package:utils","package:datasets","package:methods","package:base","package:SparkR","package:vector","package:jsonlite", "package:FoundrySparkR","package:futile.logger","package:uuid")
        package.list <- search()[ifelse(unlist(gregexpr("package:",search()))==1,TRUE,FALSE)]
        package.list <- setdiff(package.list,basic.packages)
        if (length(package.list)>0)  for (package in package.list) detach(package, character.only=TRUE)
        packages <- gsub("package:","",package.list)
        tidypackage <- c("ggplot2","tidyr","stringr","readr","forcats","dplyr","purrr","tibble")
        if(sum(packages == "tidyverse")==1){
                packages <- packages[!packages %in% tidypackage]
        }
        #print(packages)
        for(i in seq_along(packages)){
            #print(packages[i])
            attachNamespace(packages[i])
        }
    }

    detachAllPackages()

    ## -------------------------------- ##
    ## User-Defined Template Parameters ##
    ## -------------------------------- ##

    df <- DEG_All_Contrasts 
    gene_name_column <- "Gene"
    column_used_to_rank_genes <- c("COMBO-PBS_tstat")[1]
    choose_upregulated_genes = TRUE
    gene_set_sources_to_include <- c("GO","KEGG")
    organism = "Mouse"
    select_by_rank <- TRUE
    select_top_percentage_of_genes <- FALSE
    select_top_genes <- 1341
    use_built_in_gene_universe <- FALSE
    p_value_cutoff <- 0.05
    min_hit_count <- 5
    y_axis_labels_size <- 10
    plot_top_pathways <- TRUE
    pathways_to_use <- c()
    plot_bubble_size <- "number of hits"  
    plot_bubble_color <- "Fisher's Exact pval"
    bubble_colors <- "blues"
    sort_bubble_plot_by <- "percent gene hits per pathway"
    number_of_pathways_to_plot <- 10 
    p_value_column <- c()[1]
    p_value_threshold <- 0.001
    fold_change_column <- c()[1]
    fold_change_threshold <- 1.19
    fold_change_column_in_log_units <- TRUE

    ##--------------- ##
    ## Error Messages ##
    ## -------------- ##

    if(plot_top_pathways == FALSE & length(pathways_to_use) == 0){
        stop("ERROR: Enter at least one pathway in 'Pathways to use' when 'Plot top pathways' is set to FALSE")
    }

    ## --------- ##
    ## Functions ##
    ## --------- ##

    return_org_genes <- function(l2pout){
        l2pgenes <- as.list(l2pout$genesinpathway)
        l2pgenes <- lapply(l2pgenes, function(x) unlist(strsplit(x," ")))
        l2pgenesnew <- lapply(l2pgenes,function(a) o2o(a,"human",organism))
        l2pout$org_genes <- l2pgenesnew
        l2pout$org_genes <- sapply(l2pout$org_genes, paste, collapse=' ')
        l2pout %>% arrange(pval) -> l2pout
        return(l2pout)
    }
    
    ## --------------- ##
    ## Main Code Block ##
    ## --------------- ##
    
    if(select_by_rank == TRUE){
        df %>% dplyr::select(.data[[gene_name_column]],.data[[column_used_to_rank_genes]]) -> genesmat
        genesmat %>% dplyr::arrange(desc(.data[[column_used_to_rank_genes]])) -> genesmat
        genesmat %>% dplyr::filter(!is.na(.data[[column_used_to_rank_genes]])) -> genesmat
        if(select_top_percentage_of_genes == TRUE){
            numselect <- ceiling(0.1*dim(df)[1])
        } else {
            numselect <- select_top_genes
        }
    } else {
        numselect <- NULL
        genesmat <- df %>% dplyr::select(.data[[gene_name_column]],.data[[fold_change_column]],.data[[p_value_column]]) -> genesmat
    } 

    if (choose_upregulated_genes == TRUE) {
        if(!is.null(numselect)){
            genes_to_include = head(genesmat[[gene_name_column]], numselect)
            lastgene <- tail(genes_to_include,1)
        } else {
            if(fold_change_column_in_log_units == TRUE){
                logFC_threshold <- log2(fold_change_threshold)
                genes_to_include = df %>% dplyr::arrange(.data[[p_value_column]]) %>% filter(.data[[p_value_column]] <= p_value_threshold & .data[[fold_change_column]] >= logFC_threshold) %>% pull(gene_name_column)
                lastgene <- tail(genes_to_include,1)
            } else {
                genes_to_include = df %>% dplyr::arrange(.data[[p_value_column]]) %>% filter(.data[[p_value_column]] <= p_value_threshold & .data[[fold_change_column]] >= fold_change_threshold) %>% pull(gene_name_column)
                lastgene <- tail(genes_to_include,1)
            }
        }
    } else {
        if(!is.null(numselect)){
            genes_to_include = tail(genesmat[[gene_name_column]], numselect)
            lastgene <- head(genes_to_include,1)
        } else {
            if(fold_change_column_in_log_units == TRUE){
                logFC_threshold <- -1*log2(fold_change_threshold)
                genes_to_include = df %>% arrange(.data[[p_value_column]]) %>% filter(.data[[p_value_column]] <= p_value_threshold & .data[[fold_change_column]] <= logFC_threshold) %>% pull(gene_name_column)
                lastgene <- tail(genes_to_include,1)
            } else {
                genes_to_include = df %>% arrange(.data[[p_value_column]]) %>% filter(.data[[p_value_column]] <= p_value_threshold & .data[[fold_change_column]] <= -1*fold_change_threshold) %>% pull(gene_name_column)
                lastgene <- tail(genes_to_include,1)
            }
        }
    }
    
    genes_to_include <- as.vector(unique(unlist(genes_to_include)))
    genes_universe = as.vector(unique(unlist(genesmat[gene_name_column])))
    sizegenelist <- length(genes_to_include)
    sizeuniv <- length(genes_universe)
    
    cat("number of genes selected for pathway analysis: ",sizegenelist)
    cat("\nsize of gene universe: ", sizeuniv)
    pctuniv <- (sizegenelist/sizeuniv)*100
    pctuniv <- formatC(pctuniv,digits=2,format="f")
    cat(paste0("\npercent total: ",pctuniv,"%\n"))
    lastgenedat <- df %>% filter(Gene == lastgene)
    cat("\n\nCheck lowest relevant p-value for genes in genelist:\n\n")
    print(lastgenedat)

    if(organism == "Human"){
        genes_to_include <- updategenes(genes_to_include,trust=1) 
        genes_universe <- updategenes(genes_universe,trust=1)
    } else {
        genes_to_include <- o2o(genes_to_include,organism,"human")
        genes_universe <- o2o(unique(genes_universe),organism,"human")
    }

    if (use_built_in_gene_universe == TRUE) {
        x <- l2p(genes_to_include, categories=gene_set_sources_to_include)
        cat("\n\nUsing built-in gene universe.\n")
        print(paste0("Total number of pathways tested: ", nrow(x)))
    } else {
        x <- l2p(genes_to_include, categories=gene_set_sources_to_include, universe=genes_universe)
        cat("\n\nUsing all genes in differential expression analysis as gene universe.\n")
        print(paste0("Total number of pathways tested: ", nrow(x)))
    }
    
    x <- x %>% select(pathway_name,category,number_hits,percent_gene_hits_per_pathway,enrichment_score,pval,fdr,genesinpathway) %>% 
        mutate(percent_gene_hits_per_pathway = percent_gene_hits_per_pathway) %>% filter(number_hits >= 5) %>% dplyr::filter(pval < p_value_cutoff) %>% arrange(fdr)
    
    #Start plot: 
    leglab = plot_bubble_color
    leglab2 = plot_bubble_size
    x_label <- sort_bubble_plot_by

    plot_bubble_list <- list("Fisher's Exact pval" = "pval", "fdr corrected pval" = "fdr", "number of hits" = "number_hits","percent gene hits per pathway" = "percent_gene_hits_per_pathway","enrichment score" = "enrichment_score") 
    plot_bubble_size <- plot_bubble_list[[plot_bubble_size]]
    plot_bubble_color <- plot_bubble_list[[plot_bubble_color]]
    sort_bubble_plot_by <- plot_bubble_list[[sort_bubble_plot_by]]

    goResults <- x %>% dplyr::filter(number_hits >= min_hit_count) %>% arrange(pval)

    if(plot_top_pathways == TRUE){
        goResults %>% top_n(number_of_pathways_to_plot, wt=-log(pval)) -> goResults 
    } else {
        goResults %>% dplyr::filter(.data[["pathway_name"]] %in% pathways_to_use) -> goResults              #User-selected pathways to plot in bubble plot
        if(dim(goResults)[1] < length(pathways_to_use)){
        cat("\nSome selected pathways are not showing in plot, check for spelling errors:\n\n")
        cat(pathways_to_use[!pathways_to_use %in% goResults[["pathway_name"]]] )    
        }
    }

    #Set up plot data and parameters:

    if(plot_bubble_color %in% c("pval","fdr")) {
        goResults$color <- -log10(goResults[[plot_bubble_color]])
        leglab = paste0("-log10(",plot_bubble_color,")")
    } else{
        goResults$color <- goResults[[plot_bubble_color]]
    }

    if(plot_bubble_size %in% c("pval","fdr")) {
        goResults$size <- -log10(goResults[[plot_bubble_size]])
        leglab2 = paste0("-log10(",plot_bubble_size,")")
    } else{
        goResults$size <- goResults[[plot_bubble_size]]
    }

    if(sort_bubble_plot_by %in% c("pval","fdr")) {
        goResults$sort <- -log10(goResults[[sort_bubble_plot_by]])
        x_label <- paste0("-log10(",sort_bubble_plot_by,")")
    } else {
        goResults$sort <- goResults[[sort_bubble_plot_by]]
    }
    
    goResults$color <- as.numeric(goResults$color)
    minp = floor(min(goResults$color))
    maxp = ceiling(max(goResults$color))
    sizemax = ceiling(max(goResults$size)/10)*10  
    goResults %>% dplyr::mutate(pathwayname2 = stringr::str_replace_all(pathway_name, "_", " ")) -> goResults
    goResults$pathwayname2 <- str_to_upper(goResults$pathwayname2)
    goResults %>% dplyr::mutate(pathwayname2 = stringr::str_wrap(pathwayname2,30)) -> goResults
    goResults %>% dplyr::mutate(percorder = order(goResults$sort)) -> goResults
        goResults$pathwayname2 <- factor(goResults$pathwayname2, levels = goResults$pathwayname2[goResults$percorder])
    xmin = min(goResults$sort) - 0.1*min(goResults$sort)
    xmax = max(goResults$sort) + 0.1*min(goResults$sort)
   
    #col1 <- sym(plot_bubble_size)
    #col2 <- sym(plot_bubble_color)

    #Create list of colors:
    bubblecols <- list("blues" = c("#56B1F7","#132B43"),
                        "reds" = c("#fddbc7","#b2182b"),
                        "blue to red" = c("dark blue","red"))
    
    gplot <- goResults %>% 
        ggplot(aes(x=sort,
        y=pathwayname2, 
        col=color, 
        size=size)) +
        geom_point() +
        theme_classic() +
        labs(col = leglab, size=leglab2, y="Pathway", x=x_label) +
        theme(text = element_text(size=y_axis_labels_size), legend.position = "right", legend.key.height = unit(1, "cm"),
            axis.title.x = element_text(size = rel(1.2)),axis.title.y = element_text(size = rel(1.2))) +
        xlim(xmin,xmax) +
        scale_colour_gradient(low = bubblecols[[bubble_colors]][1], high = bubblecols[[bubble_colors]][2]) +
        expand_limits(colour = seq(minp, maxp, by = 1), size = seq(0, sizemax,by=10))  +
        guides(colour = guide_colourbar(order = 1), size = guide_legend(order=2))
        
    print(gplot)
    
    if (organism != "Human"){
        x <- as.data.frame(return_org_genes(x))
    }

    x$enrichment_score <- as.numeric(formatC(x$enrichment_score,digits=3,format="f"))
    x$percent_gene_hits_per_pathway <- as.numeric(formatC(x$percent_gene_hits_per_pathway,digits=3,format="f"))
    
    return(x)
}

    ## ---------------------------- ##
    ## Global Imports and Functions ##
    ## ---------------------------- ##

    ## Functions defined here will be available to call in
    ## the code for any table.

    ## --------------- ##
    ## End of Template ##
    ## --------------- ##

print("template_function_Figure_4I_Final.R #########################################################################")
library(plotly);library(ggplot2);library(jsonlite);
var_DEG_All_Contrasts<-readRDS("var_DEG_All_Contrasts.rds")
invisible(graphics.off())
var_Figure_4I_Final<-Figure_4I_Final(var_DEG_All_Contrasts)
invisible(graphics.off())
saveRDS(var_Figure_4I_Final,"var_Figure_4I_Final.rds")
