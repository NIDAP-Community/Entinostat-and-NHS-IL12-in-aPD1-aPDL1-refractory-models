source("/rstudio-files/ccbr-data/RSK/nidap_transfer_scripts2/download_tools.R")
key<-Sys.getenv("key")
report<-list()
rid="ri.foundry.main.dataset.57cb9613-4639-4b94-85ed-02ab13f27484"
report["var_DEG_All_Contrasts"]<-'no comparison'
try({
branch="master"
var_DEG_All_Contrastsfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_DEG_All_Contrasts_target<-figure_out_nidap_files(var_DEG_All_Contrastsfiles)
var_DEG_All_Contrasts_new<-readRDS("var_DEG_All_Contrasts.rds")
report["var_DEG_All_Contrasts"]<-report_differences(var_DEG_All_Contrasts_target,var_DEG_All_Contrasts_new)
},silent=TRUE)
print(report["var_DEG_All_Contrasts"])
rid="ri.foundry.main.dataset.388135ec-1738-4c8f-b32b-3da3b83f4e43"
report["var_DEG_COMBO_ENT"]<-'no comparison'
try({
branch="master"
var_DEG_COMBO_ENTfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_DEG_COMBO_ENT_target<-figure_out_nidap_files(var_DEG_COMBO_ENTfiles)
var_DEG_COMBO_ENT_new<-readRDS("var_DEG_COMBO_ENT.rds")
report["var_DEG_COMBO_ENT"]<-report_differences(var_DEG_COMBO_ENT_target,var_DEG_COMBO_ENT_new)
},silent=TRUE)
print(report["var_DEG_COMBO_ENT"])
rid="ri.foundry.main.dataset.d2fee4dc-f5cd-46f7-a5ec-a1358fa43c5b"
report["var_DEG_COMBO_NHS"]<-'no comparison'
try({
branch="master"
var_DEG_COMBO_NHSfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_DEG_COMBO_NHS_target<-figure_out_nidap_files(var_DEG_COMBO_NHSfiles)
var_DEG_COMBO_NHS_new<-readRDS("var_DEG_COMBO_NHS.rds")
report["var_DEG_COMBO_NHS"]<-report_differences(var_DEG_COMBO_NHS_target,var_DEG_COMBO_NHS_new)
},silent=TRUE)
print(report["var_DEG_COMBO_NHS"])
rid="ri.foundry.main.dataset.e60a86ab-180b-4e38-8f32-804fd92ccf32"
report["var_DEG_COMBO_PBS"]<-'no comparison'
try({
branch="master"
var_DEG_COMBO_PBSfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_DEG_COMBO_PBS_target<-figure_out_nidap_files(var_DEG_COMBO_PBSfiles)
var_DEG_COMBO_PBS_new<-readRDS("var_DEG_COMBO_PBS.rds")
report["var_DEG_COMBO_PBS"]<-report_differences(var_DEG_COMBO_PBS_target,var_DEG_COMBO_PBS_new)
},silent=TRUE)
print(report["var_DEG_COMBO_PBS"])
rid="ri.foundry.main.dataset.2c9b38e5-c3b2-406f-8524-e567ccb56c66"
report["var_DEG_ENT_PBS"]<-'no comparison'
try({
branch="master"
var_DEG_ENT_PBSfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_DEG_ENT_PBS_target<-figure_out_nidap_files(var_DEG_ENT_PBSfiles)
var_DEG_ENT_PBS_new<-readRDS("var_DEG_ENT_PBS.rds")
report["var_DEG_ENT_PBS"]<-report_differences(var_DEG_ENT_PBS_target,var_DEG_ENT_PBS_new)
},silent=TRUE)
print(report["var_DEG_ENT_PBS"])
rid="ri.foundry.main.dataset.a730c8ea-2471-420c-803a-3a13d027aa33"
report["var_DEG_NHS_PBS"]<-'no comparison'
try({
branch="master"
var_DEG_NHS_PBSfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_DEG_NHS_PBS_target<-figure_out_nidap_files(var_DEG_NHS_PBSfiles)
var_DEG_NHS_PBS_new<-readRDS("var_DEG_NHS_PBS.rds")
report["var_DEG_NHS_PBS"]<-report_differences(var_DEG_NHS_PBS_target,var_DEG_NHS_PBS_new)
},silent=TRUE)
print(report["var_DEG_NHS_PBS"])
rid="ri.foundry.main.dataset.4e007b55-611b-4a8a-9a63-f6e342a0e2f6"
report["var_Figure_4I_Final"]<-'no comparison'
try({
branch="master"
var_Figure_4I_Finalfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_Figure_4I_Final_target<-figure_out_nidap_files(var_Figure_4I_Finalfiles)
var_Figure_4I_Final_new<-readRDS("var_Figure_4I_Final.rds")
report["var_Figure_4I_Final"]<-report_differences(var_Figure_4I_Final_target,var_Figure_4I_Final_new)
},silent=TRUE)
print(report["var_Figure_4I_Final"])
rid="ri.foundry.main.dataset.70a9df3e-d79a-4046-a4c7-d0e032d6802e"
report["var_GSEA_Filter_All_Contrasts"]<-'no comparison'
try({
branch="master"
var_GSEA_Filter_All_Contrastsfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Filter_All_Contrasts_target<-figure_out_nidap_files(var_GSEA_Filter_All_Contrastsfiles)
var_GSEA_Filter_All_Contrasts_new<-readRDS("var_GSEA_Filter_All_Contrasts.rds")
report["var_GSEA_Filter_All_Contrasts"]<-report_differences(var_GSEA_Filter_All_Contrasts_target,var_GSEA_Filter_All_Contrasts_new)
},silent=TRUE)
print(report["var_GSEA_Filter_All_Contrasts"])
rid="ri.foundry.main.dataset.8f49773a-4968-4870-9ff3-328c0d7378cb"
report["var_GSEA_Filtered_1"]<-'no comparison'
try({
branch="master"
var_GSEA_Filtered_1files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Filtered_1_target<-figure_out_nidap_files(var_GSEA_Filtered_1files)
var_GSEA_Filtered_1_new<-readRDS("var_GSEA_Filtered_1.rds")
report["var_GSEA_Filtered_1"]<-report_differences(var_GSEA_Filtered_1_target,var_GSEA_Filtered_1_new)
},silent=TRUE)
print(report["var_GSEA_Filtered_1"])
rid="ri.foundry.main.dataset.fd24733e-227b-40b6-9c39-44380c145c64"
report["var_GSEA_Filtered_3"]<-'no comparison'
try({
branch="master"
var_GSEA_Filtered_3files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Filtered_3_target<-figure_out_nidap_files(var_GSEA_Filtered_3files)
var_GSEA_Filtered_3_new<-readRDS("var_GSEA_Filtered_3.rds")
report["var_GSEA_Filtered_3"]<-report_differences(var_GSEA_Filtered_3_target,var_GSEA_Filtered_3_new)
},silent=TRUE)
print(report["var_GSEA_Filtered_3"])
rid="ri.foundry.main.dataset.91d5b776-032e-4566-8912-1669d582da1b"
report["var_GSEA_Preranked_1"]<-'no comparison'
try({
branch="master"
var_GSEA_Preranked_1files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Preranked_1_target<-figure_out_nidap_files(var_GSEA_Preranked_1files)
var_GSEA_Preranked_1_new<-readRDS("var_GSEA_Preranked_1.rds")
report["var_GSEA_Preranked_1"]<-report_differences(var_GSEA_Preranked_1_target,var_GSEA_Preranked_1_new)
},silent=TRUE)
print(report["var_GSEA_Preranked_1"])
rid="ri.foundry.main.dataset.f4fcf105-a725-4033-a66f-c96be198d7e6"
report["var_GSEA_Preranked_3"]<-'no comparison'
try({
branch="master"
var_GSEA_Preranked_3files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Preranked_3_target<-figure_out_nidap_files(var_GSEA_Preranked_3files)
var_GSEA_Preranked_3_new<-readRDS("var_GSEA_Preranked_3.rds")
report["var_GSEA_Preranked_3"]<-report_differences(var_GSEA_Preranked_3_target,var_GSEA_Preranked_3_new)
},silent=TRUE)
print(report["var_GSEA_Preranked_3"])
rid="ri.foundry.main.dataset.8d2472fb-d37a-4b22-8034-32348e58c385"
report["var_GSEA_Preranked_All_Contrasts"]<-'no comparison'
try({
branch="master"
var_GSEA_Preranked_All_Contrastsfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Preranked_All_Contrasts_target<-figure_out_nidap_files(var_GSEA_Preranked_All_Contrastsfiles)
var_GSEA_Preranked_All_Contrasts_new<-readRDS("var_GSEA_Preranked_All_Contrasts.rds")
report["var_GSEA_Preranked_All_Contrasts"]<-report_differences(var_GSEA_Preranked_All_Contrasts_target,var_GSEA_Preranked_All_Contrasts_new)
},silent=TRUE)
print(report["var_GSEA_Preranked_All_Contrasts"])
rid="ri.foundry.main.dataset.09b20069-f713-468b-a46e-7688977a32eb"
report["var_GSEA_Viz_1"]<-'no comparison'
try({
branch="master"
var_GSEA_Viz_1files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Viz_1_target<-figure_out_nidap_files(var_GSEA_Viz_1files)
var_GSEA_Viz_1_new<-readRDS("var_GSEA_Viz_1.rds")
report["var_GSEA_Viz_1"]<-report_differences(var_GSEA_Viz_1_target,var_GSEA_Viz_1_new)
},silent=TRUE)
print(report["var_GSEA_Viz_1"])
rid="ri.foundry.main.dataset.4457e84a-64d6-48ef-846c-ffa5692469ea"
report["var_GSEA_Viz_2"]<-'no comparison'
try({
branch="master"
var_GSEA_Viz_2files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Viz_2_target<-figure_out_nidap_files(var_GSEA_Viz_2files)
var_GSEA_Viz_2_new<-readRDS("var_GSEA_Viz_2.rds")
report["var_GSEA_Viz_2"]<-report_differences(var_GSEA_Viz_2_target,var_GSEA_Viz_2_new)
},silent=TRUE)
print(report["var_GSEA_Viz_2"])
rid="ri.foundry.main.dataset.95129c48-5732-4768-b23f-ef5fac416e3a"
report["var_GSEA_Viz_3"]<-'no comparison'
try({
branch="master"
var_GSEA_Viz_3files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Viz_3_target<-figure_out_nidap_files(var_GSEA_Viz_3files)
var_GSEA_Viz_3_new<-readRDS("var_GSEA_Viz_3.rds")
report["var_GSEA_Viz_3"]<-report_differences(var_GSEA_Viz_3_target,var_GSEA_Viz_3_new)
},silent=TRUE)
print(report["var_GSEA_Viz_3"])
rid="ri.foundry.main.dataset.9b59a28b-420c-4860-9478-26a91ad72f4a"
report["var_GSEA_Viz_4"]<-'no comparison'
try({
branch="master"
var_GSEA_Viz_4files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Viz_4_target<-figure_out_nidap_files(var_GSEA_Viz_4files)
var_GSEA_Viz_4_new<-readRDS("var_GSEA_Viz_4.rds")
report["var_GSEA_Viz_4"]<-report_differences(var_GSEA_Viz_4_target,var_GSEA_Viz_4_new)
},silent=TRUE)
print(report["var_GSEA_Viz_4"])
rid="ri.foundry.main.dataset.64b2bfcf-d048-4692-86cd-77b104656aba"
report["var_GSEA_Viz_5"]<-'no comparison'
try({
branch="master"
var_GSEA_Viz_5files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Viz_5_target<-figure_out_nidap_files(var_GSEA_Viz_5files)
var_GSEA_Viz_5_new<-readRDS("var_GSEA_Viz_5.rds")
report["var_GSEA_Viz_5"]<-report_differences(var_GSEA_Viz_5_target,var_GSEA_Viz_5_new)
},silent=TRUE)
print(report["var_GSEA_Viz_5"])
rid="ri.foundry.main.dataset.c837a50d-754b-422e-90be-2135a47f68da"
report["var_GSEA_Viz_6"]<-'no comparison'
try({
branch="master"
var_GSEA_Viz_6files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Viz_6_target<-figure_out_nidap_files(var_GSEA_Viz_6files)
var_GSEA_Viz_6_new<-readRDS("var_GSEA_Viz_6.rds")
report["var_GSEA_Viz_6"]<-report_differences(var_GSEA_Viz_6_target,var_GSEA_Viz_6_new)
},silent=TRUE)
print(report["var_GSEA_Viz_6"])
rid="ri.foundry.main.dataset.ec5cf651-222a-4d46-bb20-238a3d351e5c"
report["var_GSEA_Viz_7"]<-'no comparison'
try({
branch="master"
var_GSEA_Viz_7files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Viz_7_target<-figure_out_nidap_files(var_GSEA_Viz_7files)
var_GSEA_Viz_7_new<-readRDS("var_GSEA_Viz_7.rds")
report["var_GSEA_Viz_7"]<-report_differences(var_GSEA_Viz_7_target,var_GSEA_Viz_7_new)
},silent=TRUE)
print(report["var_GSEA_Viz_7"])
rid="ri.foundry.main.dataset.caea4751-3d93-4bd9-821b-9bf053cfd9c1"
report["var_GSEA_Viz_All_Contrasts"]<-'no comparison'
try({
branch="master"
var_GSEA_Viz_All_Contrastsfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_GSEA_Viz_All_Contrasts_target<-figure_out_nidap_files(var_GSEA_Viz_All_Contrastsfiles)
var_GSEA_Viz_All_Contrasts_new<-readRDS("var_GSEA_Viz_All_Contrasts.rds")
report["var_GSEA_Viz_All_Contrasts"]<-report_differences(var_GSEA_Viz_All_Contrasts_target,var_GSEA_Viz_All_Contrasts_new)
},silent=TRUE)
print(report["var_GSEA_Viz_All_Contrasts"])
rid="ri.foundry.main.dataset.ecf0b9b5-2736-43cd-8403-50ec9ae24a62"
report["var_Supp_Fig_5A_Part1"]<-'no comparison'
try({
branch="master"
var_Supp_Fig_5A_Part1files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_Supp_Fig_5A_Part1_target<-figure_out_nidap_files(var_Supp_Fig_5A_Part1files)
var_Supp_Fig_5A_Part1_new<-readRDS("var_Supp_Fig_5A_Part1.rds")
report["var_Supp_Fig_5A_Part1"]<-report_differences(var_Supp_Fig_5A_Part1_target,var_Supp_Fig_5A_Part1_new)
},silent=TRUE)
print(report["var_Supp_Fig_5A_Part1"])
rid="ri.foundry.main.dataset.1c39f38e-52ab-483c-a952-d840acf2c073"
report["var_Supp_Fig_5A_Part2"]<-'no comparison'
try({
branch="master"
var_Supp_Fig_5A_Part2files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_Supp_Fig_5A_Part2_target<-figure_out_nidap_files(var_Supp_Fig_5A_Part2files)
var_Supp_Fig_5A_Part2_new<-readRDS("var_Supp_Fig_5A_Part2.rds")
report["var_Supp_Fig_5A_Part2"]<-report_differences(var_Supp_Fig_5A_Part2_target,var_Supp_Fig_5A_Part2_new)
},silent=TRUE)
print(report["var_Supp_Fig_5A_Part2"])
rid="ri.foundry.main.dataset.d34f5257-9c73-4635-be93-68cd9cfa8cdd"
report["var_Supp_Fig_5B_Final"]<-'no comparison'
try({
branch="master"
var_Supp_Fig_5B_Finalfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_Supp_Fig_5B_Final_target<-figure_out_nidap_files(var_Supp_Fig_5B_Finalfiles)
var_Supp_Fig_5B_Final_new<-readRDS("var_Supp_Fig_5B_Final.rds")
report["var_Supp_Fig_5B_Final"]<-report_differences(var_Supp_Fig_5B_Final_target,var_Supp_Fig_5B_Final_new)
},silent=TRUE)
print(report["var_Supp_Fig_5B_Final"])
rid="ri.foundry.main.dataset.77486588-5d6a-449a-9e6a-bca0b41199f1"
report["var_Venn_All_Contrasts"]<-'no comparison'
try({
branch="master"
var_Venn_All_Contrastsfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_Venn_All_Contrasts_target<-figure_out_nidap_files(var_Venn_All_Contrastsfiles)
var_Venn_All_Contrasts_new<-readRDS("var_Venn_All_Contrasts.rds")
report["var_Venn_All_Contrasts"]<-report_differences(var_Venn_All_Contrasts_target,var_Venn_All_Contrasts_new)
},silent=TRUE)
print(report["var_Venn_All_Contrasts"])
rid="ri.foundry.main.dataset.ba1141a6-611a-4841-bbc1-afe837df0ec5"
report["var_Volcano_All_Contrasts"]<-'no comparison'
try({
branch="master"
var_Volcano_All_Contrastsfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_Volcano_All_Contrasts_target<-figure_out_nidap_files(var_Volcano_All_Contrastsfiles)
var_Volcano_All_Contrasts_new<-readRDS("var_Volcano_All_Contrasts.rds")
report["var_Volcano_All_Contrasts"]<-report_differences(var_Volcano_All_Contrasts_target,var_Volcano_All_Contrasts_new)
},silent=TRUE)
print(report["var_Volcano_All_Contrasts"])
rid="ri.foundry.main.dataset.b3b8d0fc-3461-499f-b88c-e4906b1927b5"
report["var_Volcano_COMBO_ENT"]<-'no comparison'
try({
branch="master"
var_Volcano_COMBO_ENTfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_Volcano_COMBO_ENT_target<-figure_out_nidap_files(var_Volcano_COMBO_ENTfiles)
var_Volcano_COMBO_ENT_new<-readRDS("var_Volcano_COMBO_ENT.rds")
report["var_Volcano_COMBO_ENT"]<-report_differences(var_Volcano_COMBO_ENT_target,var_Volcano_COMBO_ENT_new)
},silent=TRUE)
print(report["var_Volcano_COMBO_ENT"])
rid="ri.foundry.main.dataset.553d60f2-fb90-4bcb-a883-d2a72e43fdb3"
report["var_Volcano_COMBO_NHS"]<-'no comparison'
try({
branch="master"
var_Volcano_COMBO_NHSfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_Volcano_COMBO_NHS_target<-figure_out_nidap_files(var_Volcano_COMBO_NHSfiles)
var_Volcano_COMBO_NHS_new<-readRDS("var_Volcano_COMBO_NHS.rds")
report["var_Volcano_COMBO_NHS"]<-report_differences(var_Volcano_COMBO_NHS_target,var_Volcano_COMBO_NHS_new)
},silent=TRUE)
print(report["var_Volcano_COMBO_NHS"])
rid="ri.foundry.main.dataset.1973618e-00b6-4bb8-888d-e470138183b0"
report["var_Volcano_COMBO_PBS"]<-'no comparison'
try({
branch="master"
var_Volcano_COMBO_PBSfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_Volcano_COMBO_PBS_target<-figure_out_nidap_files(var_Volcano_COMBO_PBSfiles)
var_Volcano_COMBO_PBS_new<-readRDS("var_Volcano_COMBO_PBS.rds")
report["var_Volcano_COMBO_PBS"]<-report_differences(var_Volcano_COMBO_PBS_target,var_Volcano_COMBO_PBS_new)
},silent=TRUE)
print(report["var_Volcano_COMBO_PBS"])
rid="ri.foundry.main.dataset.5ae6b2ce-d0c0-4ed0-8eab-187630a1c333"
report["var_Volcano_ENT_PBS"]<-'no comparison'
try({
branch="master"
var_Volcano_ENT_PBSfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_Volcano_ENT_PBS_target<-figure_out_nidap_files(var_Volcano_ENT_PBSfiles)
var_Volcano_ENT_PBS_new<-readRDS("var_Volcano_ENT_PBS.rds")
report["var_Volcano_ENT_PBS"]<-report_differences(var_Volcano_ENT_PBS_target,var_Volcano_ENT_PBS_new)
},silent=TRUE)
print(report["var_Volcano_ENT_PBS"])
rid="ri.foundry.main.dataset.94896e53-dabe-441f-83ab-e9dba42966ed"
report["var_Volcano_NHS_PBS"]<-'no comparison'
try({
branch="master"
var_Volcano_NHS_PBSfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_Volcano_NHS_PBS_target<-figure_out_nidap_files(var_Volcano_NHS_PBSfiles)
var_Volcano_NHS_PBS_new<-readRDS("var_Volcano_NHS_PBS.rds")
report["var_Volcano_NHS_PBS"]<-report_differences(var_Volcano_NHS_PBS_target,var_Volcano_NHS_PBS_new)
},silent=TRUE)
print(report["var_Volcano_NHS_PBS"])
rid="ri.foundry.main.dataset.c55bb5e2-3280-497a-9f82-8acf66f6672a"
report["var_filtered_counts_1"]<-'no comparison'
try({
branch="master"
var_filtered_counts_1files<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_filtered_counts_1_target<-figure_out_nidap_files(var_filtered_counts_1files)
var_filtered_counts_1_new<-readRDS("var_filtered_counts_1.rds")
report["var_filtered_counts_1"]<-report_differences(var_filtered_counts_1_target,var_filtered_counts_1_new)
},silent=TRUE)
print(report["var_filtered_counts_1"])
rid="ri.foundry.main.dataset.e12882e5-b076-478b-91c4-35d083ab71b2"
report["var_normalized_counts"]<-'no comparison'
try({
branch="master"
var_normalized_countsfiles<-pullnidap_raw(key=key,rid=rid,branch=branch)
var_normalized_counts_target<-figure_out_nidap_files(var_normalized_countsfiles)
var_normalized_counts_new<-readRDS("var_normalized_counts.rds")
report["var_normalized_counts"]<-report_differences(var_normalized_counts_target,var_normalized_counts_new)
},silent=TRUE)
print(report["var_normalized_counts"])
