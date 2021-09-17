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
- Even better, you can select the line(s) and press CMD and ENTER. This will immediately run the code.
- If you decide to write code directly in the Terminal, use the auto-complete function. So, to use the `echo` command, start by typing `ec` and then press the TAB key twice quickly. You see that there are `echo ecitmatch econtact` as commands starting with `ec`. Type now `h` to have the word `ech` in the Terminal. Press the TAB key twice again and you will see that the `ech` was completed to `echo`. You can use this for any command. Once a command is complete in the Terminal, press ENTER.


## Simple programs to use in a shell

- You are now connected to a computer running a specific operating system called [CentOS](https://en.wikipedia.org/wiki/CentOS). This is a variant of Linux just as Ubuntu, Fedora, etc. Most commands you'd find for any Linux operating system should work here too. Hence, it should be easy to google things!

We will now explore a series of very simple commands.

### The command `pwd`

"Present working directory" - This tells you the "path" where you are currently. `/home/daniel` means that I am in a folder called `home` placed at the top of the folder hierarchy. This is the `/`. Inside `home`, there is a folder with my name `daniel`.

This command is very useful to see where you are in case you get lost.

### The command `mkdir`

"Make directory" - This does exactly this. Use this to create a directory called `my_first_scripts` by issuing the command `mkdir my_first_scripts`.

Tip: Avoid using spaces in names. It is not forbidden but inconvenient. Use `_` instead.

### The command `ls`

"List" - This command provides you with a list of files and folders in your current directory. Use the command to see whether your newly created folder exists.

### The command `cd`

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
```

Q1: Describe what the following commands are doing.


### Troubleshooting tips
- We will look at a command called `cp`. Googling for "Linux cp" tells you already what to do
- Google the error message. Copy the error message and search for it. Helpful? Improve your code googling skills during the course.
