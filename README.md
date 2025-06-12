![image](https://github.com/user-attachments/assets/1080de67-a746-4bc1-9168-d3dedf7d4c7e)


# Taxo-Analyzer-R

Taxo-Analyzer-R provides custom R functions designed for taxonomic analysis and visualization of microbial community data. These tools facilitate automated calculation of taxon richness, sample-wise taxonomic summaries, diversity analysis, and the creation of publication-quality ecological plots.

## Features

- Calculate taxon counts at multiple taxonomic ranks (`somme_rang_taxo`)
- Compute taxon richness per sample (`rang_taxo_per_sample`)
- Visualize alpha diversity against environmental parameters (`plot_div_vs_params`)
- Merge low-abundance taxa into an "Others" category for clearer plots (`merge_low_abundance`)

## Installation

This project requires the following R packages:

- phyloseq
- ggplot2
- dplyr
- tidyr
- broom
- ggpmisc

You can install them via CRAN: 
```
install.packages(c("phyloseq", "ggplot2", "dplyr", "tidyr", "broom", "ggpmisc"))
```
## Usage

1. Clone or download this repository.

2. Load the functions into your R session:

```
source("Taxo-Analyzer.R")
```

3. Use the functions with your phyloseq objects or data frames. For example:

```
# Calculate taxon counts by rank:
taxon_counts <- somme_rang_taxo(final_rar)

# Plot diversity vs parameters:
p <- plot_div_vs_params(data, diversity_col = "Shannon", param_cols = c("pH", "Temperature"), group_col = "Site")
print(p)
```


## Citation

If you use this code in your research, please cite this repository as:

> Chahnez.Naccache, Taxo-Analyzer-R, GitHub repository, https://github.com/Chaki0107/Taxo-Analyzer-R

## License

This project is licensed under the [MIT License](LICENSE).

---

Feel free to contribute or open issues for bug reports and feature requests.

