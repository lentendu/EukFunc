`EukFunc` is a R package providing a database and tools for the functional assignment of microbial eukaryotes (fungi, protists, and nematodes) in terrestrial environments from 18S rRNA gene sequence data. By function, we mean the type of nutrient uptake (including prey information if organisms are consumers). Therefore, the database does not include trait data.

The database is based on [PR2 v4.12](https://github.com/pr2database/pr2database/commit/31e36ca) [(Guillou et al., 2013)](https://doi.org/10.1093/nar/gks1160), a curated database of 18S rRNA gene sequences following the most recent eukaroytic taxonomy [(Adl et al., 2019)](https://doi.org/10.1111/jeu.12691). Only taxa found in terrestrial environment are kept (i.e. by removing exclusively marine and exclusively freshwater organisms ).

Update to current version of PR2 (v5.0.0) will follow soon.

Installation
------------

`EukFunc` can be installed from GitHub using:

```r
install.packages("remotes")
remotes::install_github("lentendu/EukFunc")
library(EukFunc)
```

Usages
------

The database is provided in six different flavors:
* a species database `DBu` or `data(DBu)`
* a species database with only the main functional class including detailed for symbiotroph (parasites, mycorrhiza, host phototroph, others)  `DBu_main` or `data(DBu_main)`
* an accession based database `DBf` or `data(DBf)`
* a taxonomy condensed database over all functional information `DBc` or `data(DBc)`
* a taxonomy condensed database over the main functional class including detailed for symbiotroph (parasites, mycorrhiza, host phototroph, others) `DBc_main` or `data(DBc_main)`
* a taxonomy condensed database with only the main functional class `DBc_minimal` or `data(DBc_minimal)`


For convenience, the species database is also available as a TAB-separated file [FuncDB_species.tsv](data-raw/FuncDB_species.tsv)

The main functional classes are: phototroph, predator, saprotroph, symbiotroph and unknown.

The intention of the database is to provide a functional annotation of 18S rRNA gene reads obtained from high-throughput sequencing by comparing those to functionally annotated reference sequences. As functional annotations are linked to a taxonomic path (either species, genus or family), these functional groups could also be used with other type of data (other genomic markers, other taxonomic identification methods).

Tools are provided to assign the functional information from a taxonomic table or list of taxonomic path ( `assign_path` ), a list of species names ( `assign_sp` ) and a list of best match accessions ( `assign_genbank` ). Read commands helps for usage information and examples.

When assigning from a taxonomic table or a path ( `assign_path` ), different condensed databases can be provided (e.g. `DBc` or `DBc_main`). Own condensed database can be created with the tool `functionize`.


Database governance
------

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

Guillaume Lentendu, David Singer, Sabine Agatha, Mohammad Bahram, S. Emilia Hannula, Johannes A Helder, Leho Tedersoo, Walter Traunspurger, Enrique Lara, Stefan Geisen (2024), EukFunc: A holistic Eukaryotic Functional reference for automated profiling of soil eukaryotes, *submitted*
