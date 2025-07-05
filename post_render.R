# move all files post render into the correct directory

# list files
files <- list.files('protocol_output', full.names = TRUE, recursive = TRUE)

# move files into "protocol_output" directory
for (file in files) {
  # get the file name
  file_name <- basename(file)

  # create the destination path
  dest_path <- file.path('protocol_output', file_name)

  # move the file
  file.rename(file, dest_path)
}

# remove any directories within "protocol_output"
dirs <- list.dirs('protocol_output', full.names = TRUE, recursive = FALSE)

for (dir in dirs) {
  # remove the directory
  unlink(dir, recursive = TRUE)
}

# remove any .tex files in protocol_input
tex_files <- list.files(
  'protocol_input',
  pattern = '\\.tex$',
  full.names = TRUE
)
for (tex_file in tex_files) {
  # remove the .tex file
  unlink(tex_file)
}
