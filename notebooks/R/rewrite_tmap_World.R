# this is a quick script to write the 
# World map incuded in the tmap package
# as a shape file and a geojson file

library(tmap)
library(tidyverse)
library(here)
library(sf)

# pre-truncate long columns names in World 
# so st_write doesn't truncate ALL of the column names
# in the shape file. 
# Shape files col names have a max length of 10 characters

old_col <- c()
new_col <- c()

col_names <- colnames(World)

for (col in col_names) {
    if (nchar(col) > 10) {
        old_col <- c(old_col, col)
        new_col <- c(new_col, str_trunc(col, 10, ellipsis = ""))
    }
}

new_World <- World %>% rename_with(~ new_col, all_of(old_col))

# write out the World map to shape and geojson files
# delete any existing files first
# note chickened out on the file delete.
base_datadir <- "data/tmap_World"

# files_to_delete <- dir(path = here(base_datadir), pattern = "tmap_World.*")
# for (fn in files_to_delete) {
#    fn_path <- here(base_datadir, fn)
#    if (file.exists(fn_path)) {
#        print(str_glue("Deleting {fn_path}"))
#        # file.remove(fn)
#    }
# }    

st_write(new_World, here(base_datadir, "tmap_World.shp"), append = FALSE)
st_write(new_World, here(base_datadir, "tmap_World.geojson"), append = FALSE)