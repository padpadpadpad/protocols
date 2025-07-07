# post render script for organising files after rendering

# 1. Move all files from protocol_output/protocol_input to protocol_output

# list files in protocol_output/protocol_input
files <- list.files(
  'protocol_output/protocol_input',
  full.names = TRUE,
  recursive = TRUE
)

# move files into "protocol_output" directory
for (file in files) {
  # get the file name
  file_name <- basename(file)

  # create the destination path
  dest_path <- file.path('protocol_output', file_name)

  # move the file
  file.rename(file, dest_path)
}

# remove protocol_output/protocol_input
dirs <- unlink('protocol_output/protocol_input', recursive = TRUE)


# 2. move all files from protocol_input to their own directories in protocol_output

# list files
files <- list.files('protocol_input', full.names = TRUE, recursive = TRUE)

# create directory for each in protocol output
for (file in files) {
  # get the file name without extension
  file_name <- basename(file) |> tools::file_path_sans_ext()

  # create the directory path
  dir_path <- file.path('protocol_output', file_name)

  # create the directory if it does not exist
  if (!dir.exists(dir_path)) {
    dir.create(dir_path, recursive = TRUE)
  }
}

# copy input files into the right directory, rename them index.qmd
for (file in files) {
  # get the file name without extension
  file_name <- basename(file) |> tools::file_path_sans_ext()

  # create the destination path
  dest_path <- file.path('protocol_output', file_name, 'index.qmd')

  # copy the file to the destination path
  file.copy(file, dest_path, overwrite = TRUE)
}

# 3. Move all correct output files into their respective directories

# list files in protocol_output
files <- list.files(
  'protocol_output',
  full.names = TRUE,
  pattern = ".html|.docx|.pdf"
)

# move them into the correct directory
for (file in files) {
  # get the file name
  file_name <- basename(file) |> tools::file_path_sans_ext()

  # create the destination path
  dest_path <- file.path('protocol_output', file_name, basename(file))

  # move the file
  file.rename(file, dest_path)
}

# for any index.qmd in finished directory, change
# execute: eval: false to execute: freeze
finished_files <- list.files(
  'protocol_output/finished',
  full.names = TRUE,
  pattern = "index.qmd",
  recursive = TRUE
)

# change eval: false to eval: freeze
for (file in finished_files) {
  # read the file
  content <- readLines(file)

  # replace eval: false with eval: freeze
  content <- gsub("eval: false", "freeze: true", content)

  # write the file back
  writeLines(content, file)
}
