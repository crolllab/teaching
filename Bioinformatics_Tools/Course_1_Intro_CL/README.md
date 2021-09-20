### Bioinformatics Tools


# Course 1: Introduction to the command line or a "shell"


### Major aims  

- Have a basic understanding how to interact with a command line interface
- Know how to use common utilities to navigate, search and edit folders and files

## Using RStudio Server to access the server "shell"  

- Connect to RStudio Server following the instructions on the general course page (on level up).
- Locate at the bottom left the tab "Terminal".
- The content of the tab contains the "welcome" message by the server. This can be very different between servers/computers.
- You are now using a bash shell (Bourne Again SHell). If you want to know details, check out the [Wiki](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) page. bash specifies a very simple programming language. Other shell
- There other other types of shell languages including zsh, etc.

## What is a shell good for?  

- Put simply, a shell helps you to interact with a computer/server without a graphical interface (where you could click on icons, move things around, etc.)
- A shell requires you to type commands. If you are familiar with R, you know exactly how this can look like. Our shell here simply uses a different language to interact compared to R.
- A shell helps you also navigate files and folders. We'll need to tell the shell though to move "up" or "down" the hierarchy of folders to get around.
- Finally, for bioinformatics a shell helps you to repeat analyses, run these in loops, download and copy large files automatically, summarize information, etc. In other words, if you have code that works, running analyses becomes nearly effortless. Writing the code in the first place can be a different matter! :-)

## First steps in a shell

- Create a shell script file to record what you will do. RStudio => File => New File => Shell Script. Save it.
- You see that the script file gets some automatic coloring (e.g. # comment lines)

![](./images/terminal.png)  

- Use now always the "Terminal" at the bottom. Not the "Console", this is for R only!

Type now the command shown above and press Enter. You see that the code above is actually composed of a little "program" called `echo` and some text to use ("Hello world"). `echo` simply writes you this text out. Try it with some other text.

### Tips to save you time
- You can decide to write all code in the script file and execute the commands below by selecting a particular line (or multiple lines) of script code. Then copy-paste below. Press Enter.
- Even better, you can select the line(s) and press CMD and ENTER (on a Mac keyboard) or CTRL and ENTER (on a Windows keyboard). This will immediately run the code without copy-pasting.
- If you decide to write code directly in the Terminal, use the auto-complete function. So, to use the `echo` command, start by typing `ec` and then press the TAB key twice quickly. You see that there are `echo ecitmatch econtact` as commands starting with `ec`. Type now `h` to have the word `ech` in the Terminal. Press the TAB key twice again and you will see that the `ech` was completed to `echo`. You can use this for any command. Once a command is complete in the Terminal, press ENTER.


## Simple programs to use in a shell

- You are now connected to a computer running a specific operating system called [CentOS](https://en.wikipedia.org/wiki/CentOS). This is a variant of Linux just as Ubuntu, Fedora, etc. Most commands you'd find for any Linux operating system should work here too. Hence, it should be easy to google things!

We will now explore a series of very simple commands.

### The `pwd` command

"Present working directory" - This tells you the "path" where you are currently. `/home/daniel` means that I am in a folder called `home` placed at the top of the folder hierarchy. This is the `/`. Inside `home`, there is a folder with my name `daniel`.

This command is very useful to see where you are in case you get lost.

### The `mkdir` command

"Make directory" - This does exactly this. Use this to create a directory called `my_first_scripts` by issuing the command `mkdir my_first_scripts`.

Tip: Avoid using spaces in names. It is not forbidden but inconvenient. Use `_` instead.

### The `ls` command

"List" - This command provides you with a list of files and folders in your current directory. Use the command to see whether your newly created folder exists.

### The `cd` command

"Change directory" - Allows you to change to a different directory. Start an example like this:
```
# this checks where you are, you should be here /home/username
pwd
# check that your new folder exists. Do you see "my_first_scripts"?
ls

# change to your new directory
cd my_first_scripts

# use pwd to verify your new location
pwd

# to go back one level (go "up" in the hierarchy)
cd ..

# go to your home directory /home/username
cd

# go can also go deeper in a single command at once
cd /folder1/subfolder/subsubfolder
# the above will not work unless the folders actually exist!
```

Q1: Briefly describe what the following command options are doing. Google the answer if you are unsure.

```
# start with going to your home directory
cd

# the commands to check out
ls -l  
ls -s  
ls -a
ls -h
ls -lsh # this is a combination of options!
ls -R

# use Google to find what  mkdir options exist, mention at least one in your answer
```

### The `echo` command

As we have seen above, you can simply write some text to be displayed.
`echo "Hello world"`

The output is written by default into the Terminal, but we can modify this using the `>` sign.

This command here will write the same text to a new text file.
`echo "Hello world" > new_file.txt`

Use `ls` to check whether the new file was created.

PS: the `.txt` extension is not necessary. The computer creates a text file regardless. Extensions are used by Windows or macOS to launch the correct application (e.g. Word for `.docx`).

You can _add_ also text to an existing file using `>>`. So if you have created alreads `new_file.txt`, this will create a second line to this file.
`echo "Hello again!" >> new_file.txt`

### The `cat` command

How to know what the text file `new_file.txt` actually contains? Use `cat`:
`cat new_file.txt`

Do you see the expected text?

### The `head` and `tail` commands

These commands work like `cat` but show you only the first (`head`) or the last (`tail`) lines of the file. By default, the commands show the first or last 10 lines. You can change this behavior like this:

To show only the very first line:
`head -n 1 new_file.txt`

To show only the two very last lines:
`tail -n 2 new_file.txt`

Q2: Use the `echo "Hello again!" >> new_file.txt` command to add at least 10 lines to your `new_file.txt`. Use now only the `head` command to create a new file called `only_the_top3.txt` containing the first three lines of `new_file.txt`. Use `cat` to check that it is working.

### The `less` command

The `less` commands shows you the beginning of a large file and lets you scroll down using the arrow keys. Type `q` to get out if you are stuck.

### A very simple text editor called `nano`

`nano` is a miniature text editor that is accessible in the Terminal. You can create a new text file called `my_code.sh` like this:

`nano my_code.sh`

You have now entered the text editor. Type any text you like. Press Enter for a new line. The cursor helps you to move around. To save your file use the key combination CTRL and the letter "x". It will ask you to save the file yes/no. So, answer with "y" if you want to save it. It will then show you a line where you can accept the file name or provide a new one. Exit with ENTER.

Try out some of the other options offered by `nano`.

### Downloading a file from the web

The first step is find the correct link to a file. The link should typically end in a recognizable format (.txt, .html, .jpeg, .pdf, etc.).

Here's a the image of the UNINE MSc Biology page:

`wget https://www.unine.ch/files/live/sites/systemsite/files/bandeaux/FS/UNINE_FS_MA.jpg`

Check with `ls -lhs` whether you've actually saved the file.

### General troubleshooting tips
- We will look at a command called `cp`. Googling for "Linux cp" tells you already what to do
- Google the error message. Copy the error message and search for it. Helpful? Improve your code googling skills during the course.
