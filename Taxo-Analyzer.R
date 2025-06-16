#library(dada2)
#library(phyloseq)

somme_rang_taxo <- function(final_rar) {
  df_tt <- data.frame()
  
  for (i in 2:(length(rank_names(final_rar)))) { 
    dms <- dim(table(tax_table(final_rar)[, rank_names(final_rar)[i]]))
    df_tt <- rbind(df_tt, dms)
  }
  
  df_tt <- as.data.frame(t(df_tt))
  colnames(df_tt) <- rank_names(final_rar)[-1]
  
  write.table(df_tt, "./rang_taxo.tsv", sep="\t")
  
  return(df_tt)
}

#library(tidyverse)

rang_taxo_per_sample <- function(final_rar) {
  phy_list <- list()
  count_taxa <- data.frame()
  
  for (i in 2:(length(rank_names(final_rar)))) {
    df1 <- list(phyloseq_ntaxa_by_tax(final_rar, TaxRank = rank_names(final_rar)[i]))
    phy_list <- append(phy_list, df1)
  }
  
  for (j in 1:length(phy_list)) {
    dff <- phy_list[[j]][1]
    taxa_tab <- dff %>% group_by(Sample) %>% tally()
    count_taxa <- dplyr::bind_rows(count_taxa, taxa_tab)
  }
  
  lem <- count_taxa %>%
    group_by(Sample) %>%
    mutate(m = paste0("n", 1:n())) %>%
    spread(m, n)
  
  colnames(lem) <- c("Samples", rank_names(final_rar)[-1])
  
  write.table(lem, "./taxo_samples.tsv", sep = "\t")
  
  return(lem)
}

library(ggplot2)
library(dplyr)
library(broom)
library(tidyr)
library(ggpmisc)


## Plot diversity vs params 
plot_div_vs_params <- function(data, diversity_col, param_cols, group_col) {
  # Ensure input is in character format
  diversity_col <- rlang::ensym(diversity_col)
  group_col <- rlang::ensym(group_col)
  
  # Pivot longer the parameters
  data_long <- data %>%
    pivot_longer(cols = all_of(param_cols), names_to = "Parameter", values_to = "Value")
  
  # Build plot
  p <- ggplot(data_long, aes(x = Value, y = !!diversity_col, color = !!group_col, shape = !!group_col)) +
    geom_point(size = 3) +
    geom_smooth(method = "lm", se = TRUE, linewidth = 1.2) +
    facet_wrap(~Parameter, scales = "free_x") +
    stat_poly_eq(
      aes(label = paste(..adj.rr.label.., ..p.value.label.., sep = "~~~")),
      formula = y ~ x,
      parse = TRUE,
      label.x.npc = "right",
      label.y.npc = 0.9,
      small.p = TRUE,
      size = 3
    ) +
    labs(
      x = "Parameter Value",
      y = rlang::as_label(diversity_col),
    ) +
    theme_minimal()
  
  return(p)
}


#Merge low abundance taxa in Others

 merge_low_abundance <- function(physeq, taxa, threshold = 1) {
       # Define your threshold (e.g., 1%)
         threshold <- 1
         
          # Calculate mean relative abundance of each taxon
           mean_abundance <- taxa_sums(physeq) / nsamples(physeq)
           
             # Identify low-abundance taxa
             low_abundance_taxa <- names(mean_abundance[mean_abundance < threshold])
             high_abundance_taxa <- names(mean_abundance[mean_abundance >= threshold])
             
               #Phyloseq for low abundance
               phy_low <- subset_taxa(physeq, taxa_names(physeq) %in% low_abundance_taxa)
               otu_low <- as.data.frame(rowSums(phy_low@otu_table))
               colnames(otu_low) <- "ASVO"
               otu_low1 <- otu_table(otu_low, taxa_are_rows = FALSE)
               tax_low1 <- tax_table(matrix("Others"))
               colnames(tax_low1) <- taxa
               row.names(tax_low1) <- "ASVO"
               
               phy_low1 <- phyloseq(otu_low1, tax_low1, sample_data(physeq))
                 
                   #Phyloseq for high abundance
                   phy_high <- subset_taxa(physeq, taxa_names(physeq) %in% high_abundance_taxa)
                   otu_high <- otu_table(phy_high)
                   tax_high <- tax_table(phy_high)
                   
                     phy_high1 <- phyloseq(otu_high, tax_high, sample_data(physeq))
                     
                       #Merge phyloseq
                       phy_merged <- merge_phyloseq(phy_high1, phy_low1)
                       
                         
                         return(phy_merged)
                 }

