# Extensive debugging version

# Print basic system information
cat("===== SYSTEM INFO =====\n")
cat("R version:", R.version.string, "\n")
cat("Working directory:", getwd(), "\n")
cat("User:", Sys.info()["user"], "\n")
cat("Files in directory:", paste(list.files(), collapse=", "), "\n\n")

# Check if config file exists
cat("===== CONFIG FILE CHECK =====\n")
if(file.exists("kthyc3_config.R")) {
  cat("Config file found in current directory\n")
} else {
  cat("WARNING: Config file NOT found in current directory\n")
  cat("Attempting absolute path...\n")
  if(file.exists("/users/jvargh7/kinetic-t2d-hyperc3/code/kthyc3_config.R")) {
    cat("Config file found at absolute path\n")
  } else {
    cat("ERROR: Config file not found at absolute path either\n")
  }
}

# Try to source the config file with error handling
cat("\n===== SOURCING CONFIG =====\n")
tryCatch({
  cat("Attempting to source config file...\n")
  source("/users/jvargh7/kinetic-t2d-hyperc3/code/kthyc3_config.R")
  cat("Config file sourced successfully\n")
  cat("Path variables set to:\n")
  cat("- path_kinetic_t2d_hyperc3_code:", path_kinetic_t2d_hyperc3_code, "\n")
  cat("- path_kinetic_t2d_hyperc3_folder:", path_kinetic_t2d_hyperc3_folder, "\n")
}, error = function(e) {
  cat("ERROR sourcing config file:", conditionMessage(e), "\n")
  quit(status = 1)
})

# Check if dataset exists
cat("\n===== DATASET CHECK =====\n")
dataset_path <- paste0(path_kinetic_t2d_hyperc3_folder, "/working/input/ktana07 dataset.RDS")
cat("Looking for dataset at:", dataset_path, "\n")
if(file.exists(dataset_path)) {
  cat("Dataset found!\n")
} else {
  cat("ERROR: Dataset not found at specified path\n")
  cat("Checking directory structure...\n")
  if(dir.exists(path_kinetic_t2d_hyperc3_folder)) {
    cat("Base folder exists\n")
    if(dir.exists(paste0(path_kinetic_t2d_hyperc3_folder, "/working"))) {
      cat("'working' subfolder exists\n")
      if(dir.exists(paste0(path_kinetic_t2d_hyperc3_folder, "/working/input"))) {
        cat("'input' subfolder exists\n")
        cat("Files in input folder:", 
            paste(list.files(paste0(path_kinetic_t2d_hyperc3_folder, "/working/input")), collapse=", "), "\n")
      } else {
        cat("'input' subfolder does NOT exist\n")
      }
    } else {
      cat("'working' subfolder does NOT exist\n")
    }
  } else {
    cat("Base folder does NOT exist\n")
  }
  quit(status = 1)
}

# Try to load the dataset with error handling
cat("\n===== LOADING DATASET =====\n")
tryCatch({
  cat("Attempting to load dataset...\n")
  dt = readRDS(dataset_path)
  cat("Dataset loaded successfully\n")
  cat("Dataset dimensions:", nrow(dt), "rows x", ncol(dt), "columns\n")
  cat("Column names:", paste(names(dt), collapse=", "), "\n")
}, error = function(e) {
  cat("ERROR loading dataset:", conditionMessage(e), "\n")
  quit(status = 1)
})

cat("\n===== SCRIPT COMPLETED SUCCESSFULLY =====\n")