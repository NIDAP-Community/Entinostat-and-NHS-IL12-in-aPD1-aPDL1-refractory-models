Supp_Fig_5B_Final <- function(DEG_All_Contrasts) {
    
    library(l2p)
    library(l2psupp)
    library(tidyverse)
    library(plyr)

    ###########################
    #Add Parameters for Template
    #############################

    deg_table <- DEG_All_Contrasts
    gene_column <- "Gene"
    t_statistic_columns <- c("COMBO-PBS_tstat","COMBO-ENT_tstat","COMBO-NHS_tstat","NHS-PBS_tstat","ENT-PBS_tstat") #t-statistics columns
    select_top_percentage_of_genes <- TRUE
    select_top_genes <- 1000
    organism = tolower("Mouse")
    use_built_in_gene_universe = FALSE
    gene_set_sources_to_include = c("KEGG")
    top_pathways <- 500
    pathway_size_limit <- 300
    p_value_limit <- 0.05
    use_fdr_pval <- FALSE 
    plot_bubble_size <- "number_hits"
    plot_bubble_color <- "enrichment_score"
    #use_gpcc_pval <- FALSE
    number_of_significant_events <- 1
    pathways_to_remove <- c("ABC transporters","Adenine ribonucleotide biosynthesis, IMP => ADP,ATP","Adherens junction","African trypanosomiasis","AGE-RAGE signaling pathway in diabetic complications","Alcoholism","Allograft rejection","Amino sugar and nucleotide sugar metabolism","Aminoacyl-tRNA biosynthesis","Aminoacyl-tRNA biosynthesis, eukaryotes","Amoebiasis","Amphetamine addiction","Antifolate resistance","Apelin signaling pathway","Apoptosis - multiple species","Arachidonic acid metabolism","Ascorbate and aldarate metabolism","Asthma","Autoimmune thyroid disease","Axon guidance","Basal cell carcinoma","beta-Alanine metabolism","beta-Oxidation","BMP signaling","BRCA1-associated genome surveillance complex (BASC)","Breast cancer","Carbohydrate digestion and absorption","Carbon metabolism","Cell cycle","Chagas disease (American trypanosomiasis)","Cholinergic synapse","Circadian entrainment","Dilated cardiomyopathy","DNA polymerase alpha / primase complex","Dopaminergic synapse","ECM-receptor interaction","EGFR tyrosine kinase inhibitor resistance","eIF4F complex","Endocytosis","Epstein-Barr virus infection","FA core complex","Fanconi anemia pathway","Fatty acid biosynthesis, initiation","Fc epsilon RI signaling pathway","Fluid shear stress and atherosclerosis","Focal adhesion","GABAergic synapse","Galactose degradation, Leloir pathway, galactose => alpha-D-glucose-1P","Gastric acid secretion","GINS complex","Glucuronate pathway (uronate pathway)","Glutathione metabolism","Glycolysis, core module involving three-carbon compounds","Glycosaminoglycan biosynthesis - chondroitin sulfate / dermatan sulfate","Graft-versus-host disease","Hepatitis C","Herpes simplex infection","HIF-1 signaling pathway","Hippo signaling","Histidine metabolism","Hypertrophic cardiomyopathy (HCM)","IL-17 signaling pathway","Immunoproteasome","Inflammatory bowel disease (IBD)","Inflammatory mediator regulation of TRP channels","Influenza A","Inosine monophosphate biosynthesis, PRPP + glutamine => IMP","Inositol phosphate metabolism, Ins(1,3,4)P3 => phytate","Intestinal immune network for IgA production","JAK-STAT signaling","Jak-STAT signaling pathway","Legionellosis","Leishmaniasis","Leukocyte transendothelial migration","Long-term depression","Long-term potentiation","Longevity regulating pathway - multiple species","Malaria","Malonate semialdehyde pathway, propanoyl-CoA => acetyl-CoA","Measles","Melanogenesis","Melanoma","Metabolism of xenobiotics by cytochrome P450","Mitophagy - animal","Morphine addiction","Mucin type O-glycan biosynthesis","N-glycan precursor biosynthesis","Neomycin, kanamycin and gentamicin biosynthesis","Neuroactive ligand-receptor interaction","NF-kappa B signaling pathway","Nicotinate and nicotinamide metabolism","Nitrogen metabolism","NOD-like receptor signaling pathway","O-glycan biosynthesis, mucin type core","Oocyte meiosis","Osteoclast differentiation","Other glycan degradation","Ovarian steroidogenesis","Oxytocin signaling pathway","p97-Ufd1-Npl4 complex","Pancreatic secretion","Pentose and glucuronate interconversions","Pentose phosphate pathway","Pertussis","Phagosome","Phosphatidylinositol signaling system","PI3K-Akt signaling pathway","PPAR signaling pathway","Primary bile acid biosynthesis","Primary immunodeficiency","Prolactin signaling pathway","Propanoate metabolism","Proteasome","Proteoglycans in cancer","Purine metabolism","Pyruvate metabolism","Rap1 signaling pathway","Retrograde endocannabinoid signaling","Rheumatoid arthritis","Ribosome biogenesis in eukaryotes","Salivary secretion","Salmonella infection","SCF-FBS complex","Serine biosynthesis, glycerate-3P => serine","Serotonergic synapse","Staphylococcus aureus infection","Starch and sucrose metabolism","Synaptic vesicle cycle","Systemic lupus erythematosus","Taurine and hypotaurine metabolism","TGF-beta signaling","TGF-beta signaling pathway","Th17 cell differentiation","Thiamine metabolism","Tight junction","Toxoplasmosis","Tuberculosis","Type I diabetes mellitus","Tyrosine metabolism","Ubiquinone and other terpenoid-quinone biosynthesis","Urea cycle","Uridine monophosphate biosynthesis, glutamine (+ PRPP) => UMP","Vascular smooth muscle contraction","Viral myocarditis")
    rename_groups <- c()

    ## --------- ##
    ## Functions ##
    ## --------- ##

    return_org_genes <- function(l2pout){
        l2pgenes <- as.list(l2pout$genes)
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
    
    compnum <- length(t_statistic_columns)

    #Select top percentage or number of genes from universe:
    if(select_top_percentage_of_genes == TRUE){
        numselect <- ceiling(0.1*dim(deg_table)[1])
    } else {
        numselect <- select_top_genes
    }

    genelists <- list()
    for (i in 1:compnum){
        lists <- list()
        deg_table %>% dplyr::select(.data[[gene_column]], t_statistic_columns[i]) -> genesmat
        genesmat %>% dplyr::arrange(desc(.data[[t_statistic_columns[i]]])) %>% head(numselect) %>% pull(.data[[gene_column]]) -> lists[[1]]
        genesmat %>% dplyr::arrange(desc(.data[[t_statistic_columns[i]]])) %>% tail(numselect) %>% pull(.data[[gene_column]]) -> lists[[2]]
        listall <- list(lists[[1]],lists[[2]])
        genelists[[i]] <- listall
    }

    genes_universe = as.vector(unique(unlist(deg_table["Gene"])))
    
    run_l2p <- function(genes_to_include) {   
        genes_to_include <- as.vector(unique(unlist(genes_to_include)))
        
        if(organism == "human"){
            genes_to_include <- updategenes(genes_to_include,trust=1) 
            genes_universe <- updategenes(genes_universe,trust=1)
        }

        if (organism != "human") {
            species = organism
            genes_to_include <- o2o(genes_to_include,species,"human")
            genes_universe <- o2o(unique(genes_universe),species,"human")
        }

        if (use_built_in_gene_universe == TRUE) {
            x <- l2p(genes_to_include, categories=gene_set_sources_to_include)
            print("Using built-in gene universe.")
        } else {
            x <- l2p(genes_to_include, categories=gene_set_sources_to_include, universe=genes_universe)
        }
        return(x)
    }

    l2presults <- list()
    for (i in 1:length(genelists)){
        l2presults[[i]] <- lapply(genelists[[i]], function(x) {run_l2p(x)})
    }

    colnames = sapply(strsplit(as.character(t_statistic_columns),split="\\_tstat"),function(x) x[1])
    
    pathlist <- list()
    #if (use_gpcc_pval == TRUE){
    #for (i in 1:length(l2presults)){
    #    paths <- list()
    #    paths <- lapply(l2presults[[i]], function(x) {x %>%
    #                dplyr::filter(GPCC_pval < p_value_limit) %>%
    #                head(top_pathways) %>% dplyr::select(pathway_name)})
    #    pathlist[[i]] <- unlist(lapply(paths,function(x) {unlist(x, use.names=FALSE)}))
    #    }
    #} else {
    for (i in 1:length(l2presults)){
        paths <- list()
        if(use_fdr_pval == TRUE){
            paths <- lapply(l2presults[[i]], function(x) {x %>%
                dplyr::filter(fdr < p_value_limit) %>%
                head(top_pathways) %>% dplyr::select(pathway_name)})    
        } else {
            paths <- lapply(l2presults[[i]], function(x) {x %>%
                dplyr::filter(pval < p_value_limit) %>%
                head(top_pathways) %>% dplyr::select(pathway_name)})
        }
        pathlist[[i]] <- unlist(lapply(paths,function(x) {unlist(x, use.names=FALSE)}))
    }
    
    path.all <-  data.frame(pathwayname = unlist(pathlist))

    path.all %>% group_by(pathwayname) %>% 
                tally() %>% 
                arrange(desc(n)) %>% 
                dplyr::filter(n>=number_of_significant_events) %>% 
                dplyr::pull(pathwayname) -> path.select

    pathmerge <- list()
    for (i in 1:length(l2presults)){
        pathselect <- list()
        pathselect <- lapply(l2presults[[i]], function(x) {
                                dplyr::filter(x, pathway_name %in% path.select) %>% 
                                mutate(total = number_hits + number_misses) %>%  
                                dplyr::distinct(pathway_name, .keep_all = TRUE) %>% 
                                dplyr::filter(total < pathway_size_limit) %>%
                                dplyr::mutate(percent_gene_hits_per_pathway = percent_gene_hits_per_pathway) %>%
                                dplyr::select(pathway_name,category,enrichment_score,number_hits,total,percent_gene_hits_per_pathway,pval,fdr,genesinpathway) 
                                })                              
                                
        pathselect.merge <- merge(pathselect[[1]],pathselect[[2]],by="pathway_name",all=TRUE) %>% 
                            dplyr::mutate_if(is.numeric, replace_na, 0) %>%
                            dplyr::mutate(net_enrichment_score = enrichment_score.x-enrichment_score.y) %>% 
                            dplyr::mutate(net_number_hits = number_hits.x - number_hits.y) %>%
                            dplyr::mutate(enrichment_score = case_when(net_enrichment_score>0 ~enrichment_score.x,
                                            net_enrichment_score < 0 ~ -1*enrichment_score.y, 
                                            TRUE ~ 0)) %>% 
                            dplyr::mutate(categ = case_when(net_enrichment_score > 0 ~category.x,
                                            net_enrichment_score < 0 ~category.y)) %>%
                            dplyr::mutate(number_hits = case_when(net_enrichment_score > 0 ~number_hits.x,
                                            net_enrichment_score < 0 ~ number_hits.y, TRUE ~ 0)) %>%
                            dplyr::mutate(percent_gene_hits_per_pathway = case_when(net_enrichment_score > 0 ~percent_gene_hits_per_pathway.x,
                                            net_enrichment_score < 0 ~ -1*percent_gene_hits_per_pathway.y, TRUE ~ 0)) %>%
                            dplyr::mutate(pval = case_when(net_enrichment_score > 0 ~pval.x,
                                            net_enrichment_score < 0 ~ pval.y, TRUE ~ 0)) %>%
                            dplyr::mutate(fdr = case_when(net_enrichment_score > 0 ~fdr.x,
                                            net_enrichment_score < 0 ~ fdr.y, TRUE ~ 0)) %>%
                            dplyr::mutate(genes = case_when(net_enrichment_score > 0 ~genesinpathway.x,
                                            net_enrichment_score < 0 ~genesinpathway.y)) %>%
                            dplyr::mutate(group=colnames[i])
        pathmerge[[i]] <- pathselect.merge
    }

    pathall <- bind_rows(pathmerge) %>% select(pathway_name,categ,number_hits, percent_gene_hits_per_pathway,enrichment_score,pval,fdr,net_number_hits,net_enrichment_score,genes,group) %>% arrange(pval)

    grouplevel <- gsub("_tstat","",t_statistic_columns)
    pathall$group <- factor(pathall$group,levels=grouplevel)
    pathall %>% filter(!pathway_name %in% pathways_to_remove) -> pathall
    if(length(rename_groups)>0){
        names(rename_groups) <- grouplevel
        pathall$group <- rename_groups[pathall$group]
        pathall$group <- factor(pathall$group,levels=rename_groups)
    }

    if (organism != "Human"){
        pathall <- as.data.frame(return_org_genes(pathall))
    }

    pathall2 <- pathall
    pathall2$pathway_name2 <- str_to_upper(pathall2$pathway_name)
    pathall2 %>% dplyr::mutate(pathway_name2 = stringr::str_wrap(pathway_name2,30)) -> pathall2
    maxabscore <- max(abs(range(pathall2[[plot_bubble_color]])))
    maxscore = maxabscore
    minscore = -1*maxabscore

    col1 <- sym(plot_bubble_size)
    col2 <- sym(plot_bubble_color)
    if(plot_bubble_size %in% c("pval","fdr")){
        g <- ggplot(pathall2, aes(x = group, y = reorder(pathway_name2,enrichment_score), size = -log10(!!col1), colour = !!col2)) + 
                geom_point() +
                scale_size_continuous(range = c(1,50)) +
                theme_classic() + 
                ylab("Pathways") +
                scale_colour_gradient2(limits=c(minscore, maxscore),midpoint = 0,low="darkblue",mid="grey", high="tomato",oob = scales::squish) +
                scale_size(range = c(0, 10)) +
                scale_y_discrete(expand = c(0.05, 0.05)) +
                theme(axis.text.x = element_text(angle = 90, hjust = 1))
    } else {  
        g <- ggplot(pathall2, aes(x = group, y = reorder(pathway_name2,enrichment_score), size = !!col1, colour = !!col2)) + 
                geom_point() +
                scale_size_continuous(range = c(1,50)) +
                theme_classic() + 
                ylab("Pathways") +
                scale_colour_gradient2(limits=c(minscore, maxscore),midpoint = 0,low="darkblue",mid="grey", high="tomato",oob = scales::squish) +
                scale_size(range = c(0, 10)) +
                scale_y_discrete(expand = c(0.05, 0.05)) +
                theme(axis.text.x = element_text(angle = 90, hjust = 1))
    } 

    print(g)
    
return(pathall)
}

#################################################
## Global imports and functions included below ##
#################################################

# Functions defined here will be available to call in
# the code for any table.

print("template_function_Supp_Fig_5B_Final.R #########################################################################")
library(plotly);library(ggplot2);library(jsonlite);
var_DEG_All_Contrasts<-readRDS("var_DEG_All_Contrasts.rds")
invisible(graphics.off())
var_Supp_Fig_5B_Final<-Supp_Fig_5B_Final(var_DEG_All_Contrasts)
invisible(graphics.off())
saveRDS(var_Supp_Fig_5B_Final,"var_Supp_Fig_5B_Final.rds")
