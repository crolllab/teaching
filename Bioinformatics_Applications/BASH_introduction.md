# Introduction to the Command Line

## Major Aims

- Have a basic understanding of how to interact with a command line interface
- Know how to use common utilities to download, create, navigate, search and edit folders and files
- Apply command line skills to practical bioinformatics tasks

## Why use the command line?

- **More powerful than graphical interfaces**: Access to specialized tools and fine-grained control
- **Automate repetitive tasks**: Write scripts to repeat analyses effortlessly
- **Handle large datasets**: Process files too large for traditional software
- **Reproducible analyses**: Document every step of your workflow
- **Access to specialized tools**: Most bioinformatics software runs on the command line

## What is a shell?

Put simply, a shell helps you to interact with a computer/server without a graphical interface (where you could click on icons, move things around, etc.). A shell requires you to type commands. If you are familiar with R, you know exactly how this looks like. Our shell here simply uses a different language to interact with the computer compared to the R language.

A shell helps you also navigate files and folders. We'll need to tell the shell though to move "up" or "down" the hierarchy of folders to get around.

Finally, for bioinformatics applications, a shell helps you to repeat analyses, run these in loops, download and copy large files automatically, summarize information, etc. In other words, if you have code that works, running analyses becomes nearly effortless. Writing the code in the first place is often the big challenge!

**Basic concepts:**
- **Terminal/Shell**: The interface for typing commands
- **bash**: Bourne Again SHell - a very simple programming language (other types include `zsh`)
- **Commands and arguments**: Programs you run with options that modify their behavior
- **File system navigation**: Moving between directories/folders
- **Pipes and redirects**: Connecting commands and saving output

## Getting Started

### Using the Terminal

- On **macOS/Linux**: Use the built-in Terminal application
- On **Windows**: Use WSL (Windows Subsystem for Linux) or Git Bash
- Via **VS Code**: Open the integrated terminal (View → Terminal)
- Via **RStudio Server**: Locate the "Terminal" tab (Tools → Terminal → New Terminal)

### First Steps

Create a shell script file to record what you will do. This keeps a good record of all your commands, so that you can refer yourself to this later. In VS Code, create a new file with a `.sh` extension (e.g., `my_commands.sh`). You'll see that the script file gets some automatic coloring (e.g., comment lines).

### Tips to Save You Time

- **Write code in your script file** and execute commands by copy-pasting to the terminal or using keyboard shortcuts (CMD/CTRL + ENTER)
- **Use auto-complete**: Start typing a command (e.g., `ec`) and press TAB twice to see available options. Type more letters and TAB again to complete
- **Auto-complete works for files and folders too**: This not only saves time but also avoids typos
- **Use the up/down arrow keys** to cycle through previously run commands
- **Clear your terminal**: Type `clear` or press CTRL+L

## Essential Unix Commands

The following commands are fundamental to working on the command line. Try each one as you read!

### The `pwd` command

**"Present working directory"** - This tells you the place (or more precisely the "path") where you are currently.

```bash
pwd
```

Example output: `/home/daniel` means that I am in a folder called `home` placed at the top of the folder hierarchy on the computer. This is the `/`. Inside `home`, there is a folder with my name `daniel`.

This command is very useful to see where you are in case you get lost.

### The `mkdir` command

**"Make directory"** - Creates a new directory (folder).

```bash
mkdir my_first_scripts
```

**Tip**: Avoid using spaces in names. It is not forbidden but inconvenient. Use `_` instead.

**Useful option**: `mkdir -p` creates parent directories as needed:
```bash
mkdir -p project/data/raw
```

### The `cd` command

**"Change directory"** - Allows you to change to a different directory (i.e. folder).

```bash
# Check where you are
pwd

# Check that your new folder exists
ls
# Do you see "my_first_scripts"?

# Change to your new directory
cd my_first_scripts

# Verify your new location
pwd

# Go back one level (go "up" in the hierarchy)
cd ..

# Go to your home directory
cd

# Go multiple folders in with a single command
cd /folder1/subfolder/subsubfolder
```

### The `ls` command

**"List"** - Provides you with a list of files and folders in your current directory.

```bash
# Basic list
ls

# Long format with details
ls -l

# Show file sizes in human-readable format
ls -lh

# Show all files including hidden files (starting with .)
ls -a

# Combination of options
ls -lsh

# Recursive listing (shows contents of subdirectories)
ls -R
```

### The `echo` command

Displays text or writes text to files.

```bash
# Display text in terminal
echo "Hello world"

# Write text to a new file (overwrites if exists)
echo "Hello world" > new_file.txt

# Append text to an existing file
echo "Hello again!" >> new_file.txt
```

**Tip**: Use `ls -lsh` to check whether the new file was created.

**Note**: The `.txt` extension is not necessary. The computer creates a text file regardless. Extensions are used by operating systems to launch the correct application.

### The `cat` command

**"Concatenate"** - Displays the contents of a file.

```bash
cat new_file.txt
```

Do you see the expected text based on your code for `echo`?

### The `head` and `tail` commands

Show only the first (`head`) or last (`tail`) lines of a file.

```bash
# Show first 10 lines (default)
head new_file.txt

# Show only the first line
head -n 1 new_file.txt

# Show last 10 lines (default)
tail new_file.txt

# Show only the last 2 lines
tail -n 2 new_file.txt
```

**Exercise**: Use the `echo "Hello again!" >> new_file.txt` command to add at least 11 lines to your `new_file.txt`. Use now the `head` command with output redirection to create a new file called `only_the_top3.txt` containing the first three lines of `new_file.txt`:

```bash
head -n 3 new_file.txt > only_the_top3.txt
```

Use `cat` to check that it worked as intended.

### The `less` command

Shows you the beginning of a large file and lets you scroll down using the arrow keys.

```bash
less large_file.txt
```

**Navigation in less**:
- Arrow keys or Page Up/Down to scroll
- Type `/` to search for text
- Type `q` to quit

### The `rm` command

**"Remove"** - Deletes files and folders.

```bash
# Delete a single file
rm my_script_file.sh

# Delete a folder (recursive)
rm -r my_folder
```

**⚠️ Warning**: Be careful not to delete important files! Unlike graphical interfaces, there's no trash/recycle bin.

**Using wildcards**:
```bash
# Delete all files ending with .sh
rm *.sh

# Delete all files starting with "test"
rm test*
```

### Copying and Moving: `cp` and `mv`

The `cp` copy command works simply as a "what" to "where" command.

```bash
# Copy a file
cp original.txt copy.txt

# Move or rename a file
mv old_name.txt new_name.txt

# Move a file to a directory
mv file.txt my_folder/
```

**Exercise**: Let's practice these commands:

```bash
# Create a file (we'll use a downloaded file next)
echo "This is a test" > test_protein.fasta

# Create a copy
cp test_protein.fasta test_protein.second_copy.fasta

# Check it worked
ls -lhs

# Create a new folder
mkdir new_folder

# Move the copied file into this folder
mv test_protein.second_copy.fasta new_folder

# Check the file "disappeared"
ls -lhs

# Check the content of the folder
ls -lhs new_folder
```

**Copying entire folders**: Use the option `-r` (recursive):

```bash
# Create a second folder
mkdir second_folder

# Copy the entire new_folder into second_folder
cp -r new_folder second_folder

# Check the contents
ls -lhs
ls -lhs second_folder
ls -lhs second_folder/new_folder
```

## Working with Files

### Text Editing with `nano`

`nano` is a simple text editor accessible in the terminal.

```bash
nano my_code.sh
```

You have now entered the text editor. Type any text you like. Press Enter for a new line.

**Key commands**:
- **CTRL + X**: Exit
- **Y**: Confirm save
- **N**: Don't save
- **CTRL + O**: Save without exiting

Try out some of the other options offered by `nano`. Practice so it feels more intuitive.

### Downloading Files: `wget` and `curl`

The first step is to find the correct link to a file. The link should typically end in a recognizable format (.txt, .html, .jpeg, .pdf, etc.).

**Using wget**:
```bash
wget https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png
```

Check with `ls -lhs` whether you've actually saved the file.

`wget` stands for "World Wide Web and get" - it downloads files from the internet.

**Download a FASTA file**:
```bash
wget https://raw.githubusercontent.com/crolllab/teaching/master/Bioinformatics_Tools/Course_1_Intro_CL/datasets/QTW58944_protein.fasta
```

**Exercise**: Find another file on the internet and try to download it with `wget`.

### File Information Commands

```bash
# Word, line, and character count
wc file.txt

# File size in human-readable format
du -h file.txt

# Determine file type
file data.txt
```

## Pipes and Redirects

Pipes and redirects allow you to connect commands and control where output goes.

### Redirecting Output

```bash
# Write output to a file (overwrite)
ls > file_list.txt

# Append output to a file
ls >> file_list.txt
```

### Piping Between Commands

The pipe `|` takes the output from one command and uses it as input for another.

```bash
# Count lines containing "ATP"
cat genes.txt | grep "ATP" | wc -l

# View first 10 lines of a large file
cat large_file.txt | head

# Find and count specific patterns
ls -l | grep ".txt" | wc -l
```

### Chaining Commands

Use `&&` to run multiple commands in sequence (only if the previous succeeded):

```bash
cd data && ls -l | head
# Change directory AND list first 10 entries
```

Use `;` to run commands regardless of success:

```bash
cd data ; ls -l
# Run ls even if cd fails
```

## Bioinformatics File Formats

Common formats you'll encounter in bioinformatics:

- **FASTA**: Sequence data (.fasta, .fa, .fna)
- **FASTQ**: Sequencing reads with quality scores (.fastq, .fq)
- **SAM/BAM**: Sequence alignments
- **VCF**: Variant calls (SNPs, indels)
- **GFF/GTF**: Genome annotations (coordinates of genes, features on chromosomes)
- **BED**: Genomic regions (similar to GFF but simpler)

### Example: FASTA Format

```
>sequence_1 description
ATGCGATCGATCGATCGATCGATCG
ATCGATCGATCGATCGATCGATCGA
>sequence_2 description
GCTAGCTAGCTAGCTAGCTAGCTAG
```

**Structure**:
- Header line starts with `>`
- Followed by identifier and optional description
- Sequence on following lines


## Troubleshooting Tips

### General Troubleshooting

- **Check your location**: Are you in the correct folder? Use `pwd` to check where you are and `cd` if necessary
- **Read error messages**: They may not be fully understandable, but they provide clues (missing file, permission issues, etc.)
- **Use Claude/ChatGPT**: If you want to check out a command like `cp`, state what you want to do. For example, "I want to copy a file called `file1.txt` to a new file called `file2.txt` in the same folder. What command should I use?". Stating that you work on Linux is also helpful. If you try a command and get an error message, copy your command AND the error message to the AI assistant and ask for help. This is a great way to learn how to troubleshoot and understand error messages.
- **Improve your search/AI skills**: Learn to phrase queries effectively to find solutions


### Common Issues

**File not found**: Check spelling, location, and whether the file actually exists with `ls`

**Permission denied**: You may need to change file permissions or use `sudo` (only if you are on your own computer, not possible on the server). Be careful with `sudo` as it gives you administrative privileges and can damage a system.

**Command not found**: The software may not be installed, or you need to specify the full path to the program

## Synthesis Exercise

Try to accomplish the following tasks to practice what you've learned:

1. **Download a protein sequence file**:
   ```bash
   wget https://raw.githubusercontent.com/crolllab/teaching/master/Bioinformatics_Tools/Course_1_Intro_CL/datasets/QTW58944_protein.fasta
   ```

2. **Edit the file using nano**:
   ```bash
   nano QTW58944_protein.fasta
   ```
   - Edit the first line of the file
   - Call it simply "delta variant"
   - Make sure to keep the `>` at the beginning of the first line
   - Save and exit (CTRL + X, then Y, then ENTER)

3. **Rename the file**:
   ```bash
   mv QTW58944_protein.fasta Delta_variant_proteins.fasta
   ```

4. **View and copy the file content**:
   ```bash
   cat Delta_variant_proteins.fasta
   ```
   - Copy the entire content by selecting the text
   - Use COMMAND + C (Mac) or CTRL + C (Windows)

5. **Use NCBI BLAST**:
   - Go to the [NCBI Blast website](https://blast.ncbi.nlm.nih.gov/Blast.cgi)
   - Click on "Protein BLAST"
   - Paste the entire text into the "Enter Query Sequence" field
   - Scroll down and click the "BLAST" button
   - Wait a couple of minutes for results (the page should refresh automatically)

6. **Interpret the results**:
   - What do you think you have done?
   - What do we see in the results?
   - Click on "Results for" to select different sequences

## Additional Resources

### Online Tutorials

- [Software Carpentry Shell Novice](https://swcarpentry.github.io/shell-novice/)
- [Bash Guide for Beginners](https://tldp.org/LDP/Bash-Beginners-Guide/html/)
- [Command Line Crash Course](https://learnpythonthehardway.org/book/appendixa.html)
- [explainshell.com](https://explainshell.com/) - Explains shell commands in detail

### Books

- **Bioinformatics Data Skills** by Vince Buffalo - Excellent resource for command-line bioinformatics
- **Practical Computing for Biologists** by Haddock & Dunn - Covers command line, Python, and more
- **R for Data Science** by Wickham & Grolemund - For data analysis with R


### Quick Reference

```bash
# Navigation
pwd                 # Print working directory
ls                  # List directory contents
cd directory        # Change directory
cd ..               # Go up one level
cd                  # Go to home directory

# File operations
mkdir folder        # Create directory
cp source dest      # Copy files
mv source dest      # Move/rename files
rm file            # Remove files
rm -r folder       # Remove directory

# Viewing files
cat file           # Display file contents
less file          # View file page by page
head file          # Show first lines
tail file          # Show last lines
head -n 5 file     # Show first 5 lines
tail -n 5 file     # Show last 5 lines

# File information
wc file.txt         # Word count
du -h file.txt      # File size
file data.txt       # File type
ls -lh              # List with sizes

# Creating/editing
nano file.txt       # Edit file (simple editor)
echo "text" > file  # Write to file
echo "text" >> file # Append to file

# Downloading
wget URL            # Download file from URL

# Searching and filtering
grep "pattern" file # Search for pattern in file
grep -i "pattern"   # Case-insensitive search

# Pipes and redirects
command > file      # Redirect output to file
command >> file     # Append output to file
cmd1 | cmd2         # Pipe output of cmd1 to cmd2
cmd1 && cmd2        # Run cmd2 if cmd1 succeeds
```

## What's Next?

- **Practice regularly**: The more you use the command line, the more comfortable you'll become
- **Build your own reference sheet**: Keep notes on commands you use frequently
- **Explore advanced topics**: Regular expressions, shell scripting, automation
- **Apply to your research**: Use these skills in your bioinformatics projects

Good luck with your command line journey!

