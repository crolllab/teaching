# Introduction to Git and GitHub

## Learning Objectives

- Understand version control basics and why it matters for research
- Create your GitHub account and first repository
- Use Git within VS Code for your daily workflow
- Master the essential operations: clone, commit, push, pull
- Organize and maintain your course repository

## Prerequisites

This tutorial assumes you have:
- ✅ VS Code installed and configured
- ✅ Remote SSH connection to a server (see VS Code tutorial)
- ✅ Basic familiarity with the VS Code interface

## What is Git and GitHub?

**Version control** tracks changes to files over time, like a powerful "undo" with complete history. Instead of:
```
analysis_v1.py
analysis_v2_final.py
analysis_v2_final_REALLY_FINAL.py
```

You maintain one file (`analysis.py`) with full change history.

**Git** is the version control software (created by Linus Torvalds in 2005). It's:
- Distributed: every copy contains full history
- Fast and efficient
- The standard for research and software development

**GitHub** is a web hosting service for Git repositories. It provides:
- Cloud storage for your Git repositories
- Web interface to view code and history
- Collaboration tools (issues, pull requests)
- Free hosting for public projects

**Key Concepts:**
- **Repository (repo)**: A project folder tracked by Git
- **Commit**: A snapshot of your project with a description
- **Remote**: Your repository hosted on GitHub
- **Clone**: Download a repository from GitHub
- **Push**: Upload your commits to GitHub  
- **Pull**: Download updates from GitHub

## Your Workflow for This Course

This is the simplified workflow you'll use throughout the course:

```
GitHub.com (create repo) → Clone to server → Edit files → Commit → Push
                              ↓                  ↑                    ↓
                           Pull updates ←←←←←←←←←←←←←←←←←←←←←←← View on GitHub
```

We'll focus on using VS Code's graphical interface. Terminal commands are in the supplementary section.

## Step 1: Create Your GitHub Account

1. Go to [github.com](https://github.com) and click **Sign up**

2. Enter your information:
   - **Email**: Use your university email
   - **Username**: Choose something professional (e.g., `jsmith-bio`, `johndoe`)
   - **Password**: Choose a strong password

3. Verify your account via email

4. Choose the **free plan**

**Optional - Student Benefits**: Visit [education.github.com/pack](https://education.github.com/pack) to get GitHub Student Developer Pack (free Copilot, private repos, cloud credits).

## Step 2: Configure Git Identity

Connect to your remote server via VS Code, then open the terminal (`Cmd+J` or `Ctrl+J`):

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@unine.ch"
```

**Important**: Use the same email as your GitHub account!

Verify your configuration:
```bash
git config --list
```

## Step 3: Understanding VS Code's Git Interface

**Source Control Panel**: Click the branch icon in the Activity Bar (left side)
- Shows your changed files
- Allows you to commit and sync
- Displays file status: **M** (modified), **U** (untracked/new), **D** (deleted)

**Status Bar** (bottom): Shows current branch name and sync status

**Keyboard shortcut**: `Cmd+Shift+G` / `Ctrl+Shift+G` opens Source Control

## Step 4: Create Your Course Repository on GitHub

1. Log in to [github.com](https://github.com)

2. Click the **+** icon (top right) → **New repository**

3. Configure your repository:
   - **Name**: `bioinfo_applications_2026`
   - **Description**: "Personal workspace for Bioinformatics Applications course"
   - **Visibility**: **Public** ✅ (free, good for portfolio)
   - **Initialize**: ✅ Add README file, ✅ Add .gitignore (Python template)

4. Click **Create repository**

Your repository is live at: `https://github.com/YOUR_USERNAME/bioinfo_applications_2026`

## Step 5: Set Up Authentication

You need to authenticate for push/pull operations.

**Using Personal Access Token** (Recommended):

1. GitHub.com → Profile picture → **Settings**
2. **Developer settings** → **Personal access tokens** → **Tokens (classic)**
3. **Generate new token (classic)**
4. Configure:
   - **Note**: "VS Code on Server"
   - **Expiration**: 90 days or longer
   - **Scopes**: Check ✅ `repo`
5. **Generate token** and **COPY IT IMMEDIATELY** (you won't see it again!)
   ```
   ghp_xxxxxxxxxxxxxxxxxxxx
   ```
6. Save it securely (password manager)

**Important**: Keep this token handy - you'll need it in the next step for cloning!

## Step 6: Clone Repository to Your Server (VS Code GUI)

1. In VS Code (connected to remote), press `Cmd+Shift+P` / `Ctrl+Shift+P`

2. Type **"Git: Clone"** and press Enter

3. Paste your repository URL **with your token embedded**:
   ```
   https://YOUR_USERNAME:YOUR_TOKEN@github.com/YOUR_USERNAME/bioinfo_applications_2026.git
   ```
   
   **Example**: If your username is `jsmith` and token is `ghp_abc123xyz`, use:
   ```
   https://jsmith:ghp_abc123xyz@github.com/jsmith/bioinfo_applications_2026.git
   ```
   
   Replace:
   - `YOUR_USERNAME` with your GitHub username
   - `YOUR_TOKEN` with your Personal Access Token from Step 5

4. Choose where to save it (e.g., your home directory)

5. When cloning completes, click **Open**

6. You're now in your repository folder! Check the Source Control panel - you should see the branch name (`main`).

**Important**: By including your token in the URL, Git will remember your credentials and you won't be prompted when pushing changes later.

## Step 7: Set Up Your Repository Structure

**Create folder structure**: In VS Code Explorer, right-click and create these folders:
```
notes/        # Course notes
scripts/      # Your Python/R scripts  
data/         # Data files (will be ignored by Git)
assignments/  # Course assignments
tutorials/    # Tutorial exercises
```

**Update README.md**: Open it and replace content with:
```markdown
# Bioinformatics Applications 2026

Personal workspace for the Bioinformatics Applications course.

## About
**Name**: Your Name  
**Program**: Your program  
**Year**: 2026

## Structure
- `notes/` - Course notes
- `scripts/` - Analysis scripts
- `data/` - Data files (in .gitignore)
- `assignments/` - Assignments
- `tutorials/` - Tutorial exercises
```

**Update .gitignore**: Open it and add these bioinformatics-specific patterns:
```
# Data files (too large for Git)
data/
*.fastq
*.fastq.gz
*.bam
*.vcf.gz

# R files
.Rhistory
.RData

# Jupyter
.ipynb_checkpoints/

# Results (can be regenerated)
results/
output/
```

Save all files (`Cmd+S` / `Ctrl+S`).

## Step 8: Make Your First Commit (VS Code GUI)

**Review changes**:
1. Click the **Source Control** icon (branch symbol) in Activity Bar
2. You'll see modified files: `README.md`, `.gitignore` (with **M** indicator)
3. Click on any file to see what changed (diff view)
   - Green = added lines
   - Red = deleted lines

**Commit changes**:
1. In the Source Control panel, find the message box at the top
2. Type a clear commit message:
   ```
   Initialize repository structure and update README
   ```
   
   **Good commit messages**: Short, descriptive, present tense
   - ✅ "Add week 1 notes"
   - ✅ "Fix sequence parser bug"
   - ❌ "updates", "fixed stuff", "asdf"

3. Click the **✓ Commit** button (or press `Cmd+Enter` / `Ctrl+Enter`)
4. If asked to stage changes, click **Yes** or **Always**

Your changes are now committed locally!

## Step 9: Push to GitHub (VS Code GUI)

**Push your commit**:
1. Look at the **Status Bar** (bottom of VS Code)
2. Click the **↑ Sync Changes** button (cloud with arrow)
   - Or click **•••** menu in Source Control → **Push**
3. Wait for completion

**Verify on GitHub**:
1. Go to `https://github.com/YOUR_USERNAME/bioinfo_applications_2026`
2. You should see:
   - Updated README
   - Updated .gitignore
   - Your folder structure
   - Your commit message

🎉 Congratulations! Your changes are now on GitHub!

## The Complete Workflow: Edit-Commit-Push

Now you understand the cycle. Let's practice!

### Create Your First Course Notes

1. **Create file**: `notes/week1_introduction.md`
2. **Add content**:
   ```markdown
   # Week 1: Introduction
   
   ## Topics
   - Version control with Git
   - Command line basics
   
   ## Commands Learned
   - git clone
   - git status  
   - git add
   - git commit
   - git push
   ```
3. **Save** the file

### Create Your First Script

1. **Create file**: `scripts/hello_bioinfo.py`
2. **Add code**:
   ```python
   #!/usr/bin/env python3
   """First bioinformatics script"""
   
   def main():
       dna = "ATGCGATCGTAGCTA"
       gc = (dna.count('G') + dna.count('C')) / len(dna) * 100
       print(f"Sequence: {dna}")
       print(f"Length: {len(dna)} bp")
       print(f"GC content: {gc:.1f}%")
   
   if __name__ == "__main__":
       main()
   ```
3. **Save** and **test**: Open terminal and run `python scripts/hello_bioinfo.py`

### Commit and Push

1. **Source Control panel**: See your 2 new files
2. **Write message**: "Add week 1 notes and first Python script"
3. **Commit**: Click ✓
4. **Push**: Click sync icon
5. **Verify**: Refresh your GitHub repository page

### Best Practice Workflow

For every work session:
```
1. Open VS Code (connected to remote)
2. (Optional) Pull latest changes
3. Make changes → Save → Test
4. Review changes in Source Control
5. Write clear commit message
6. Commit
7. Push when done (or after each commit)
```

**Tips**:
- Commit after completing a logical unit of work
- Test your code before committing
- Push at least once per session  
- Write messages for future you

## Pulling Changes (VS Code GUI)

**When to pull**:
- Working from multiple computers
- Collaborating with others
- Made edits directly on GitHub.com
- Before starting a new work session (good practice)

**How to pull** (VS Code GUI):
1. Click the **↓** (download) icon in Status Bar
   - Or Source Control → **•••** menu → **Pull**
2. VS Code downloads and merges changes
3. Your local files are now updated

**If you have uncommitted changes**, commit them first or stash them:
- **Commit first** (recommended): Commit your work, then pull
- **Stash** (temporary): Source Control → **•••** → **Stash** → **Stash (Include Untracked)**, then pull, then **Apply Latest Stash**

## Handling Merge Conflicts in VS Code

**When conflicts occur**: If you and someone else edited the same lines, Git can't auto-merge.

**How to resolve**:
1. VS Code highlights conflicting files
2. Open the file - you'll see conflict markers:
   ```python
   <<<<<<< HEAD (Current)

   result = analyze_sequences(data, method='new')
   =======
   result = analyze_sequences(data, method='old')
   >>>>>>> main (Incoming)
   ```
3. VS Code shows options:
   - **Accept Current Change**: Keep your version
   - **Accept Incoming Change**: Keep the remote version
   - **Accept Both Changes**: Keep both
   - **Compare Changes**: See detailed diff
4. Click your choice or manually edit
5. Save the file
6. Commit the resolution (VS Code will prompt you)

## Quick Reference: Best Practices

**Do's** ✅:
- Commit frequently with clear messages
- Pull before starting work
- Push regularly (at least once per session)
- Test code before committing
- Keep `main` branch stable

**Don'ts** ❌:
- Don't commit sensitive data (passwords, API keys)
- Don't commit large data files (> 50MB)
- Don't commit generated files (`__pycache__/`, `.RData`)
- Don't use vague commit messages

## Resources

- **Git Book**: [git-scm.com/book](https://git-scm.com/book/en/v2)
- **GitHub Docs**: [docs.github.com](https://docs.github.com/)
- **VS Code Git Guide**: [code.visualstudio.com/docs/sourcecontrol](https://code.visualstudio.com/docs/sourcecontrol/overview)
- **Learn Git Branching**: [learngitbranching.js.org](https://learngitbranching.js.org/)

---

# SUPPLEMENTARY: Terminal/Command-Line Operations

This section contains Git terminal commands for users who prefer command-line workflows or need manual operations beyond VS Code's GUI.

## Initial Git Configuration (Terminal)

```bash
# Set your identity
git config --global user.name "Your Name"
git config --global user.email "your.email@unine.ch"

# Set default editor to VS Code
git config --global core.editor "code --wait"

# Set default branch name
git config --global init.defaultBranch main

# View configuration
git config --list
```

## Cloning Repository (Terminal)

```bash
# Navigate to desired location
cd ~

# Clone using HTTPS
git clone https://github.com/YOUR_USERNAME/bioinfo_applications_2026.git

# Or clone using SSH
git clone git@github.com:YOUR_USERNAME/bioinfo_applications_2026.git

# Enter the repository
cd bioinfo_applications_2026
```

## Working with Files (Terminal)

```bash
# Check repository status
git status

# View what changed
git diff

# View commit history
git log
git log --oneline  # Compact view
git log --graph --oneline --all  # Visual graph

# Stage files for commit
git add filename.py           # Stage specific file
git add .                     # Stage all changes
git add *.py                  # Stage all Python files

# Unstage files
git restore --staged filename.py

# Discard changes in working directory
git restore filename.py       # Discard changes to file
```

## Committing Changes (Terminal)

```bash
# Commit staged changes
git commit -m "Descriptive message"

# Stage and commit in one step (modified files only)
git commit -am "Update analysis"

# Amend last commit
git commit --amend

# Amend with new message
git commit --amend -m "New message"
```

## Pushing and Pulling (Terminal)

```bash
# Push to remote
git push

# Push and set upstream (first time)
git push -u origin main

# Pull from remote
git pull

# Pull with rebase
git pull --rebase

# Fetch without merging
git fetch

# View remotes
git remote -v

# Change remote URL
git remote set-url origin https://github.com/USER/REPO.git
```

## Working with Branches (Terminal)

```bash
# List branches
git branch                    # Local branches
git branch -a                 # All branches (including remote)

# Create new branch
git branch feature-name

# Switch to branch
git checkout feature-name

# Create and switch in one command
git checkout -b feature-name

# Newer syntax (Git 2.23+)
git switch feature-name
git switch -c feature-name    # Create and switch

# Merge branch into current branch
git merge feature-name

# Delete branch
git branch -d feature-name    # Safe delete (only if merged)
git branch -D feature-name    # Force delete

# Delete remote branch
git push origin --delete feature-name
```

## Stashing Changes (Terminal)

```bash
# Save changes temporarily
git stash

# Stash with message
git stash save "Work in progress on feature"

# Include untracked files
git stash -u

# List stashes
git stash list

# Apply most recent stash
git stash pop

# Apply specific stash
git stash apply stash@{0}

# View stash contents
git stash show -p stash@{0}

# Delete stash
git stash drop stash@{0}

# Clear all stashes
git stash clear
```

## Undoing Changes (Terminal)

```bash
# Undo last commit, keep changes
git reset --soft HEAD~1

# Undo last commit, discard changes
git reset --hard HEAD~1

# Undo last 3 commits
git reset --soft HEAD~3

# Reset to match remote
git fetch origin
git reset --hard origin/main

# Revert a commit (creates new commit)
git revert <commit-hash>

# Discard all local changes
git restore .
```

## Advanced Operations (Terminal)

```bash
# View file history
git log --follow -- path/to/file.py

# Show who changed each line
git blame filename.py

# Find when a bug was introduced
git bisect start
git bisect bad                # Current version is bad
git bisect good <commit>      # Known good commit
# Git checks out middle commit, test and mark:
git bisect good   # or git bisect bad
# Repeat until found

# Cherry-pick a commit
git cherry-pick <commit-hash>

# Interactive rebase (rewrite history) - USE CAREFULLY
git rebase -i HEAD~3

# View reflog (all actions)
git reflog

# Recover deleted branch/commit
git checkout <commit-hash-from-reflog>
git checkout -b recovered-branch
```

## SSH Key Setup (Terminal)

```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your.email@unine.ch"

# Or for older systems
ssh-keygen -t rsa -b 4096 -C "your.email@unine.ch"

# Start SSH agent
eval "$(ssh-agent -s)"

# Add key to agent
ssh-add ~/.ssh/id_ed25519

# Copy public key (macOS)
pbcopy < ~/.ssh/id_ed25519.pub

# Copy public key (Linux)
cat ~/.ssh/id_ed25519.pub
# Then manually copy the output

# Test SSH connection to GitHub
ssh -T git@github.com
```

## Repository Management (Terminal)

```bash
# Initialize new repository
git init

# Add remote
git remote add origin https://github.com/USER/REPO.git

# Change remote URL
git remote set-url origin git@github.com:USER/REPO.git

# Remove remote
git remote remove origin

# Clone only specific branch
git clone -b branch-name --single-branch https://github.com/USER/REPO.git

# Clone with limited history
git clone --depth 1 https://github.com/USER/REPO.git
```

## Collaborative Workflows (Terminal)

```bash
# Fork workflow
git clone https://github.com/YOUR_USERNAME/REPO.git
git remote add upstream https://github.com/ORIGINAL_OWNER/REPO.git
git fetch upstream
git merge upstream/main
git push origin main

# Update from upstream
git pull upstream main

# Create pull request branch
git checkout -b feature-branch
# Make changes
git push -u origin feature-branch
# Then create PR on GitHub

# Fetch pull request locally
git fetch origin pull/123/head:pr-123
git checkout pr-123
```

## Troubleshooting (Terminal)

```bash
# Fix line endings
git config --global core.autocrlf input   # Mac/Linux
git config --global core.autocrlf true    # Windows

# Clean untracked files (BE CAREFUL)
git clean -n    # Preview what will be deleted
git clean -f    # Delete untracked files
git clean -fd   # Delete untracked files and directories

# Resolve merge conflict
git status      # See conflicting files
# Edit files to resolve
git add resolved_file.py
git commit

# Abort merge
git merge --abort

# Save credentials (HTTPS)
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

# Or store permanently (less secure)
git config --global credential.helper store
```

## Useful Aliases (Terminal)

Add these to your `~/.gitconfig` or set with `git config --global`:

```bash
# Set aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'restore --staged'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual 'log --graph --oneline --all'

# Then use them:
git co main
git br
git st
git visual
```

## Daily Workflow Reference (Terminal)

```bash
# Morning: Start work
cd ~/bioinfo_applications_2026
git pull

# During work: Check status
git status
git diff

# After changes: Commit
git add .
git commit -m "Add sequence analysis script"

# End of day: Push
git push

# Multiple changes
git add script1.py
git commit -m "Add script1"
git add script2.py
git commit -m "Add script2"
git push
```

## .gitignore Patterns

Create `.gitignore` in repository root:

```bash
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
*.egg-info/
dist/
build/

# R
.Rhistory
.RData
.Rproj.user/
*.Rproj

# Jupyter
.ipynb_checkpoints/
*.ipynb_checkpoints

# Data files
data/
*.fastq
*.fastq.gz
*.fasta.gz
*.fa.gz
*.bam
*.sam
*.vcf.gz
*.bcf
*.bed
*.gff
*.gtf

# Results
results/
output/
figures/
plots/

# Temporary
*.tmp
*.log
*.swp
*~

# OS
.DS_Store
Thumbs.db

# IDE
.vscode/settings.json
.idea/
```

---

## Summary: VS Code GUI vs Terminal

**Use VS Code GUI** for:
- ✅ Daily commit/push/pull workflow  
- ✅ Viewing diffs and history
- ✅ Resolving merge conflicts
- ✅ Switching branches
- ✅ Beginners getting started

**Use Terminal** when:
- Advanced operations (rebase, cherry-pick)
- Batch operations or scripting
- Remote servers without GUI
- Complex history manipulation
- Personal preference

**Best practice**: Master the VS Code GUI first, then learn terminal commands as needed!

---

Happy versioning! 🎉

