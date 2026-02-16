# Introduction to Git and GitHub

## Major Aims

- Understand what Git and GitHub are and why they're important for scientific computing
- Create your own GitHub account and personal repository
- Learn the basic Git workflow for version control
- Use Git within VS Code for seamless integration
- Initialize, edit, commit, and push changes to your personal repository
- Share and collaborate effectively using GitHub
- Troubleshoot common Git issues

## What is Version Control?

Version control is a system that tracks changes to files over time. Think of it as a powerful "undo" button combined with a complete history of your project. Instead of having files like:

```
analysis_v1.py
analysis_v2.py
analysis_v2_final.py
analysis_v2_final_REALLY_FINAL.py
```

Version control lets you keep one file (`analysis.py`) while maintaining a complete history of every change, who made it, and why.

## History of Git

### The Origins

**Git** was created in 2005 by Linus Torvalds, the creator of Linux. The Linux kernel development team needed a fast, distributed version control system after their previous system became unavailable.

**Key facts**:
- Git is a **distributed version control system** (DVCS)
- Every developer has a complete copy of the project history
- Extremely fast and efficient
- Designed to handle large projects with many contributors
- Free and open-source


### Why Git is so popular

Before Git, there were other version control systems:
- **CVS** (Concurrent Versions System) - centralized, older
- **SVN** (Subversion) - centralized, improved CVS
- **Mercurial** - distributed, similar to Git
- **Perforce** - commercial, centralized

Git became dominant because:
1. **Speed**: Operations are incredibly fast
2. **Distributed nature**: Every copy is a full backup
3. **Branching**: Creating and merging branches is easy and fast
4. **Integrity**: Everything is checksummed (cryptographically secure)
5. **Community adoption**: GitHub's popularity cemented Git's position

### Other Version Control Systems Today

While Git is now the standard, other systems still exist:

- **Mercurial**: Similar to Git but simpler; used by some large projects
- **SVN (Subversion)**: Still used in some organizations
- **Perforce**: Popular in game development
- **Fossil**: Includes bug tracking and wiki

**For bioinformatics and academic research, Git is the de facto standard.**

## What is GitHub?

### GitHub.com Explained

**GitHub** is not Git itself - it's a web-based hosting service for Git repositories founded in 2008.

**Think of it this way**:
- **Git** = the version control software on your computer
- **GitHub** = a website where you can store and share Git repositories

**GitHub provides**:
- Cloud storage for your Git repositories
- Web interface to view code and history
- Collaboration tools (issues, pull requests, project boards)
- Social features (follow developers, star projects)
- Free hosting for open-source projects
- GitHub Pages for hosting websites
- GitHub Actions for automation (CI/CD)

### Alternatives to GitHub

Other Git hosting services include:

- **GitLab**: Similar to GitHub, with strong CI/CD features
- **Bitbucket**: Atlassian's service, integrates with Jira
- **Gitea**: Self-hosted, lightweight alternative
- **SourceForge**: Older platform, still exists

**Why GitHub for this course?**
- Most popular (over 100 million developers)
- Best integration with other tools
- Free for public repositories
- GitHub Education benefits for students
- Industry standard

## Understanding Git: The Big Picture

### Core Concepts

#### 1. Repository (Repo)

A repository is a project folder that Git tracks. It contains:
- Your files and folders
- A hidden `.git` folder with all the version history
- Metadata about changes

#### 2. Commit

A commit is a snapshot of your project at a specific point in time. Each commit:
- Has a unique ID (hash)
- Records what changed
- Includes a message describing the change
- Knows who made the change and when

Think of commits as save points in a video game - you can always return to any save point.

#### 3. Branch

A branch is an independent line of development. The main branch is usually called `main` (formerly `master`).

**Why use branches?**
- Work on new features without affecting the stable code
- Experiment safely
- Collaborate without conflicts
- Review changes before merging

```
main:     A---B---C---F---G
               \         /
feature:        D---E---
```

#### 4. Remote

A remote is a version of your repository hosted somewhere else (like GitHub). Common remotes:
- `origin`: The default remote (usually your GitHub repo)
- `upstream`: The original repo if you forked someone else's project

#### 5. Clone

Cloning creates a complete local copy of a remote repository:
```
GitHub.com     →     Your Server     →     Your Laptop
   (remote)          (local copy)          (another copy)
```

#### 6. Pull

Pulling downloads changes from a remote repository and merges them with your local code.

#### 7. Push

Pushing uploads your local commits to a remote repository.

## Git for Collaborative Coding: The Full Picture

### Collaborative Workflow Overview

In a typical collaborative project:

1. **Central Repository (GitHub)**: The "source of truth"
2. **Multiple Contributors**: Each has their own local copy
3. **Branches**: Features developed in isolation
4. **Pull Requests**: Proposed changes reviewed before merging
5. **Code Review**: Team members review and discuss changes
6. **Continuous Integration**: Automated tests run on every change
7. **Release Management**: Tagged versions for stable releases

### Advanced Collaborative Features

#### Pull Requests (PRs)

A pull request is a proposal to merge changes:
1. Developer creates a feature branch
2. Makes changes and commits
3. Pushes branch to GitHub
4. Opens a pull request
5. Team reviews the code
6. Changes are discussed and refined
7. PR is merged into main branch

**Benefits**:
- Code review catches bugs
- Knowledge sharing
- Discussion of implementation
- Historical record of decisions

#### Issues and Project Management

GitHub Issues track:
- Bugs to fix
- Features to implement
- Questions and discussions
- Tasks and milestones

#### Forks and Contributions

**Forking** creates your own copy of someone else's repository:
1. Fork the original repo to your GitHub account
2. Clone your fork locally
3. Make changes
4. Push to your fork
5. Create a pull request to the original repo

This is how open-source contributions work!

#### Branch Strategies

**Common strategies**:

**1. GitHub Flow (simple)**:
```
main branch (always deployable)
 ↓
feature branches → PR → merge → delete branch
```

**2. Git Flow (complex)**:
```
main (production)
develop (integration)
feature branches
release branches
hotfix branches
```

For this course, we'll use a simplified GitHub Flow.

#### Merge Conflicts

When two people edit the same lines, Git can't automatically merge:

```python
<<<<<<< HEAD
result = analyze_sequences(data, method='new')
=======
result = analyze_sequences(data, method='old')
>>>>>>> feature-branch
```

**Resolution**:
1. Decide which version to keep (or combine both)
2. Remove the conflict markers
3. Commit the resolution

### Advanced Git Commands

For collaborative work, you might encounter:

- `git fetch`: Download changes without merging
- `git rebase`: Rewrite commit history (use carefully!)
- `git cherry-pick`: Apply specific commits from other branches
- `git stash`: Temporarily save uncommitted changes
- `git blame`: See who last modified each line
- `git bisect`: Find which commit introduced a bug
- `git tag`: Mark specific versions

**Don't worry** - we'll start with the basics!

## Git Basics for This Course: Simplified Workflow

For this course, you'll use a simplified workflow focusing on five key operations:

1. **Initialize**: Create a new Git repository
2. **Edit**: Make changes to files
3. **Commit**: Save your changes with a message
4. **Push**: Upload your changes to GitHub
5. **Pull**: Download updates (when collaborating)

### The Basic Cycle

```
Create repo on GitHub.com           Remote Server
    ↓                                     ↑
Initialize locally                      push
    ↓                                     ↑
Edit files → Save → Commit → Repeat → Push
```

## Git in VS Code: The Complete Guide

VS Code has excellent Git integration built-in. You'll rarely need to use the command line!

### Creating Your GitHub Account

Before we start, you need a GitHub account.

#### Step 1: Sign Up for GitHub

1. Go to [https://github.com](https://github.com)

2. Click **Sign up** in the top right corner

3. Enter your information:
   - **Email**: Use your university email for education benefits
   - **Password**: Choose a strong password
   - **Username**: Pick something professional (you'll use this professionally!)
     - Good examples: `jsmith-bio`, `johndoe`, `janesmith-dev`
     - Avoid: `coolhacker123`, `party_animal`

4. Verify your account through email

5. Choose the free plan

#### Step 2: (Optional) GitHub Student Developer Pack

As a student, you can get free access to premium features:

1. Go to [https://education.github.com/pack](https://education.github.com/pack)

2. Click **Get your pack**

3. Follow the verification process with your university email

**Benefits**:
- Unlimited private repositories
- GitHub Copilot access
- Free cloud credits and tools

### Initial Setup: Configuring Git

Before using Git, you need to tell it who you are.

#### Method 1: Using VS Code Terminal

1. Open VS Code and connect to your remote server
2. Open the integrated terminal (`Cmd+J` / `Ctrl+J`)
3. Configure your identity:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

4. Verify your configuration:
```bash
git config --list
```

**Important**: Use the same email as your GitHub account!

#### Optional: Set Default Editor

```bash
git config --global core.editor "code --wait"
```

This makes VS Code your default Git editor.

#### Optional: Set Default Branch Name

```bash
git config --global init.defaultBranch main
```

This sets `main` as the default branch name (instead of `master`).

### Understanding the VS Code Git Interface

#### Source Control Panel

Click the **Source Control** icon (branch symbol) in the Activity Bar to see:

**Sections**:
1. **Source Control**: Shows changes and commit options
2. **Changes**: Files you've modified
3. **Staged Changes**: Files ready to commit (if staging is enabled)
4. **Commits**: (When viewing history)

**File Status Indicators**:
- **M** (Modified): File has been changed
- **U** (Untracked): New file not yet tracked by Git
- **D** (Deleted): File has been removed
- **A** (Added): New file staged for commit
- **C** (Conflict): Merge conflict needs resolution

#### Status Bar Git Information

At the bottom left, you'll see:
- **Branch name**: e.g., `main`
- **Sync icon**: Shows commits to push/pull
- **Changes icon**: Number of uncommitted changes

### Creating Your Personal Repository

Let's create your own repository on GitHub for this course.

#### Step 1: Create Repository on GitHub

1. Log in to [https://github.com](https://github.com)

2. Click the **+** icon in the top right corner

3. Select **New repository**

4. Fill in the repository details:
   - **Repository name**: `bioinfo_applications_2026` (or similar)
   - **Description**: "Personal workspace for Bioinformatics Applications course"
   - **Visibility**: Select **Public** ✅
     - Public repositories are free
     - Allows sharing your work with instructors and peers
     - Good for your portfolio
   - **Initialize repository**: ✅ Check these boxes:
     - ✅ **Add a README file**
     - ✅ **Add .gitignore**: Select **Python** template
     - ⬜ **Choose a license**: Skip for now (or select MIT)

5. Click **Create repository**

Congratulations! Your repository is now live at:
```
https://github.com/YOUR_USERNAME/bioinfo_applications_2026
```

#### Step 2: Set Up Authentication

You need to authenticate VS Code with GitHub to push and pull changes.

**Option 1: Personal Access Token (Recommended)**

1. On GitHub.com → Click your profile picture → **Settings**

2. Scroll down to **Developer settings** → **Personal access tokens** → **Tokens (classic)**

3. Click **Generate new token (classic)**

4. Configure the token:
   - **Note**: "VS Code on Server" (or descriptive name)
   - **Expiration**: 90 days (or longer)
   - **Select scopes**: Check these boxes:
     - ✅ `repo` (Full control of private repositories)
     - ✅ `workflow` (if using GitHub Actions)

5. Click **Generate token**

6. **IMMEDIATELY COPY THE TOKEN** - you'll never see it again!
   ```
   ghp_xxxxxxxxxxxxxxxxxxxx
   ```

7. Save it securely (password manager or secure note)

**Option 2: SSH Keys (Advanced)**

If you've set up SSH keys in the VS Code tutorial, you can use SSH instead.

1. Check if you have SSH keys:
   ```bash
   ls -la ~/.ssh
   ```

2. If you see `id_rsa.pub` or `id_ed25519.pub`, you have keys

3. Copy your public key:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   # or
   cat ~/.ssh/id_rsa.pub
   ```

4. On GitHub.com → Settings → **SSH and GPG keys** → **New SSH key**

5. Paste your public key and save

#### Step 3: Clone Your Repository to the Server

Now let's get your repository onto your server.

**Method 1: Using VS Code Command Palette**

1. In VS Code connected to your server, press `Cmd+Shift+P` / `Ctrl+Shift+P`

2. Type "Git: Clone" and press Enter

3. Paste your repository URL:
   - **HTTPS**: `https://github.com/YOUR_USERNAME/bioinfo_applications_2026.git`
   - **SSH**: `git@github.com:YOUR_USERNAME/bioinfo_applications_2026.git`

4. Choose a location (e.g., `/home/username/` or `~/`)

5. Wait for cloning to complete

6. Click **Open** when prompted

**Method 2: Using Terminal**

1. Open the integrated terminal in VS Code

2. Navigate to your home directory:
   ```bash
   cd ~
   ```

3. Clone your repository:
   ```bash
   # Using HTTPS
   git clone https://github.com/YOUR_USERNAME/bioinfo_applications_2026.git
   
   # Or using SSH
   git clone git@github.com:YOUR_USERNAME/bioinfo_applications_2026.git
   ```

4. Open the folder in VS Code:
   - File → Open Folder → Select `bioinfo_applications_2026`
#### Step 4: Verify the Setup

1. Check the Source Control panel in VS Code - you should see the branch name (`main`)

2. Explore the files in the Explorer panel:
   - `README.md` - Your repository description
   - `.gitignore` - Files Git should ignore

3. In the terminal, verify Git status:
   ```bash
   git status
   ```
   Should show: "On branch main" and "nothing to commit, working tree clean"

4. Check your remote connection:
   ```bash
   git remote -v
   ```
   Should show your GitHub repository URL

### Setting Up Your Repository Structure

Now let's organize your repository for the course.

#### Step 1: Create Directory Structure

1. In VS Code Explorer, create the following folders:
   - `notes/` - For your course notes
   - `scripts/` - For your Python and R scripts
   - `data/` - For data files (will be in .gitignore)
   - `assignments/` - For course assignments
   - `tutorials/` - For tutorial exercises

2. Or use the terminal:
   ```bash
   cd ~/bioinfo_applications_2026
   mkdir -p notes scripts data assignments tutorials
   ```

#### Step 2: Update Your README

1. Open `README.md` in VS Code

2. Replace the content with something like:
   ````markdown
   # Bioinformatics Applications 2026
   
   Personal workspace for the Bioinformatics Applications course at University of Neuchâtel.
   
   ## About Me
   
   **Name**: Your Name  
   **Program**: Your degree program  
   **Year**: 2026
   
   ## Repository Structure
   
   - `notes/` - Course notes and summaries
   - `scripts/` - Analysis scripts and code
   - `data/` - Data files (ignored by Git)
   - `assignments/` - Course assignments
   - `tutorials/` - Tutorial exercises and practice code
   
   ## Course Information
   
   - **Instructor**: Daniel Croll
   - **Institution**: University of Neuchâtel
   - **Semester**: Spring 2026
   
   ## Learning Objectives
   
   - Master Unix/Linux command line
   - Learn Python and R for bioinformatics
   - Understand genomic data analysis  
   - Develop reproducible workflows
   
   ## Contact
   
   - University email: your.email@unine.ch
   - GitHub: [@your_username](https://github.com/your_username)
   ````

3. Save the file (`Cmd+S` / `Ctrl+S`)

#### Step 3: Update .gitignore

1. Open `.gitignore` file

2. Add these lines for bioinformatics-specific files:
   ```
   # Data files (too large for Git)
   data/
   *.fastq
   *.fastq.gz
   *.fasta.gz
   *.bam
   *.sam
   *.vcf.gz
   *.bed
   *.gff
   
   # R files
   .Rhistory
   .RData
   .Rproj.user/
   *.Rproj
   
   # Jupyter notebooks checkpoints
   .ipynb_checkpoints/
   
   # Results and figures (can be regenerated)
   results/
   output/
   
   # macOS
   .DS_Store
   
   # Editor
   .vscode/settings.json
   ```

3. Save the file

### Making Your First Commit

Now let's commit these changes.

#### Step 1: Review Your Changes

1. Click the **Source Control** icon in VS Code Activity Bar (branch symbol)

2. You should see modified files:
   - `README.md` with **M** (Modified)
   - `.gitignore` with **M** (Modified)

3. Click on each file to see the changes (diff view):
   - Green lines: Added content
   - Red lines: Deleted content

### Committing Changes

A commit saves your changes to the local Git history.

#### Method 1: Using Source Control Panel (Recommended)

1. In the Source Control panel, you'll see your changed files

2. **Write a commit message** in the text box at the top:
   ```
   Initialize repository structure and update README
   ```

   **Good commit messages**:
   - Short and descriptive (50 characters or less for the first line)
   - Use present tense: "Add feature" not "Added feature"
   - Explain what and why, not how
   - Examples:
     - ✅ "Add course notes for week 1"
     - ✅ "Update README with learning objectives"
     - ✅ "Fix bug in sequence parser"
     - ❌ "Fixed stuff"
     - ❌ "asdf"
     - ❌ "updates"

3. **Commit the changes**:
   - Click the **✓ Commit** button
   - Or press `Cmd+Enter` / `Ctrl+Enter` while in the message box

4. If prompted to stage changes, click **Yes** or **Always**

5. Your changes are now committed locally!

#### Method 2: Using Terminal

```bash
# Stage all changes
git add .

# Or stage specific files
git add README.md .gitignore

# Commit with a message
git commit -m "Initialize repository structure and update README"
```

#### Understanding Your Commit

Your commit is now in your **local** Git history:
- It has a unique ID (hash)
- It records your changes
- It includes your name, email, and timestamp
- It's **not yet** on GitHub - it's only on your server

To see your commit:
```bash
git log
```

Or in VS Code: Click on the **Timeline** view in the Explorer panel.

### Pushing Changes to GitHub

Now let's upload your commit to GitHub.

#### First-Time Authentication

When you push for the first time, you'll need to authenticate.

**If using HTTPS**:

1. You'll be prompted for credentials:
   - **Username**: Your GitHub username
   - **Password**: Use your **Personal Access Token** (the one you saved earlier!)

2. The token looks like: `ghp_xxxxxxxxxxxxxxxxxxxx`

3. VS Code may save the credentials securely

**If using SSH**:
- Authentication happens automatically with your SSH key
- No password/token needed

#### Pushing: Using VS Code

1. In the Source Control panel, look at the Status Bar (bottom of VS Code)

2. Click the **↑** (cloud upload) icon or **Sync Changes** button

3. Or click the **•••** (three dots) menu → **Push**

4. Wait for the push to complete

5. You'll see a success notification

#### Pushing: Using Terminal

```bash
git push
```

If this is your first push on this repository:
```bash
git push -u origin main
```

The `-u` flag sets the upstream branch (you only need this once).

#### Verify on GitHub

1. Go to your repository on GitHub.com:
   ```
   https://github.com/YOUR_USERNAME/bioinfo_applications_2026
   ```

2. You should see:
   - Your updated README
   - Your folder structure
   - Your commit message
   - The commit timestamp

3. Click on "commits" to see your commit history

Congratulations! Your changes are now publicly visible on GitHub! 🎉

### The Complete Edit-Commit-Push Cycle

Now you understand the full workflow. Let's practice with course content!

#### Creating Your First Course Notes

1. **Create a new file**: `notes/week1_introduction.md`

2. **Add content**:
   ````markdown
   # Week 1: Introduction to Bioinformatics
   
   ## Date: [Today's date]
   
   ## Topics Covered
   
   - What is bioinformatics?
   - Why use command line and version control?
   - Setting up the development environment
   
   ## Key Concepts
   
   ### Bioinformatics
   - Application of computational tools to biological data
   - Essential for modern biology and genomics
   - Requires programming, statistics, and biology knowledge
   
   ### Version Control with Git
   - Tracks changes in code over time
   - Enables collaboration
   - Provides backup and history
   
   ## Commands Learned
   
   ```bash
   git config --global user.name "Name"
   git config --global user.email "email"
   git clone <url>
   git status
   git add .
   git commit -m "message"
   git push
   ```
   
   ## Questions/To-Do
   
   - [ ] Practice more Git commands
   - [ ] Read about branching strategies
   - [ ] Explore GitHub features
   
   ## Resources
   
   - [Git Documentation](https://git-scm.com/doc)
   - [GitHub Guides](https://guides.github.com/)
   ````

3. **Save the file**

#### Creating Your First Script

1. **Create a new file**: `scripts/hello_bioinfo.py`

2. **Add a simple Python script**:
   ```python
   #!/usr/bin/env python3
   """
   My first bioinformatics script
   Author: Your Name
   Date: 2026-02-16
   """
   
   def greet(name):
       """Print a personalized greeting for bioinformatics."""
       print(f"Hello, {name}!")
       print("Welcome to Bioinformatics Applications!")
       print("Let's analyze some genomes! 🧬")
   
   def main():
       """Main function."""
       greet("Student")
       
       # Simple DNA sequence example
       dna_sequence = "ATGCGATCGTAGCTA"
       print(f"\nExample DNA sequence: {dna_sequence}")
       print(f"Length: {len(dna_sequence)} bp")
       print(f"GC content: {(dna_sequence.count('G') + dna_sequence.count('C')) / len(dna_sequence) * 100:.1f}%")
   
   if __name__ == "__main__":
       main()
   ```

3. **Save and test**:
   ```bash
   python scripts/hello_bioinfo.py
   ```

#### Commit and Push These Changes

1. **Review changes** in Source Control panel
   - `notes/week1_introduction.md` (new file)
   - `scripts/hello_bioinfo.py` (new file)

2. **Write commit message**:
   ```
   Add week 1 notes and first Python script
   ```

3. **Commit** (click ✓ or press `Cmd+Enter`)

4. **Push** (click sync icon)

5. **Verify on GitHub**: Refresh your repository page

#### Best Practice Workflow

For every work session:

```
1. Start working
   ├── Open VS Code
   └── (Optional) Pull latest changes: git pull

2. Make changes
   ├── Edit files
   ├── Save frequently
   └── Test your code

3. Commit logically
   ├── Review what changed
   ├── Write descriptive message
   └── Commit related changes together

4. Push regularly
   ├── Push after each commit or at end of session
   └── Verify on GitHub.com

5. Repeat!
```

**Tips**:
- Commit after completing a logical unit of work
- Don't commit broken code (test first!)
- Push at least once per work session
- Write messages for your future self

### Pulling Changes (For Collaboration)

When working from multiple computers or collaborating with others, you'll need to **pull** changes.

#### When to Pull

- Working on both your laptop and the server
- Collaborating with classmates  
- Made changes directly on GitHub.com (edited files in web interface)
- Before starting a new work session (good practice)

#### Method 1: Using VS Code

1. Click the **↓** (download) icon in the Status Bar

   Or go to Source Control → **•••** menu → **Pull**

2. VS Code downloads and merges the changes

3. Check the Output panel if there are issues

#### Method 2: Using Terminal

```bash
git pull
```

This downloads changes from GitHub and merges them with your local work.

#### Example Scenario: Working on Multiple Computers

**On the server (Monday)**:
```bash
# Make changes
echo "Week 1 notes" > notes/week1.md
git add notes/week1.md
git commit -m "Add week 1 notes"
git push
```

**On your laptop (Tuesday)**:
```bash
# Get the changes from the server
git pull

# Now you have week1.md on your laptop!
# Make more changes
echo "Additional notes" >> notes/week1.md
git commit -am "Update week 1 notes"
git push
```

**Back on the server (Wednesday)**:
```bash
# Get the laptop changes
git pull

# Continue working with the latest version
```

### Editing Files on GitHub.com

Sometimes it's convenient to edit files directly on GitHub.

#### Quick Edits on GitHub

1. Navigate to your repository on GitHub.com

2. Click on a file (e.g., `README.md`)

3. Click the **✏️ (pencil)** icon to edit

4. Make your changes in the web editor

5. Scroll down to commit:
   - Write a commit message
   - Click **Commit changes**

6. **Important**: Pull these changes to your server!
   ```bash
   git pull
   ```

#### When to Edit on GitHub

✅ Good uses:
- Quick typo fixes in README
- Updating documentation
- Small text changes

❌ Avoid for:
- Code changes (harder to test)
- Large edits (no syntax highlighting)
- Multiple file changes

### Handling Local Changes When Pulling

**Scenario**: You're trying to pull, but Git says you have uncommitted changes.

**Option 1: Commit your changes first** (Recommended)

```bash
# Commit your current work
git add .
git commit -m "Work in progress on analysis"

# Now pull
git pull
```

**Option 2: Stash your changes temporarily**

In terminal:
```bash
# Save your changes temporarily
git stash

# Pull the updates
git pull

# Restore your changes
git stash pop
```

In VS Code:
1. Source Control → **•••** menu → **Stash** → **Stash (Include Untracked)**
2. Pull the updates
3. Source Control → **•••** menu → **Stash** → **Apply Latest Stash**

### Sharing Your Repository

Your repository is public! Here's how to share it.

#### Getting Your Repository URL

Share this with instructors, classmates, or for your portfolio:
```
https://github.com/YOUR_USERNAME/bioinfo_applications_2026
```

#### Adding Collaborators (Optional)

To let someone push to your repository:

1. On GitHub.com → Your repository → **Settings**

2. **Collaborators and teams** → **Add people**

3. Search for their GitHub username

4. They'll receive an invitation email

#### Viewing Your Repository

Anyone can:
- View your code
- Read your README  
- See your commit history
- Download your repository

But they **cannot**:
- Push changes (unless you add them as collaborator)
- Delete your repository
- Modify your files

### Forking Others' Repositories (Optional)

If you want to use someone else's code as a starting point:

1. Go to their repository on GitHub

2. Click **Fork** button (top right)

3. This creates a copy under your account

4. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/their_repo_name.git
   ```

5. Make changes and push to your fork

6. To get updates from the original:
   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/repo_name.git
   git pull upstream main
   ```

## Working with Branches

Branches let you work on different features simultaneously.

### Creating a Branch in VS Code

1. Click the branch name in the Status Bar (e.g., `main`)

2. Select **Create new branch**

3. Enter a branch name (e.g., `analysis-improvements`)

4. Press Enter

You're now on the new branch!

### Switching Branches

1. Click the branch name in the Status Bar

2. Select the branch you want to switch to

3. VS Code switches branches (your files will change!)

### Merging Branches

1. Switch to the branch you want to merge into (e.g., `main`)

2. Source Control → **•••** menu → **Branch** → **Merge Branch**

3. Select the branch to merge

4. Handle any conflicts if they arise

### Deleting a Branch

```bash
# Delete local branch
git branch -d branch-name

# Delete remote branch
git push origin --delete branch-name
```

## Best Practices for Course Work

### Do's ✅

1. **Commit frequently**: Small, logical commits are better than large ones
2. **Write clear messages**: Future you will thank you
3. **Pull before you start working**: Get the latest updates
4. **Push regularly**: Don't lose work if something happens to your server
5. **Use branches for experiments**: Keep `main` stable
6. **Review changes before committing**: Check what you're actually committing
7. **Keep commits focused**: One commit = one logical change

### Don'ts ❌

1. **Don't commit sensitive data**: Passwords, API keys, personal information
2. **Don't commit large data files**: Use `.gitignore` for data files > 50MB
3. **Don't commit compiled files**: Python `__pycache__`, R `.Rdata`, etc.
4. **Don't rewrite public history**: Avoid `git rebase` on pushed commits
5. **Don't commit commented-out code**: Delete it (it's in Git history if needed)
6. **Don't use vague commit messages**: "Fixed stuff" is not helpful

### Using .gitignore

A `.gitignore` file tells Git which files to ignore.

**Example `.gitignore` for bioinformatics**:

```
# Python
__pycache__/
*.pyc
*.pyo
*.egg-info/
.pytest_cache/

# R
.Rhistory
.RData
.Rproj.user/

# Data files (too large)
*.fastq
*.fastq.gz
*.bam
*.vcf.gz

# Results that can be regenerated
results/
figures/

# Editor files
.vscode/
.DS_Store
*~

# Temporary files
*.tmp
*.log
```

**Creating .gitignore**:
1. Create a file named `.gitignore` in your repository root
2. Add patterns for files to ignore
3. Commit the `.gitignore` file

## Organizing Your Repository

### Recommended Structure

Your repository should be well-organized and professional:

```
bioinfo_applications_2026/
├── .gitignore                   # Files to ignore
├── README.md                    # Repository description
├── notes/                       # Your course notes
│   ├── week1_introduction.md
│   ├── week2_unix.md
│   ├── week3_python.md
│   └── ...
├── scripts/                     # Your analysis scripts
│   ├── hello_bioinfo.py
│   ├── sequence_parser.py
│   ├── data_analysis.R
│   └── ...
├── tutorials/                   # Tutorial exercises
│   ├── bash_tutorial/
│   ├── python_tutorial/
│   └── r_tutorial/
├── assignments/                 # Course assignments
│   ├── assignment1/
│   ├── assignment2/
│   └── ...
├── data/                        # Data files (in .gitignore!)
│   ├── raw/
│   └── processed/
└── figures/                     # Generated figures
    ├── plot1.png
    └── analysis_results.pdf
```

### What to Commit vs What to Ignore

#### ✅ DO Commit

- Source code (`.py`, `.R`, `.sh`, `.md`)
- Documentation and READMEs
- Configuration files
- Small reference files (< 1 MB)
- Jupyter notebooks (`.ipynb`)
- Analysis scripts
- Your `.gitignore` file

#### ❌ DON'T Commit

- Large data files (> 50 MB)
  - Raw sequencing data (`.fastq`, `.fastq.gz`)
  - BAM/SAM alignment files
  - Large VCF files
  - Genome assemblies
- Generated/compiled files
  - Python `__pycache__/`, `.pyc`
  - R `.RData`, `.Rhistory`
- Temporary files
  - `.tmp`, `.log`, `.swp`
- Sensitive information
  - Passwords, API keys
  - Personal data
- System files
  - `.DS_Store` (macOS)
  - `Thumbs.db` (Windows)

## Troubleshooting Common Issues

### Version Mismatch Between Local and Remote

**Symptom**: Error when pushing or pulling:
```
Your branch and 'origin/main' have diverged
```

**Cause**: You have commits locally that aren't on GitHub, and GitHub has commits you don't have locally.

**Solution 1: Pull with Rebase** (if your changes aren't pushed yet)

In VS Code terminal:
```bash
git pull --rebase
```

This rewrites your local commits on top of the remote commits.

**Solution 2: Pull with Merge** (safer)

```bash
git pull
```

This creates a merge commit combining both histories.

**Solution 3: Force Pull** (⚠️ YOU WILL LOSE LOCAL CHANGES)

```bash
git fetch origin
git reset --hard origin/main
```

Only use this if you want to discard your local changes!

### Merge Conflicts

**Symptom**: Git says there's a merge conflict:
```
CONFLICT (content): Merge conflict in analysis.py
```

**Solution**:

1. Open the conflicting file in VS Code

2. You'll see conflict markers:
   ```python
   <<<<<<< HEAD (Current Change)
   result = analyze_sequences(data, method='new')
   =======
   result = analyze_sequences(data, method='old')
   >>>>>>> main (Incoming Change)
   ```

3. VS Code shows inline options:
   - **Accept Current Change**: Keep your version
   - **Accept Incoming Change**: Keep the remote version
   - **Accept Both Changes**: Keep both (be careful!)
   - **Compare Changes**: See differences side-by-side

4. Click the option you want, or manually edit the file

5. Remove conflict markers if editing manually

6. Save the file

7. Stage and commit the resolution:
   ```bash
   git add analysis.py
   git commit -m "Resolve merge conflict in analysis.py"
   ```

### Accidentally Committed to Wrong Branch

**Symptom**: You committed to `main` but meant to create a feature branch.

**Solution**:

```bash
# Create new branch with your changes
git branch feature-branch

# Reset main to origin
git reset --hard origin/main

# Switch to new branch
git checkout feature-branch
```

In VS Code: Use the Source Control → **•••** menu → **Branch** options.

### Undo Last Commit (Not Pushed)

**Symptom**: You committed but the commit message is wrong or you forgot something.

**Solution 1**: Amend the last commit

```bash
# Make additional changes
git add forgotten_file.py

# Amend the previous commit
git commit --amend
```

In VS Code: Source Control → **•••** menu → **Commit** → **Commit Staged (Amend)**

**Solution 2**: Undo the commit but keep changes

```bash
git reset --soft HEAD~1
```

**Solution 3**: Undo the commit and discard changes (⚠️ DESTRUCTIVE)

```bash
git reset --hard HEAD~1
```

### File Showing as Changed But You Didn't Change It

**Symptom**: VS Code shows a file as modified, but you don't see any differences.

**Common causes**:
1. Line ending differences (Windows vs. Unix)
2. File permissions changed
3. Whitespace changes

**Solution for line endings**:

```bash
# Configure Git to handle line endings
git config --global core.autocrlf input  # On Mac/Linux
git config --global core.autocrlf true   # On Windows
```

**Solution for whitespace**:

```bash
# Ignore whitespace changes in diff
git diff -w
```

### Permission Denied (Publickey)

**Symptom**: When pushing:
```
Permission denied (publickey)
```

**Cause**: You're using SSH but haven't set up keys properly.

**Solution**:

1. **Switch to HTTPS** (simpler):
   ```bash
   git remote set-url origin https://github.com/crolllab/bioinfo_applications.git
   ```

2. **Or fix SSH keys**:
   - Follow the SSH setup in the VS Code tutorial
   - Make sure your public key is added to GitHub
   - Test: `ssh -T git@github.com`

### Rejected Push: Non-Fast-Forward

**Symptom**:
```
Updates were rejected because the tip of your current branch is behind
```

**Cause**: Remote has commits you don't have locally.

**Solution**:

```bash
# Pull first
git pull

# Then push
git push
```

If you're certain you want to overwrite remote (⚠️ DANGEROUS):
```bash
git push --force
```

Only use `--force` if you're absolutely sure!

### Accidentally Committed Large File

**Symptom**:
```
remote: error: File large_data.fastq is 500 MB; this exceeds GitHub's file size limit of 100 MB
```

**Solution**:

```bash
# Remove file from last commit
git rm --cached large_data.fastq

# Add to .gitignore
echo "large_data.fastq" >> .gitignore

# Amend the commit
git commit --amend

# Push
git push
```

If the commit is already pushed, you need to rewrite history (ask for help!).

### Lost Work / Deleted Files by Mistake

**Don't panic!** Git keeps history.

**Recover uncommitted changes**:
```bash
# Check if you stashed them
git stash list
git stash pop
```

**Recover deleted file**:
```bash
# Find when it was deleted
git log --oneline --all -- path/to/file.py

# Restore from a previous commit
git checkout <commit-hash> -- path/to/file.py
```

**See all recent actions**:
```bash
git reflog
```

The reflog shows every action - you can usually recover from mistakes!

## Git Workflow Cheat Sheet

### Daily Workflow

```bash
# 1. Start your work session
git pull                          # Get latest updates

# 2. Make changes
# Edit files in VS Code

# 3. Check what changed
git status                        # See modified files
git diff                          # See changes

# 4. Stage and commit
git add file1.py file2.py         # Stage specific files
# or
git add .                         # Stage all changes

git commit -m "Descriptive message"

# 5. Push to GitHub
git push
```

### VS Code Shortcuts

- `Cmd+Shift+G` / `Ctrl+Shift+G`: Open Source Control panel
- `Cmd+Enter` / `Ctrl+Enter`: Commit (while in message box)
- Click branch name in Status Bar: Switch/create branches
- Click sync icon: Push/pull changes

### Common Commands

```bash
# Status and history
git status                        # See what's changed
git log                           # View commit history
git log --oneline                 # Compact history
git diff                          # See unstaged changes

# Branches
git branch                        # List branches
git branch new-branch             # Create branch
git checkout branch-name          # Switch branch
git checkout -b new-branch        # Create and switch
git merge branch-name             # Merge branch into current

# Undoing
git restore file.py               # Discard changes in file
git restore --staged file.py      # Unstage file
git reset --soft HEAD~1           # Undo last commit, keep changes
git reset --hard HEAD~1           # Undo last commit, discard changes

# Remotes
git remote -v                     # List remotes
git fetch                         # Download changes (don't merge)
git pull                          # Download and merge changes
git push                          # Upload commits
```

## Additional Resources

### Official Documentation

- **Git Official Site**: [https://git-scm.com/](https://git-scm.com/)
- **Git Book (free)**: [https://git-scm.com/book/en/v2](https://git-scm.com/book/en/v2)
- **GitHub Docs**: [https://docs.github.com/](https://docs.github.com/)
- **VS Code Git Guide**: [https://code.visualstudio.com/docs/sourcecontrol/overview](https://code.visualstudio.com/docs/sourcecontrol/overview)

### Interactive Tutorials

- **Learn Git Branching**: [https://learngitbranching.js.org/](https://learngitbranching.js.org/) - Visual and interactive
- **GitHub Skills**: [https://skills.github.com/](https://skills.github.com/) - Hands-on tutorials
- **Git-it**: Desktop app for learning Git

### Cheat Sheets

- **Git Cheat Sheet (PDF)**: [https://education.github.com/git-cheat-sheet-education.pdf](https://education.github.com/git-cheat-sheet-education.pdf)
- **Visual Git Cheat Sheet**: [https://ndpsoftware.com/git-cheatsheet.html](https://ndpsoftware.com/git-cheatsheet.html)

### Getting Help

- **Git help command**: `git help <command>` or `git <command> --help`
- **VS Code Git documentation**: Press `F1` and search for "Git"
- **Stack Overflow**: Tag questions with `[git]`
- **Ask the instructor or classmates!**

## Practice Exercise

Complete this exercise to solidify your Git and GitHub skills.

### Exercise: Build Your Course Portfolio

#### Part 1: Set Up Your Repository (Already Done!)

✅ Created GitHub account  
✅ Created public repository  
✅ Cloned to server  
✅ Made first commits

#### Part 2: Create Course Documentation

1. **Create an "About Me" page**:
   ```bash
   touch notes/about_me.md
   ```

2. **Edit `notes/about_me.md`** with your information:
   ````markdown
   # About Me
   
   ## Background
   
   **Name**: Your Name  
   **Program**: MSc in Biology / PhD candidate / etc.  
   **University**: University of Neuchâtel  
   **Year**: 2026
   
   ## Research Interests
   
   - Genomics and evolution
   - Population genetics
   - Bioinformatics tools development
   - [Add your interests]
   
   ## Prior Experience
   
   ### Programming
   - Python: [Beginner/Intermediate/Advanced]
   - R: [Beginner/Intermediate/Advanced]
   - Bash/Unix: [Beginner/Intermediate/Advanced]
   
   ### Biology
   - Molecular biology
   - Genetics
   - [Your specific areas]
   
   ## Goals for This Course
   
   1. Master command-line tools for genomic analysis
   2. Learn to write reproducible analysis pipelines
   3. Understand genome analysis workflows
   4. Contribute to open-source bioinformatics projects
   
   ## Contact
   
   - GitHub: [@your_username](https://github.com/your_username)
   - Email: your.email@unine.ch
   ````

3. **Commit and push**:
   ```bash
   git add notes/about_me.md
   git commit -m "Add personal introduction"
   git push
   ```

#### Part 3: Create a Learning Log

1. **Create `notes/learning_log.md`**:
   ````markdown
   # Learning Log
   
   Track your progress throughout the course.
   
   ## Week 1: Introduction
   
   **Date**: 2026-02-16
   
   ### What I Learned
   - Set up development environment (VS Code, Git)
   - Created my first GitHub repository
   - Basic Git workflow: add, commit, push
   - Unix command line basics
   
   ### Commands Practiced
   ```bash
   git config --global user.name "Name"
   git config --global user.email "email"
   git clone <url>
   git status
   git add .
   git commit -m "message"
   git push
   git pull
   ```
   
   ### Challenges
   - Understanding the difference between Git and GitHub
   - Remembering to commit frequently
   
   ### Solutions
   - Git = local version control software
   - GitHub = cloud hosting service for Git repositories
   - Set a reminder to commit every 30 minutes
   
   ### Resources Used
   - [Git Documentation](https://git-scm.com/doc)
   - [VS Code Git Guide](https://code.visualstudio.com/docs/sourcecontrol/overview)
   
   ### Questions for Next Time
   - How do branches work in detail?
   - When should I create a new branch?
   
   ---
   
   ## Week 2: [Template]
   
   **Date**: 
   
   ### What I Learned
   
   ### Commands Practiced
   
   ### Challenges
   
   ### Solutions
   
   ### Resources Used
   
   ### Questions for Next Time
   ````

2. **Commit and push**:
   ```bash
   git add notes/learning_log.md
   git commit -m "Initialize learning log"
   git push
   ```

#### Part 4: Create a Python Script Collection

1. **Create `scripts/dna_utilities.py`**:
   ```python
   #!/usr/bin/env python3
   """
   DNA sequence utilities for bioinformatics
   Author: Your Name
   Date: 2026-02-16
   """
   
   def reverse_complement(sequence):
       """Return the reverse complement of a DNA sequence."""
       complement = {'A': 'T', 'T': 'A', 'G': 'C', 'C': 'G'}
       return ''.join(complement.get(base, base) for base in reversed(sequence))
   
   def gc_content(sequence):
       """Calculate GC content as a percentage."""
       gc_count = sequence.count('G') + sequence.count('C')
       return (gc_count / len(sequence)) * 100 if len(sequence) > 0 else 0
   
   def count_kmers(sequence, k=3):
       """Count all k-mers in a sequence."""
       kmer_counts = {}
       for i in range(len(sequence) - k + 1):
           kmer = sequence[i:i+k]
           kmer_counts[kmer] = kmer_counts.get(kmer, 0) + 1
       return kmer_counts
   
   def main():
       """Test functions with example sequence."""
       test_seq = "ATGCGATCGTAGCTAGCTAGC"
       
       print(f"Original sequence: {test_seq}")
       print(f"Length: {len(test_seq)} bp")
       print(f"GC content: {gc_content(test_seq):.1f}%")
       print(f"Reverse complement: {reverse_complement(test_seq)}")
       print(f"\nTrimer counts:")
       for kmer, count in sorted(count_kmers(test_seq, 3).items()):
           print(f"  {kmer}: {count}")
   
   if __name__ == "__main__":
       main()
   ```

2. **Test it**:
   ```bash
   python scripts/dna_utilities.py
   ```

3. **Commit and push**:
   ```bash
   git add scripts/dna_utilities.py
   git commit -m "Add DNA sequence utility functions"
   git push
   ```

#### Part 5: Update Your Main README

1. **Edit `README.md`** to add recent updates:
   ````markdown
   [... previous content ...]
   
   ## Recent Updates
   
   - **2026-02-16**: Added personal introduction and learning log
   - **2026-02-16**: Created DNA sequence utilities module
   - **2026-02-16**: Initialized repository structure
   
   ## Highlighted Work
   
   ### Scripts
   - [`dna_utilities.py`](scripts/dna_utilities.py) - Basic DNA sequence operations
   
   ### Notes
   - [Learning Log](notes/learning_log.md) - Weekly progress tracking
   - [About Me](notes/about_me.md) - Background and goals
   
   ## Statistics
   
   - Total commits: [Check `git log --oneline | wc -l`]
   - Lines of code: [Approximately XX]
   - Languages: Python, Bash, R
   ````

2. **Commit and push**:
   ```bash
   git add README.md
   git commit -m "Update README with recent work"
   git push
   ```

#### Part 6: Verify Your Work

1. **Check your commits**:
   ```bash
   git log --oneline
   ```

2. **View your repository on GitHub**:
   - Go to `https://github.com/YOUR_USERNAME/bioinfo_applications_2026`
   - You should see all your files
   - Click through your notes and scripts
   - Check that README looks good

3. **Share your repository**:
   - Copy the URL
   - Share with instructor or classmates
   - Add to your CV/portfolio!

### Bonus Challenges

If you finish early:

1. **Add badges to README**:
   ```markdown
   ![GitHub last commit](https://img.shields.io/github/last-commit/YOUR_USERNAME/bioinfo_applications_2026)
   ![GitHub repo size](https://img.shields.io/github/repo-size/YOUR_USERNAME/bioinfo_applications_2026)
   ```

2. **Create a LICENSE file**:
   - GitHub → Add file → Create new file
   - Name it `LICENSE`
   - Choose MIT, GPL, or other open-source license

3. **Explore GitHub features**:
   - Star some bioinformatics repositories
   - Follow other students
   - Explore the "Explore" tab for projects

4. **Practice branching**:
   ```bash
   git checkout -b experimental
   # Make some changes
   git commit -am "Experimental feature"
   git checkout main
   git merge experimental
   ```

## Summary

You've learned:
- ✅ The history and importance of Git and GitHub
- ✅ How Git enables collaborative coding
- ✅ How to create a GitHub account
- ✅ How to create your own public repository
- ✅ The basic Git workflow: initialize → edit → commit → push
- ✅ How to use Git seamlessly in VS Code
- ✅ How to organize a bioinformatics project repository
- ✅ How to troubleshoot common Git issues
- ✅ Best practices for version control in bioinformatics

**Key takeaways**:
- Git tracks every change to your project
- GitHub hosts your repository and enables sharing
- Commit frequently with clear, descriptive messages
- Push regularly to avoid losing work and to share your progress
- Your public repository is your professional portfolio
- VS Code makes Git visual and intuitive
- Don't be afraid of Git - you can usually recover from mistakes!

**Your repository checklist**:
- ✅ Created public repository on GitHub
- ✅ Cloned to your server
- ✅ Set up folder structure
- ✅ Updated README with your information
- ✅ Created .gitignore for large files
- ✅ Made multiple commits
- ✅ Pushed to GitHub
- ✅ Shared repository URL

**Next steps**:
- Update your repository daily as you learn
- Document your progress in your learning log
- Add new scripts and analyses as you create them
- Keep your README updated with recent work
- Practice the workflow until it becomes second nature
- Explore advanced Git features (branches, tags)
- Collaborate with classmates on shared projects
- Build your portfolio of bioinformatics work

**Your Repository as Your Portfolio**:

Your GitHub repository is now:
- 📚 Your course notebook
- 💻 Your code portfolio
- 📊 Your progress tracker
- 🔗 Shareable with instructors and employers
- 🌟 A demonstration of your learning journey

Keep it updated, organized, and professional!

Happy versioning! 🎉🧬

