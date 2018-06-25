# file: load_file.R
# date: 17-July-2017
# author: Dushan Yovetich
# Description: 
# Load and manipulate text files used for text mining.   

# Read a specified zipped file.
read_text_file <- function(file_path, file_name){
  file_con <- unz(file_path,filename = file_name, encoding = "UTF-8")
  f <- readr::read_table(file_con,col_names = "text", 
                         col_types = readr::cols(text = "c"))
  invisible(f)
}

# Sample from a table. Include optional argument to write 
# sample to file.
sample_file <- function(file_data, 
                       sample_size = 0.01, 
                       to_file = FALSE, 
                       file_path = getwd()){
  set.seed(21052017)
  s <- dplyr::sample_frac(tbl = file_data,size = sample_size,replace = FALSE)
  
  if (to_file == TRUE){
    obj_name <- deparse(substitute(file_data))
    write_to_file(s,file_path, obj_name)
  }
  invisible(s)
}

# Write sample data to text file in the specified directory. File automatically
# named.
write_to_file <- function(file_data,file_path, obj_name){
  if (!dir.exists(file_path)) dir.create(file_path)
  fn <- paste0(file_path,"/","sample_",obj_name,".txt")
  readr::write_lines(file_data,fn,append = FALSE)
}