Venn_All_Contrasts <- function(Volcano_All_Contrasts) {
    
# TEMPLATE PARAMS (Main and Visual) ====

# Main
Input_dataset <- Volcano_All_Contrasts
Elements_column <- 'Gene'
Categories_column <- 'Contrast'
Plot_selection <- 'Venn diagram'
Subsets = c()
Intersection_ids = c()

# Visual
# image: 'png'
Image_output_format <- 'png'
Image_resolution <- 300
Image_width <- 4000
Image_height <- 3000

# LIBRARIES ====

library(VennDiagram); library(gridExtra); library(patchwork); library(UpSetR); library(dplyr); library(tibble)

# FUNCTIONS ====

# modify UpSetR function (keep gene names as rownames of intersection matrix)
fromList <- function (input) {
  # Same as original fromList()...
  elements <- unique(unlist(input))
  data <- unlist(lapply(input, function(x) {
      x <- as.vector(match(elements, x))
      }))
  data[is.na(data)] <- as.integer(0)
  data[data != 0] <- as.integer(1)
  data <- data.frame(matrix(data, ncol = length(input), byrow = F))
  data <- data[which(rowSums(data) != 0), ]
  names(data) <- names(input)
  # ... Except now it conserves your original value names!
  row.names(data) <- elements
  return(data)
}

# SET IMAGE ====

if(Image_output_format == 'png') {
    png(filename="Venn_All_Contrasts.png", width=Image_width, height=Image_height, units="px", pointsize=4, bg="white", res=Image_resolution, type="cairo")
} else {
    svglite::svglite(file="Venn_All_Contrasts.png", width=round(Image_width/Image_resolution,digits=2), height=round(Image_height/Image_resolution,digits=2), pointsize=1, bg="white")
}

# SET INPUT ==== 
                
# select required columns
set_elements <- Input_dataset[, Elements_column]
set_names <-    Input_dataset[, Categories_column]
   
# prepare format - R list
vlist = split(set_elements, set_names)
if(!is.null(Subsets)){
    vlist = vlist[Subsets]
}
num_categories = length(vlist)

# generate upset object

if(num_categories > 1) {
    
    sets = fromList(vlist)
    
    if(!is.null(Subsets)){
        Intersection = sets[,match(Subsets, colnames(sets))]
    } else {
        Intersection = sets
    }

    # generate intersection frequency table and gene list (all intersections for the output dataset/table not the plot)
    Intersection = sapply(colnames(Intersection), function(x){ifelse(Intersection[,x]==1, x, "{}")})
    rownames(Intersection) = rownames(sets)
    Intersection = apply(Intersection, 1, function(x) sprintf("(%s)", paste(x, collapse=' ')))
    tab = table(Intersection)
    tab = tab[order(tab)]
    nn = stringr::str_count(names(tab), pattern = "\\{\\}")
    tab = tab[order(nn, decreasing=FALSE)]
    names(tab) = gsub("\\{\\} | \\{\\}|\\{\\} |\\{\\} \\{\\}","", names(tab))
    names(tab) = sub("\\( ","(", names(tab))
    names(tab) = gsub(" "," ∩ ", names(tab))
    tab = tab[names(tab) != "()"] %>% data.frame() %>% dplyr::rename("Intersection"=Var1, "Size"=Freq) %>% tibble::rownames_to_column('Id') %>% dplyr::mutate(Id=as.numeric(Id))  %>% dplyr::select(Intersection, Id, Size)
    Intersection = gsub("\\{\\} | \\{\\}|\\{\\} |\\{\\} \\{\\}","", Intersection)
    Intersection = sub("\\( ","(", Intersection)
    Intersection = gsub(" "," ∩ ", Intersection)
    Intersection = data.frame(Intersection) %>% tibble::rownames_to_column("Gene") %>% dplyr::inner_join(tab, by=c(Intersection="Intersection")) %>% dplyr::select(Gene, Intersection, Id, Size) %>% dplyr::arrange(Id)

} else if (num_categories == 1) {
    Intersection = data.frame(Gene=vlist[[1]], Intersection = sprintf("(%s)", names(vlist)), Id = 1, Size = length(vlist[[1]]))
    tab = table(Intersection$Intersection)
    tab = data.frame(Id=1, tab) %>% dplyr::rename(Intersection=Var1, Size=Freq) %>% dplyr::select(Intersection, Id, Size)
}

# returned intersections

if (!is.null(Intersection_ids) ) {
    Intersection_ids = sort(as.numeric(Intersection_ids))
    tabsel = tab[tab$Id %in% Intersection_ids,]
    Intersectionsel = Intersection[Intersection$Id %in% Intersection_ids,]
} else {
    tabsel = tab
    Intersectionsel = Intersection
}
tab$"Return" = ifelse(tab$Intersection %in% tabsel$Intersection, "Yes", "—")

if('degree' == 'freq'){
    tab = tab %>% dplyr::arrange(-Size)
    tabsel = tabsel %>% dplyr::arrange(-Size)
}

# screen log
cat('All intersections\n')
print(tab)
cat('\nIntersections returned\n')
print(tabsel)

# DO PLOT ====

if(num_categories == 1) {
    if(Plot_selection == "Intersection plot") { 
        Plot_selection = 'Venn diagram'
        cat("\nIntersection plot not available for a single contrast, the Venn diagram genereated instead")
    }
} else if(num_categories > 5) {
    Plot_selection = 'Intersection plot'
    cat("\nVenn diagram available for up to 5 contrasts, the Intersection plot genereated instead")
}

# Intersection Plot

if(Plot_selection == 'Intersection plot') {

# do plot
empty = FALSE
if(empty) {keepEmpty='on'} else {keepEmpty=NULL}

barcol = "steelblue4"

pSet = upset(sets,
                nsets = num_categories,
                sets = Subsets,
                order.by = 'degree',
                nintersects = NA,
                text.scale = 2,
                empty.intersections = keepEmpty,
                matrix.color = barcol, main.bar.color = barcol, sets.bar.color = barcol,
                point.size = 2.2, line.size = 0.7)

print(pSet)

} else if (Plot_selection == 'Venn diagram') {

    # Venn diagram  

    color_border = 'fill colors'
    if(color_border != 'black') { color_border = c("darkolivegreen","darkblue","plum4","darkgreen","midnightblue")[1:num_categories] }

    print_mode = 'raw'
    if(print_mode == 'raw-percent') {
        print_mode = c('raw','percent')
    } else if(print_mode == 'percent-raw'){
        print_mode = c('percent','raw')
    }

    distance = c()
    position = c()

    if( is.null(distance) & is.null(position) ) {

        vobj = venn.diagram( vlist, file=NULL, force_unique = TRUE, print.mode = print_mode, sigdigs = 2, margin=0,  main = '', cat.cex=3, cex=6,  main.cex=3, fill=c("darkolivegreen","darkblue","plum4","darkgreen","midnightblue")[1:num_categories], alpha=0.2, col=color_border )

    } else if ( !is.null(distance) & is.null(position) ) {

        distance = as.numeric(distance)

        vobj = venn.diagram( vlist, file=NULL, force_unique = TRUE, print.mode = print_mode, sigdigs = 2, margin=0,  main = '', cat.cex=3, cex=6,  main.cex=3, fill=c("darkolivegreen","darkblue","plum4","darkgreen","midnightblue")[1:num_categories], alpha=0.2, col=color_border, cat.dist = distance)

    } else if ( is.null(distance) & !is.null(position) ) {

        position = as.numeric(position)

        vobj = venn.diagram( vlist, file=NULL, force_unique = TRUE, print.mode = print_mode, sigdigs = 2, margin=0,  main = '', cat.cex=3, cex=6,  main.cex=3, fill=c("darkolivegreen","darkblue","plum4","darkgreen","midnightblue")[1:num_categories], alpha=0.2, col=color_border, cat.pos = position)

    } else {

        distance = as.numeric(distance)
        position = as.numeric(position)

        vobj = venn.diagram( vlist, file=NULL, force_unique = TRUE, print.mode = print_mode, sigdigs = 2, margin=0,  main = '', cat.cex=3, cex=6,  main.cex=3, fill=c("darkolivegreen","darkblue","plum4","darkgreen","midnightblue")[1:num_categories], alpha=0.2, col=color_border, cat.dist = distance, cat.pos = position)

    }
          
    pVenn = wrap_elements( gTree(children=vobj) )
    print(pVenn)
    
} else {

    font_size_table = 0.7
    table_content = "all intersections"
    if(table_content == "all intersections"){
        pTab = wrap_elements( tableGrob(tab, rows=NULL, theme = ttheme_default(core=list(fg_params=list(cex=font_size_table)), colhead = list(fg_params=list(cex = font_size_table)), rowhead=list(fg_params=list(cex= font_size_table)))) )
    } else {
        pTab = wrap_elements( tableGrob(tabsel, rows=NULL, theme = ttheme_default(core=list(fg_params=list(cex=font_size_table)), colhead = list(fg_params=list(cex = font_size_table)), rowhead=list(fg_params=list(cex= font_size_table)))) )
    }
    print(pTab)
}

# SAVE DATASET ====
return(Intersectionsel)

}

#################################################
## Global imports and functions included below ##
#################################################

# Functions defined here will be available to call in
# the code for any table.

print("template_function_Venn_All_Contrasts.R #########################################################################")
library(plotly);library(ggplot2);library(jsonlite);
var_Volcano_All_Contrasts<-readRDS("var_Volcano_All_Contrasts.rds")
invisible(graphics.off())
var_Venn_All_Contrasts<-Venn_All_Contrasts(var_Volcano_All_Contrasts)
invisible(graphics.off())
saveRDS(var_Venn_All_Contrasts,"var_Venn_All_Contrasts.rds")
