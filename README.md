# mac_environment_setup

### Prerequisites
Before you begin, you'll need to have [iterm2](https://iterm2.com/downloads.html) and [VSCode](https://code.visualstudio.com/download) downloaded onto your computer. If you don't like those two for whatever reason, there are alternatives. Instead of iterm2, you can use any mac terminal that allows you to use bash and instead of VS Code, you can use any text editor (some popular alternatives are sublime and atom). This is just what I use so it's what I'm most comfortable with.

### Step 1 - XCode command line tools
Open up iterm2 and run the following command:
```sh
xcode-select --install
```

You will be prompted to install Xcode Command-Line Tools. Agree and allow the
install to continue. You may need to provide your computer's password. 

> **Note:** If the Xcode Command-Line Tools aren't installed, you may encounter
> errors later on when working with gems like `sqlite3`. To double check that everything is installed,
> rerun the `xcode-select --install` command. If everything is installed, you should see this error:
>
> ```sh
> xcode-select: error: command line tools are already installed, use "Software Update" to install updates
> ```
>
> If you receive this error, you are good to continue!

### Step 2 - Homebrew

Homebrew is a package manager for the Mac. It allows us to install a number
of things we will need. To install Homebrew, run the following:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

> **Note:** this is all one line in the terminal (even if it is broken up into
> two lines here in your browser).

You can verify that Homebrew is successfully installed by running `brew help`. If
your terminal outputs a list of `brew` commands, you're all set.

### Step 3 - 
