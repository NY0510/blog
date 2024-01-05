name: IndexNow

on:
  push:
    branches:
      - main

jobs:
  run-script:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Run script on commit
      run: |
        chmod +x ./github/workflows/IndexNow.sh  
        ./github/workflows/IndexNow.sh  
