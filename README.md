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

For a permanent, citable version, please cite the Zenodo archive:

Naccache, C. (2025). Taxo-Analyzer-R: Automated and clear visualization tools for optimized microbiome analysis (v1.0.0). Zenodo. https://doi.org/10.5281/zenodo.15647950

## License for the code

This project is licensed under the [MIT License](LICENSE).

---

Feel free to contribute or open issues for bug reports and feature requests.

## License for the logo

The logo included in this repository is the intellectual property of Chahnez Naccache.  
It is provided for identification purposes only and **may not be copied, modified, or used without explicit permission** from the author.  
For inquiries about logo usage, please contact [chahneznaccache@yahoo.com].

The logo and graphic assets are licensed under the [Creative Commons Attribution-NoDerivatives 4.0 International License (CC BY-ND 4.0)](LICENSE-LOGO.md).

[![License: CC BY-ND 4.0](https://licensebuttons.net/l/by-nd/4.0/88x31.png)](https://creativecommons.org/licenses/by-nd/4.0/)
