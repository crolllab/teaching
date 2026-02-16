# Introduction to Visual Studio Code (VS Code)

## Major Aims

- Understand the VS Code interface and its key components
- Connect VS Code to your GitHub account
- Install essential extensions for bioinformatics work
- Set up remote SSH connections to work on servers
- Create, edit, and save files on remote systems
- Use GitHub Copilot as an AI coding assistant

## What is VS Code?

Visual Studio Code (VS Code) is a free, open-source code editor developed by Microsoft. It has become one of the most popular development environments due to its:

- **Lightweight yet powerful**: Fast startup, but feature-rich
- **Extensibility**: Thousands of extensions for different languages and tools
- **Integrated terminal**: Run commands without leaving the editor
- **Git integration**: Built-in version control
- **Remote development**: Work on remote servers seamlessly
- **AI assistance**: GitHub Copilot integration for intelligent code completion

For bioinformatics, VS Code is particularly valuable because you can edit code locally while running it on powerful remote servers, all within a single interface.

## Installing VS Code

### Download and Installation

1. Go to [https://code.visualstudio.com/](https://code.visualstudio.com/)
2. Download the version for your operating system:
   - **macOS**: Download the .zip file, extract it, and drag to Applications folder
   - **Windows**: Download the installer (.exe) and run it
   - **Linux**: Download the .deb or .rpm package, or use snap

3. Launch VS Code after installation

## Understanding the VS Code Interface

When you first open VS Code, you'll see several key areas:

### Main Visual Elements

```
┌─────────────────────────────────────────────────────────────┐
│  Menu Bar (File, Edit, Selection, View, etc.)              │
├───┬─────────────────────────────────────────────────────────┤
│   │  Title Bar (filename, path)                      ⚙️ ▢ ✕│
├───┼─────────────────────────────────────────────────────────┤
│ A │                                                          │
│ c │         Editor Area                                      │
│ t │         (where you write code)                          │
│ i │                                                          │
│ v │                                                          │
│ i │                                                          │
│ t │                                                          │
│ y │─────────────────────────────────────────────────────────│
│   │         Panel Area                                       │
│ B │         (Terminal, Output, Problems, Debug Console)     │
│ a │                                                          │
│ r │                                                          │
└───┴─────────────────────────────────────────────────────────┘
```

### 1. Activity Bar (Left Side)

The vertical bar on the far left contains icons for major features:

- **Explorer** (📁): Browse and manage files and folders
- **Search** (🔍): Find and replace across files
- **Source Control** (branch icon): Git version control
- **Run and Debug** (▶️): Debug your code
- **Extensions** (squares icon): Install and manage extensions
- **Remote Explorer** (monitor icon): Manage remote connections (appears after installing Remote SSH extension)
- **Accounts** (person icon): Sign in to GitHub and other services

**Tip**: Click an icon to open its panel, click again to close it.

### 2. Side Bar

Opens next to the Activity Bar when you click an activity. Shows the content related to your selected activity:

- File tree when Explorer is selected
- Search results when Search is selected
- Git changes when Source Control is selected
- List of extensions when Extensions is selected

### 3. Editor Area (Center)

The main area where you edit files. Key features:

- **Tabs**: Each open file appears as a tab at the top
- **Split editors**: Drag a tab to the side to view multiple files simultaneously
- **Breadcrumbs**: Shows your current location in the file/folder structure (top of editor)
- **Minimap**: Small preview of your entire file (right side, can be disabled)

### 4. Panel Area (Bottom)

Contains several useful panels (toggle with `Cmd/Ctrl + J`):

- **Terminal**: Run command-line commands
- **Output**: Shows output from extensions and tasks
- **Problems**: Lists errors and warnings in your code
- **Debug Console**: For debugging sessions

### 5. Status Bar (Very Bottom)

Shows information about your current file and workspace:

- Current line and column number
- File encoding and line endings
- Language mode (e.g., Python, Markdown, Bash)
- Git branch name
- Remote connection status
- Errors and warnings count

## Setting Up Your GitHub Account

### Creating a GitHub Account (if needed)

1. Go to [https://github.com](https://github.com)
2. Click "Sign up" and follow the registration process
3. Verify your email address

### Applying for GitHub Student Benefits (Strongly Recommended)

GitHub offers free access to GitHub Copilot and other tools for students:

1. Go to [https://education.github.com/students](https://education.github.com/students)
2. Click "Sign up for Student Developer Pack"
3. Provide proof of enrollment (student ID, enrollment verification, etc.)
4. Wait for approval (usually within a few days)

**Note**: Even without the student pack, you can use VS Code's free features. Copilot requires either a student account, a paid subscription, or sometimes institutional access.

### Signing into GitHub in VS Code

1. Click the **Accounts** icon (person silhouette) in the Activity Bar (bottom left)
2. Click **"Sign in with GitHub to use GitHub Copilot"** or **"Sign in to Sync Settings"**
3. A browser window will open asking you to authorize VS Code
4. Click **"Authorize Visual-Studio-Code"**
5. You may be prompted to allow VS Code to open - click **"Open"**
6. You should now see your GitHub account name in the Accounts section

**Benefits of signing in**:
- Sync your settings across devices
- Access GitHub Copilot (if you have access)
- Easier Git operations (no need to enter credentials repeatedly)
- Access to GitHub repositories directly from VS Code

## Installing Essential Extensions

Extensions add powerful functionality to VS Code. Here's how to install them:

### How to Install Extensions

1. Click the **Extensions** icon (four squares) in the Activity Bar
2. Search for the extension name in the search box
3. Click **"Install"** on the extension you want
4. Some extensions may require reloading VS Code (click **"Reload"** if prompted)

### Essential Extensions for Bioinformatics

Search for and install these extensions:

#### 1. Remote - SSH (Essential!)
- **ID**: `ms-vscode-remote.remote-ssh`
- **Purpose**: Connect to remote servers via SSH
- **Publisher**: Microsoft
- Click **Install**

#### 2. Remote - SSH: Editing Configuration Files
- **ID**: `ms-vscode-remote.remote-ssh-edit`
- **Purpose**: Easily edit SSH configuration files
- **Publisher**: Microsoft
- Click **Install**

#### 3. Remote Explorer
- **ID**: `ms-vscode.remote-explorer`
- **Purpose**: Manage remote connections
- **Publisher**: Microsoft
- Click **Install**

#### 4. Python (Optional)
- **ID**: `ms-python.python`
- **Purpose**: Python language support, debugging, linting
- **Publisher**: Microsoft
- Click **Install**

#### 5. R (Recommended)
- **ID**: `REditorSupport.r`
- **Purpose**: R language support
- **Publisher**: R Editor Support
- Click **Install**

#### 6. GitHub Copilot (if you have access)
- **ID**: `GitHub.copilot`
- **Purpose**: AI-powered code completion
- **Publisher**: GitHub
- Click **Install**
- You'll need to authorize it with your GitHub account

#### 7. GitHub Copilot Chat (if you have access)
- **ID**: `GitHub.copilot-chat`
- **Purpose**: Chat interface for GitHub Copilot
- **Publisher**: GitHub
- Click **Install**

#### 8. Markdown All in One
- **ID**: `yzhang.markdown-all-in-one`
- **Purpose**: Markdown editing with preview
- **Publisher**: Yu Zhang
- Click **Install**

#### 9. Rainbow CSV
- **ID**: `mechatroner.rainbow-csv`
- **Purpose**: Colorize CSV files for easier reading
- **Publisher**: mechatroner
- Click **Install**

#### 10. GitLens (Optional but Recommended)
- **ID**: `eamodio.gitlens`
- **Purpose**: Enhanced Git integration
- **Publisher**: GitKraken
- Click **Install**

## Setting Up Remote SSH Connection

Remote SSH allows you to work on files located on a remote server (like LEGcompute) as if they were on your local machine.

### Prerequisites

You should have:
- SSH access credentials (username, server address)
- SSH key pair (recommended) or password

### Step 1: Generate SSH Keys (If Not Already Done)

SSH keys are more secure and convenient than passwords.

#### On macOS/Linux:

1. Open Terminal
2. Generate a key pair:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
3. Press Enter to accept the default file location (`~/.ssh/id_ed25519`)
4. Enter a passphrase (on a personal computer, do not set one for convenience)
5. Your keys are now in:
   - Private key: `~/.ssh/id_ed25519`
   - Public key: `~/.ssh/id_ed25519.pub`

#### On Windows:

1. Open PowerShell or Command Prompt
2. Generate a key pair:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
3. Press Enter to accept the default file location (`C:\Users\YourUsername\.ssh\id_ed25519`)
4. Enter a passphrase (optional but recommended)
5. Your keys are now in:
   - Private key: `C:\Users\YourUsername\.ssh\id_ed25519`
   - Public key: `C:\Users\YourUsername\.ssh\id_ed25519.pub`

### Step 2: Copy Your Public Key to the Server

You need to add your public key to the server's authorized keys.

#### On macOS/Linux:

```bash
ssh-copy-id username@legcompute3.unine.ch
```

Enter your password when prompted.

#### On Windows:

If `ssh-copy-id` is not available, manually copy the key:

1. Display your public key:
   ```bash
   type %USERPROFILE%\.ssh\id_ed25519.pub
   ```

2. Copy the output

3. Connect to your server:
   ```bash
   ssh username@legcompute3.unine.ch
   ```

4. On the server, add the key:
   ```bash
   mkdir -p ~/.ssh
   echo "YOUR_PUBLIC_KEY" >> ~/.ssh/authorized_keys
   chmod 600 ~/.ssh/authorized_keys
   chmod 700 ~/.ssh
   ```

### Step 3: Create SSH Config File

The SSH config file makes connecting much easier by storing connection details.

#### On macOS/Linux:

1. Open Terminal
2. Create or edit the config file:
   ```bash
   mkdir -p ~/.ssh
   nano ~/.ssh/config
   ```

3. Add your server configuration (adjust "username"):
   ```
   Host legcompute
       HostName legcompute3.unine.ch
       User username
       IdentityFile ~/.ssh/id_ed25519
       ForwardAgent yes
   ```

4. Save and exit (CTRL+X, then Y, then Enter)

5. Set proper permissions:
   ```bash
   chmod 600 ~/.ssh/config
   ```

#### On Windows:

1. Open PowerShell or Command Prompt

2. Create the .ssh directory if it doesn't exist:
   ```bash
   mkdir %USERPROFILE%\.ssh
   ```

3. Create or edit the config file:
   ```bash
   notepad %USERPROFILE%\.ssh\config
   ```

4. Add your server configuration:
   ```
   Host legcompute
       HostName legcompute3.unine.ch
       User username
       IdentityFile C:\Users\YourUsername\.ssh\id_ed25519
       ForwardAgent yes
   ```

5. Save and close Notepad

**Config file explained**:
- `Host legcompute`: A short alias you'll use to connect (can be anything you want)
- `HostName`: The actual server address
- `User`: Your username on the server
- `IdentityFile`: Path to your private SSH key
- `ForwardAgent`: Allows you to use your local SSH keys on the remote server

You can add multiple hosts by repeating this block with different names.

### Step 4: Connect to Remote Server via VS Code

1. Click the **Remote Explorer** icon in the Activity Bar (looks like a monitor)
   - Or click the blue/green **"><"** button in the bottom-left corner
   
2. Select **"Connect to Host..."** from the dropdown

3. You should see your configured hosts (e.g., "legcompute")

4. Click on the host you want to connect to

5. A new VS Code window will open

6. Select the platform of the remote server (usually **Linux**)

7. Wait for VS Code to install the VS Code Server on the remote machine (first time only)

8. Once connected, you'll see the hostname in the bottom-left corner

**Alternative method**:

1. Press `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows) to open Command Palette
2. Type "Remote-SSH: Connect to Host..."
3. Select your host from the list
4. A new window opens connected to the remote server

### Step 5: Verify Connection

Once connected:

1. Open the integrated terminal (`Cmd+J` or `Ctrl+J`, then click "Terminal" tab)
2. Run a command to verify you're on the remote server:
   ```bash
   hostname
   pwd
   ```
3. You should see the server's hostname and your home directory path

**Note**: When connected remotely:
- The terminal runs on the remote server
- File operations happen on the remote server
- Extensions need to be installed on the remote server (VS Code will prompt you)

## Working with Files on Remote SSH Server

Once connected to a remote server, you can work with files just like they were local.

### Opening a Folder on the Remote Server

1. Make sure you're connected to the remote server (check bottom-left corner)

2. Click **File** → **Open Folder...** (or press `Cmd+O` / `Ctrl+O`)

3. Navigate to the folder you want to open on the remote server

4. Click **OK**

5. The folder will open in the Explorer panel

**Tip**: You can also use the Command Palette (`Cmd+Shift+P` / `Ctrl+Shift+P`) and type "File: Open Folder"

### Creating New Files

#### Method 1: Using the Explorer

1. In the Explorer panel (📁 icon), right-click on a folder
2. Select **"New File"**
3. Type the filename (including extension, e.g., `analysis.py`, `script.sh`, `results.md`)
4. Press Enter

#### Method 2: Using the Terminal

1. Open the integrated terminal (`Cmd+J` / `Ctrl+J`)
2. Navigate to your desired directory
3. Create a file:
   ```bash
   touch my_script.py
   # or
   nano new_file.txt
   ```
4. The file will appear in the Explorer

#### Method 3: Using Command Palette

1. Press `Cmd+Shift+P` / `Ctrl+Shift+P`
2. Type "File: New File"
3. Press Enter
4. Save with `Cmd+S` / `Ctrl+S` and provide a name

### Creating New Folders

1. In the Explorer panel, right-click where you want the new folder
2. Select **"New Folder"**
3. Type the folder name
4. Press Enter

### Opening Existing Files

#### Method 1: Explorer Panel

1. Navigate the file tree in the Explorer panel
2. Click on any file to open it in the editor

#### Method 2: Quick Open

1. Press `Cmd+P` / `Ctrl+P`
2. Start typing the filename
3. Select from the list that appears
4. Press Enter

This is the fastest way to open files in large projects!

#### Method 3: Terminal

1. In the integrated terminal, use:
   ```bash
   code filename.py
   ```
2. The file will open in the editor

### Saving Files

- **Save current file**: `Cmd+S` / `Ctrl+S`
- **Save all open files**: `Cmd+K S` / `Ctrl+K S`
- **Auto-save**: Enable in File → Auto Save

**Important**: When working on a remote server, files are saved directly on the remote machine, not your local computer.

### Working with Different File Types

VS Code handles many file types commonly used in bioinformatics:

#### Python Files (.py)

```python
# VS Code provides:
# - Syntax highlighting
# - Code completion
# - Linting (error checking)
# - Debugging
# - Run directly from editor

def analyze_sequence(sequence):
    """Count nucleotides in a DNA sequence."""
    return {
        'A': sequence.count('A'),
        'T': sequence.count('T'),
        'G': sequence.count('G'),
        'C': sequence.count('C')
    }
```

**Run Python file**: Right-click in editor → "Run Python File in Terminal"

#### R Scripts (.R)

```r
# VS Code provides:
# - Syntax highlighting
# - Code execution
# - Plot viewing

library(ggplot2)

data <- read.csv("results.csv")
ggplot(data, aes(x=sample, y=count)) + geom_bar(stat="identity")
```

**Run R code**: Install the R extension, then select code and press `Cmd+Enter` / `Ctrl+Enter`

#### Shell Scripts (.sh)

```bash
#!/bin/bash
# VS Code provides:
# - Syntax highlighting
# - ShellCheck integration (install extension)

echo "Starting analysis..."
for file in *.fastq; do
    echo "Processing $file"
    fastqc "$file"
done
```

**Make executable**: In terminal, run `chmod +x script.sh`

**Run script**: In terminal, run `./script.sh`

#### Markdown Files (.md)

```markdown
# My Analysis Results

## Methods
We analyzed samples using...

## Results
- Sample 1: 1,234 reads
- Sample 2: 2,345 reads
```

**Preview Markdown**: Press `Cmd+Shift+V` / `Ctrl+Shift+V` or click the preview icon (📖)

#### CSV/TSV Files (.csv, .tsv)

With Rainbow CSV extension installed:
- Columns are automatically colorized
- Easy to read and edit
- Can query data using SQL-like syntax

#### FASTA/FASTQ Files (.fasta, .fastq)

```
>sequence_1 bacterial_genome
ATGCGATCGATCGATCGATCG
GCTAGCTAGCTAGCTAGCTAG
```

VS Code treats these as text files with syntax highlighting available through extensions.

### Copying Files Between Local and Remote

#### Upload to Remote Server:

1. Open the Explorer panel
2. Simply drag and drop files from your local file manager into the VS Code Explorer
3. The files will be uploaded to the remote server

#### Download from Remote Server:

1. In the Explorer panel, right-click on the file
2. Select **"Download..."**
3. Choose where to save it locally

**Alternative**: Use the integrated terminal with `scp`:

```bash
# On your local machine, to upload:
scp local_file.txt username@legcompute3.unine.ch:~/remote/path/

# To download:
scp username@legcompute3.unine.ch:~/remote/path/file.txt ~/local/path/
```

## Using GitHub Copilot

GitHub Copilot is an AI-powered coding assistant that can dramatically speed up your coding.

### Checking Copilot Access

1. Click the **Accounts** icon in the Activity Bar
2. Sign in with your GitHub account (if not already signed in)
3. If you have access (through student pack, subscription, or institution):
   - Install the "GitHub Copilot" extension
   - Install the "GitHub Copilot Chat" extension

### Activating GitHub Copilot

1. After installing the extensions, click the Copilot icon in the Status Bar (bottom right)
2. Click **"Sign in to GitHub"**
3. Authorize the extension in your browser
4. Return to VS Code

You should now see the Copilot icon active in the Status Bar.

### Using Copilot for Code Completion

As you type, Copilot automatically suggests completions in gray text:

```python
# Type a comment describing what you want:
# Function to calculate GC content of a DNA sequence

# Copilot will suggest:
def calculate_gc_content(sequence):
    gc_count = sequence.count('G') + sequence.count('C')
    return gc_count / len(sequence) * 100
```

**Controls**:
- **Accept suggestion**: Press `Tab`
- **Reject suggestion**: Keep typing or press `Esc`
- **See alternative suggestions**: Press `Alt+]` (next) or `Alt+[` (previous)
- **Trigger Copilot manually**: Press `Alt+\` or `Option+\`

### Using Copilot Chat as an Agent

Copilot Chat provides a conversational interface for coding help.

#### Opening Copilot Chat

1. Click the **Chat** icon in the Activity Bar (speech bubble icon)
   - Or press `Cmd+Shift+I` / `Ctrl+Shift+I`

2. A chat panel opens on the side

#### Chat Features

**Ask general questions**:
```
How do I read a FASTA file in Python?
```

**Get code explanations**:
```
/explain
```
Then select code in your editor - Copilot will explain it.

**Fix errors**:
```
/fix
```
Select problematic code - Copilot will suggest fixes.

**Generate tests**:
```
/tests
```
Select a function - Copilot will generate unit tests.

**Optimize code**:
```
Can you optimize this function for better performance?
```

**Using Agent Mode**:

Agent mode allows Copilot to perform multi-step tasks:

1. Type `@workspace` in the chat to give Copilot access to your entire workspace

2. Ask complex questions:
   ```
   @workspace Where is the function that processes FASTQ files?
   ```

3. Request multi-file edits:
   ```
   @workspace Update all Python files to use the new config format
   ```

4. Get architectural advice:
   ```
   @workspace How should I structure this analysis pipeline?
   ```

#### Best Practices for Using Copilot

1. **Write clear comments**: Copilot works best with descriptive comments
   ```python
   # Parse a FASTA file and return a dictionary of sequence IDs to sequences
   ```

2. **Provide context**: Include relevant variable names and types
   ```python
   sequences = {}  # Dictionary to store sequences
   ```

3. **Review suggestions**: Always review and test Copilot's suggestions - it can make mistakes

4. **Iterate**: If the first suggestion isn't right, modify your comment or try again

5. **Use for boilerplate**: Copilot excels at generating common patterns
   ```python
   # Create argparse argument parser for a bioinformatics script
   ```

### Working Without Copilot

If you don't have Copilot access, VS Code still provides excellent coding support:

- **IntelliSense**: Built-in code completion for many languages
- **Snippets**: Pre-written code templates (type a shortcut and press Tab)
- **Extensions**: Language-specific extensions provide additional help
- **Documentation**: Hover over functions to see their documentation

## Keyboard Shortcuts

Learning keyboard shortcuts will make you much more efficient.

### Essential Shortcuts

#### General
- `Cmd+Shift+P` / `Ctrl+Shift+P`: Command Palette (most important!)
- `Cmd+P` / `Ctrl+P`: Quick Open (find files)
- `Cmd+S` / `Ctrl+S`: Save file
- `Cmd+W` / `Ctrl+W`: Close current editor
- `Cmd+K Cmd+W` / `Ctrl+K Ctrl+W`: Close all editors

#### Editing
- `Cmd+X` / `Ctrl+X`: Cut line (even without selection)
- `Cmd+C` / `Ctrl+C`: Copy line
- `Alt+Up/Down`: Move line up/down
- `Shift+Alt+Up/Down`: Copy line up/down
- `Cmd+/` / `Ctrl+/`: Toggle line comment
- `Cmd+D` / `Ctrl+D`: Select next occurrence of current word
- `Cmd+Shift+L` / `Ctrl+Shift+L`: Select all occurrences

#### Navigation
- `Cmd+G` / `Ctrl+G`: Go to line
- `Cmd+F` / `Ctrl+F`: Find in current file
- `Cmd+Shift+F` / `Ctrl+Shift+F`: Find in all files
- `Cmd+B` / `Ctrl+B`: Toggle sidebar
- `Cmd+J` / `Ctrl+J`: Toggle panel (terminal)

#### Terminal
- `Ctrl+` ` ` (backtick): Toggle terminal
- `Cmd+Shift+` ` ` / `Ctrl+Shift+` ` `: Create new terminal
- `Cmd+\` / `Ctrl+\`: Split terminal

#### Copilot (if installed)
- `Alt+\` / `Option+\`: Trigger Copilot
- `Tab`: Accept suggestion
- `Alt+]` / `Option+]`: Next suggestion
- `Alt+[` / `Option+[`: Previous suggestion

### Customizing Shortcuts

1. Press `Cmd+K Cmd+S` / `Ctrl+K Ctrl+S` to open Keyboard Shortcuts
2. Search for the command you want to customize
3. Click the pencil icon and press your desired key combination

## Customizing VS Code

### Settings

Access settings: `Cmd+,` / `Ctrl+,`

**Useful settings to customize**:

- **Auto Save**: Search "auto save" → Set to "afterDelay"
- **Font Size**: Search "font size" → Adjust to your preference (default is 12)
- **Tab Size**: Search "tab size" → Set to 2 or 4
- **Word Wrap**: Search "word wrap" → Set to "on" for easier reading of long lines
- **Files: Exclude**: Hide certain file types from Explorer (e.g., `*.pyc`, `__pycache__`)

### Color Themes

1. Press `Cmd+K Cmd+T` / `Ctrl+K Ctrl+T`
2. Browse available themes
3. Select one to preview
4. Press Enter to apply

Popular themes:
- **Dark+ (default dark)**
- **Light+ (default light)**
- **Monokai**
- **Solarized Dark**

Install more themes from the Extensions marketplace.

### File Icons

1. Open Command Palette (`Cmd+Shift+P` / `Ctrl+Shift+P`)
2. Type "File Icon Theme"
3. Select "Preferences: File Icon Theme"
4. Choose an icon theme (e.g., "Seti", "Material Icon Theme")

## Best Practices for Remote Work

### 1. Keep Files Organized

```
your-project/
├── data/
│   ├── raw/
│   └── processed/
├── scripts/
│   ├── preprocessing.py
│   └── analysis.R
├── results/
│   ├── figures/
│   └── tables/
└── README.md
```

### 2. Use Version Control

- Initialize Git in your project directory
- Commit changes regularly
- Push to GitHub for backup and collaboration

### 3. Save Frequently

- Enable Auto Save for peace of mind
- Use `Cmd+K S` / `Ctrl+K S` to save all files at once

### 4. Close Unused Files

- Too many open tabs can be confusing
- Use `Cmd+W` / `Ctrl+W` to close files you're done with

### 5. Use the Integrated Terminal

- No need to switch between applications
- Can open multiple terminals for different tasks
- Terminal automatically connected to your remote server

### 6. Take Advantage of Extensions

- Install extensions on the remote server for full functionality
- Some extensions work locally, others need to be on the remote

### 7. Learn the Search Feature

- `Cmd+Shift+F` / `Ctrl+Shift+F` to search across all files
- Use regex for advanced searching
- Replace across multiple files

## Troubleshooting Common Issues

### Cannot Connect to Remote Server

**Check**:
- Is your internet connection working?
- Can you SSH from the terminal? Test: `ssh username@legcompute3.unine.ch`
- Is your SSH config file correct?
- Are your SSH keys properly set up?
- Is the server running and accessible?

**Solutions**:
- Regenerate SSH keys and copy to server
- Check SSH config file for typos
- Contact server administrator

### Extensions Not Working Remotely

**Issue**: Extensions installed locally don't work on remote server

**Solution**:
- Extensions need to be installed on the remote server too
- VS Code will show an "Install in SSH: hostname" button
- Click it to install the extension remotely

### Slow Performance

**Causes**:
- Large workspace with many files
- Slow internet connection
- Resource-intensive extensions

**Solutions**:
- Open only the folder you need, not the entire home directory
- Disable unused extensions
- Use `.vscodeignore` to exclude large directories
- Close unused editors and terminals

### File Encoding Issues

**Issue**: Strange characters in files

**Solution**:
- Check file encoding in Status Bar (bottom right)
- Click it to change encoding (usually UTF-8)
- Reload file with correct encoding

### Terminal Not Responding

**Solution**:
- Click in the terminal area
- Try `Ctrl+C` to cancel current operation
- Close terminal and open a new one (`Cmd+Shift+` ` ` / `Ctrl+Shift+` ` `)

## Additional Resources

### Official Documentation

- **VS Code Docs**: [https://code.visualstudio.com/docs](https://code.visualstudio.com/docs)
- **Remote SSH Guide**: [https://code.visualstudio.com/docs/remote/ssh](https://code.visualstudio.com/docs/remote/ssh)
- **GitHub Copilot Docs**: [https://docs.github.com/en/copilot](https://docs.github.com/en/copilot)

### Keyboard Shortcut Cheatsheets

- **macOS**: [https://code.visualstudio.com/shortcuts/keyboard-shortcuts-macos.pdf](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-macos.pdf)
- **Windows**: [https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf)
- **Linux**: [https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf)

### Video Tutorials

- **Official VS Code YouTube Channel**: [https://www.youtube.com/code](https://www.youtube.com/code)
- Search for "VS Code Remote SSH tutorial" for specific guides

## Practice Exercise

To get comfortable with VS Code, try this exercise:

1. **Open VS Code and sign in to GitHub**

2. **Install the Remote - SSH extension**

3. **Set up your SSH config file** with LEGcompute or another server

4. **Connect to the remote server**

5. **Create a new project directory**:
   ```bash
   mkdir ~/bioinfo_practice
   ```

6. **Open the folder in VS Code** (File → Open Folder)

7. **Create a new Python script** (`practice.py`):
   ```python
   # Calculate GC content of a DNA sequence
   def gc_content(sequence):
       gc = sequence.count('G') + sequence.count('C')
       return (gc / len(sequence)) * 100
   
   # Test sequence
   dna = "ATGCGATCGATCG"
   print(f"GC content: {gc_content(dna):.2f}%")
   ```

8. **Run the script** in the integrated terminal:
   ```bash
   python practice.py
   ```

9. **Create a Markdown file** (`notes.md`) with your observations

10. **Preview the Markdown file** (`Cmd+Shift+V` / `Ctrl+Shift+V`)

11. **If you have Copilot**, try asking it to:
    - Add error handling to the function
    - Create a function to read a FASTA file
    - Generate docstrings for the functions

Congratulations! You now know the basics of VS Code for bioinformatics work.

## Summary

You've learned:
- ✅ How to navigate the VS Code interface
- ✅ How to sign in to GitHub
- ✅ How to install essential extensions
- ✅ How to set up remote SSH connections (Windows & macOS)
- ✅ How to create, edit, and save files on remote servers
- ✅ How to use GitHub Copilot and Copilot Chat
- ✅ Essential keyboard shortcuts
- ✅ Best practices for remote development

**Next steps**:
- Practice using VS Code regularly
- Explore additional extensions for your specific needs
- Learn more keyboard shortcuts to increase efficiency
- Experiment with Copilot (if available) to speed up your coding

Happy coding!
