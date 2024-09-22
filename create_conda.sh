#!/bin/bash

# Define environment name and Python version
ENV_NAME="mlflow_env"
PYTHON_VERSION="3.8"
REQUIREMENTS_FILE="requirements.txt"

# Check if conda is installed
if ! command -v conda &> /dev/null
then
    echo "Conda is not installed. Please install Anaconda or Miniconda first."
    exit 1
fi

# Check if the Conda environment exists
if conda info --envs | grep -q "^$ENV_NAME"
then
    echo "Conda environment '$ENV_NAME' already exists."
else
    echo "Creating a new Conda environment: $ENV_NAME with Python $PYTHON_VERSION"
    conda create --name "$ENV_NAME" python="$PYTHON_VERSION" -y
fi

# Activate the Conda environment
echo "Activating the Conda environment: $ENV_NAME"
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$ENV_NAME"

# Check if the requirements.txt file exists
if [ ! -f "$REQUIREMENTS_FILE" ]; then
    echo "Error: $REQUIREMENTS_FILE not found!"
    exit 1
fi

# Install the required packages from requirements.txt
echo "Installing packages from $REQUIREMENTS_FILE"
pip install -r "$REQUIREMENTS_FILE"

echo "All dependencies installed successfully."

# Verify that the installation was successful
echo "Verifying installed packages:"
pip freeze

echo "Environment setup completed successfully."
