#!/bin/bash
#SBATCH --job-name=testscript
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=c64-m512
#SBATCH --output=/users/jvargh7/output/%x_%j.out
#SBATCH --error=/users/jvargh7/error/%x_%j.err
#SBATCH --time=8:00:00
#SBATCH --mem=4G
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=jvargh7@emory.edu

# Print diagnostic information
echo "Job started at $(date)"
echo "Running as user: $(whoami)"
echo "Working directory: $(pwd)"
echo "Files in directory: $(ls -la)"

# Check if R is available and working
R --version

# Run a minimal R command first to test R functionality
R -e 'cat("R is working properly\n")'

# Only if that succeeds, run the full script
if [ $? -eq 0 ]; then
  echo "Running full R script..."
  Rscript /users/jvargh7/kinetic-t2d-hyperc3/code/test_script.R
else
  echo "R test failed, not running main script"
fi

echo "Job completed at $(date)"