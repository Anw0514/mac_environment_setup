# mac_environment_setup

### Prerequisites

Before you begin, you'll need to have [iterm2](https://iterm2.com/downloads.html) and 
[VSCode](https://code.visualstudio.com/download) downloaded onto your computer. If you don't 
like those two for whatever reason, there are alternatives. Instead of iterm2, you can use any 
mac terminal that allows you to use bash and instead of VS Code, you can use any text editor 
(some popular alternatives are sublime and atom). This is just what I use so it's what I'm 
most comfortable with.

> ***IMPORTANT:*** make sure that **iTerm2** has full disk access. To do this, open System
> Preferences, click on `Security & Privacy` -> `Full Disk Access` and make sure that the
> checkbox for iTerm2 is checked.

### Step 0 - Set Up Default Shell

Right now the default Terminal shell for iTerm2 is zsh, but I'm more familiar with bash so to 
make sure everything is consistent and we don't run into any unexpected errors, we want to change 
the default to be bash. If you don't know what I'm talking about, don't worry. Just open 
**iTerm2** and run the following command:
```sh
chsh -s /bin/bash
```
Close your terminal and reopen. If you run `echo $SHELL`, the terminal should
output `/bin/bash`.

> **Note:** if at any point you want to switch to using zsh, you can run the same command, but instead 
> of `/bin/bash` you'd type `/bin/zsh`.

Next, you'll want to make sure you have a bash_profile in your home directory. If you want to 
use the one I've created, just copy the contents of `.bash_profile` (in this repo) and run the 
following commands:
```sh
touch .bash_profile
open .bash_profile
```

This should open a file in TextEdit. Paste the contents you copied from my profile into there and
save with `Cmd`+`S`. Lastly, run `source ~/.bash_profile` in your terminal. A table showing a list
of available commands should appear, but don't mess with any of those yet because some won't work until
we've finished the installation process.

### Step 1 - Set up VS Code & Bash Profile

launch Visual Stuido Code and type `command(⌘) + shift(⇧) + p`, and your **Command Palette** 
will open. In your **Command Palette**, type `>shell command`. Select "Shell Command: Install
'code' command in PATH"

![VS Code Add to Path](https://curriculum-content.s3.amazonaws.com/onboarding/vscode%20path.png)

VS Code has a lot of extensions available to make your life easier as you code. Here are some that I
recommend installing:
* `ESLint` and/or `Prettier` (to format your code)
* `Visual Studio Intellicode` (for some easy auto-completion)
* `Path Intellisense` (for path completion)
* `Auto Rename Tag` and `Auto Close Tag` (for html)
* `Color Highlight` and/or `Color Picker` (for css)
* `ruby-rubocop` (to format ruby code)
* `JS JSX Snippets` (snippets for javascript and react)
* `Material Icon Theme` (icons to easily distinguish file and folder types)

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

### Step 3 - GMP and GnuPG Packages

Before continuing further, we need to install some libraries that other tools
rely on, [GMP][] and [GnuPG][]:

```sh
brew install gmp
brew install gnupg
```

> **Note:** If you get this error: `Warning: gnupg-1.4.19 already installed`,
> GnuPG is installed, but it may not be linked properly. To fix, run:
>
> ```sh
> brew link gnupg
> ```

### Step 3 - Git

We use Homebrew to install git too. Run the following command:
```sh
brew install git
```
To make sure that git is installed you can run `git version` and it should 
come back with a number. To configure git to recognize you as the user, run:

```sh
git config --global user.name "your-github-username"
git config --global user.email "your_email@example.com"
```

Next we need to get github to recognize your computer. In order to do this, run:
```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```
When you're prompted to "Enter a file in which to save the key," press Enter. 
This accepts the default file location. It will also prompt you to create a 
passphrase. It's up to you whether you want one or not. Next, you want to 
[add the ssh key to your github](https://docs.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account)

### Step 4 - RVM & Ruby

RVM is a tool that lets you run different versions of Ruby on your computer.
If one project you're working on works with Ruby version 2.3.3 and another needs
2.6.1, you can easily switch between the two versions when you switch between
projects.

The following command downloads encryption keys we need to install RVM:

```sh
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

> **Note:** If that command does not work, or you receive an error stating 
> `keyserver receive failed: No route to host`, try running the following commands:
> 
> ```sh
> command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
> ```
> 
> ```sh
> command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
> ```

Once the encryption keys are downloaded, use the following command to download RVM:

```sh
curl -sSL https://get.rvm.io | bash
```

When RVM is installed, close and reopen your terminal to make sure RVM is fully
loaded. Next, we will install the Ruby version we'll be using and set it as the default:

```sh
rvm install 2.6.1
rvm use 2.6.1 --default
```

To check that everything worked, run `rvm list`. You should see `=* ruby-2.6.1`
listed, indicating that `2.6.1` is installed and set as the default version for
Ruby. You can also run `ruby -v`, which should show that Ruby `2.6.1` is the
current version of Ruby being used.

### Step 5 - Gems

Ruby makes use of packages called 'gems'. There are a few that I recommend installing now.
* First, let's update our system gems by running `gem update --system`
* Install the Bundler gem with `gem install bundler`. This gem takes care of
  installing other gems you will need for projects.
* Install Nokogiri with `gem install nokogiri` - Nokogiri is a gem to help parse
  HTML - useful when we want to scrape websites.
* Install Pry with `gem install pry`. Pry is a ruby console used for debugging.
* Install rspec with `gem install rspec`. Rspec is a testing library, specific to ruby.
* Install Ruby on Rails with `gem install rails` 
* Some others worth looking into and installing are `rake`, `git`, `jasmine`, `netrc`, `oj`, 
  `crack`, and `faraday`

> ***Note:*** If you are using my `.bash_profile`, I've included a function that will
> easily install all of these gems for you. All you need to do after running 
> `gem update --system`is run `initialgems` and you'll be set.

### Step 6 - Database stuff

If you're gonna work with databases, I suggest running the following commands.

To install Sqlite:
```sh
brew install sqlite
```
To install Postgres:
```sh
brew install postgres
brew services start postgresql
gem install pg
```

### Step 7 - NVM & Node
To manage different versions of Node installed on our computer, we can use JavaScript's 
equivalent of RVM - NVM. Let's get your Node Version Manager installed. Run the following 
in your terminal:

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
```
