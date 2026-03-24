# Tutorial 1: Conservation Genomics and Translocations

## 1. Accessing RStudio Server

1. Check the link on Moodle for the server, username and password. 
2. Select a username and fill in your name to claim it.
2. Access RStudio Server using the provided URL.

## 2. Getting the tutorial file from GitHub

The fastest way is to download only the tutorial file by running this in the R console:

```r
download.file(
  "https://raw.githubusercontent.com/crolllab/teaching/master/Ecological_Genomics/Tutorial_1_Translocation.qmd",
  destfile = "Tutorial_1_Translocation.qmd",
  method   = "wget"
)
```

Alternatively, you can clone the entire repository to get all the tutorial files and future updates:

1. In RStudio, open the **Terminal** tab (bottom-left pane, next to Console).
2. Run:
   ```bash
   git clone https://github.com/crolllab/teaching.git
   ```
3. Navigate to the tutorial:
   ```bash
   cd teaching/Ecological_Genomics
   ```
4. Open `Tutorial_1_Translocation.qmd` from the **Files** pane (bottom-right) or with:
   ```r
   file.edit("Tutorial_1_Translocation.qmd")
   ```

To pull the latest updates at any point:
```bash
git pull
```

Optionally, you can also download the `app.R`file, which contains the Shiny app code used in Part 5 of the tutorial:

```r
download.file(
  "https://raw.githubusercontent.com/crolllab/teaching/master/Ecological_Genomics/app.R",
  destfile = "app.R",
  method   = "wget"
)
```

## 3. Running the tutorial

- Work through the `.qmd` file section by section, running each code chunk with the **Run** button (▶) or `Ctrl+Enter`.
- When you reach Part 5, you will create your own `app.R` file — instructions are in the tutorial.
