`EukFunc` is a R package providing a database and tools for the functional assignment of microbial eukaryotes (fungi, protists, and nematodes) in terrestrial environments from 18S rRNA gene sequence data. By function, we mean the type of nutrient uptake (including prey information if organisms are consumers). Therefore, the database does not include trait data.

The database is based on [PR2 v5.0.0](https://github.com/pr2database/pr2database) [(Guillou et al., 2013)](https://doi.org/10.1093/nar/gks1160), a curated database of 18S rRNA gene sequences following the most recent eukaroytic taxonomy [(Adl et al., 2019)](https://doi.org/10.1111/jeu.12691). Only taxa found in terrestrial environment are kept (i.e. by removing exclusively marine and exclusively freshwater organisms).

Installation
------------

`EukFunc` can be installed from GitHub using:

```r
install.packages("remotes")
remotes::install_github("lentendu/EukFunc")
```

Quickstart
----------

The main function is `assign_func`, it accept either a vector of taxonomy(ies), a data-frame with a `taxonomy` column or a data-frame with column named after the [PR2 9-levels taxonomy](https://pr2-database.org/documentation/pr2-taxonomy-9-levels/).

```r
library(EukFunc)
head(taxo_exa)
assign_func(taxo_exa)
?assign_func()
```

Detailed usages
---------------

The database is provided in six different flavors:
* a species database `DBu` or `data(DBu)`
* a species database with only the main functional class including detailed for symbiotroph (parasites, mycorrhiza, host phototroph, others)  `DBu_main` or `data(DBu_main)`
* an accession based database `DBf` or `data(DBf)`
* a taxonomy condensed database over all functional information `DBc` or `data(DBc)`
* a taxonomy condensed database over the main functional class including detailed for symbiotroph (parasites, mycorrhiza, host phototroph, others) `DBc_main` or `data(DBc_main)`
* a taxonomy condensed database with only the main functional class `DBc_minimal` or `data(DBc_minimal)`


For convenience, the species database is also available as a TAB-separated file [EukFunc.pr2.5.0.0.tsv](data-raw/EukFunc.pr2.5.0.0.tsv)

The main functional classes are: phototroph, predator, saprotroph, symbiotroph and unknown.

The intention of the database is to provide a functional annotation of 18S rRNA gene reads obtained from high-throughput sequencing by comparing those to functionally annotated reference sequences. As functional annotations are linked to a taxonomic path (either species, genus or family), these functional groups could also be used with other type of data (other genomic markers, other taxonomic identification methods).

Tools are provided to assign the functional information from a taxonomic table or list of taxonomic path ( `assign_path` ), a list of species names ( `assign_sp` ) and a list of best match accessions ( `assign_genbank` ).
The `assign_clade` function can be used to assign function from a taxonomic path no created with PR2 v5.0.0 (e.g. GenBank, Silva, UNITE, PR2 version 4.x with the 8 rank's taxonomy).
The `assign_majority` function can be used to improve the proportion of assigned clades be need to be used with caution as it can causes misassignments on some rare cases.
Read command's help pages for usage information and examples.

When assigning from a taxonomic table or a path or a clade ( `assign_path`, `assign_clade` ), different condensed databases can be provided (e.g. `DBc`, `DBc_main` or `DBc_minimal`). Own condensed database can be created with the tool `functionize`.

Further usage examples can be found in the analyses conducted for the publish paper ([Lentendu *et al.*, 2025](#citation)), and can be found in the Rmd file [Lentendu_et_al.2025.Supplementary_R_Code.Rmd](data-raw/Lentendu_et_al.2025.Supplementary_R_Code.Rmd)

Database governance
-------------------

**Database:**

- Guillaume Lentendu
- David Singer
- Stefan Geisen
- Enrique Lara

**R package:**

- Guillaume Lentendu


**Fungi:**

- Mohammad Bahram
- S. Emilia Hannula
- Leho Tedersoo

**Ciliates:**

- Sabine Agatha

**other protists**

- Enrique Lara

**Nematodes**

- Stefan Geisen
- Johannes Helder
- Walter Traunspurger


Citation
--------

Guillaume Lentendu, David Singer, Sabine Agatha, Mohammad Bahram, S. Emilia Hannula, Johannes A Helder, Leho Tedersoo, Walter Traunspurger, Enrique Lara, Stefan Geisen (2025), EukFunc: A holistic Eukaryotic Functional reference for automated profiling of soil eukaryotes, *Molecular Ecology Ressources*, in press, e14118. doi: [10.1111/1755-0998.14118](https://doi.org/10.1111/1755-0998.14118)
