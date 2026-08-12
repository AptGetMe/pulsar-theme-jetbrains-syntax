# Contributing Guide

Thanks for wanting to help! 🤗  Hopefully, this guide will get you up to speed.

## Prerequisite

It might be a good idea to uninstall Theme Jetbrains if you had it installed the normal way, so you don't have 2 version conflicting!

## Dev install

- Clone github repository  ```git clone https://github.com/AptGetMe/pulsar-theme-jetbrains-syntax.git```
- Move into project folder  ```cd pulsar-theme-jetbrains-syntax```
- Install packages  ```npm install```
- Create link so Pulsar know Theme Jetbrains exists  ```pulsar -p link -d .```
- Open Pulsar in dev mode to see *Theme Jetbrains* option in Settings -> Themes  ```pulsar --dev .```

Code away! 🥳  Anytime you want to begin a new coding session, all you have to run is the last command above ```pulsar --dev .``` from the cloned repo project root.

## Dev Workflow

You can code from the devopment window if you want to.  \
However, it may help to use 2 pulsar instances when working on the theme [side by side](https://docs.pulsar-edit.dev/developing-for-pulsar/developing-a-theme/#side-by-side).  One should be opened normally and is where you make all code changes.  The other should be opened in dev mode from the project folder and is where you can test changes.  \
Or you could have the dev window open and make code changes from a different code editor.

Use the dev tools so you can see syntax code class names, which is how Less rules know what to style.  Go to ```View -> Developer -> Toggle Developer Tools``` or use the hotkey ```ctrl-shift-i``` to bring it up.

Use the hotkey ```ctrl-shift-f5``` to refresh the entire app to reload package after making changes.

## Basic Overview

1. **main.coffee** is the entry point when the theme is activated.  \
The first thing done is to spin up a ```themeManager``` object.  Then, creates the config settings and binds keys and actions when settings are changed.  

2. **themeManager.coffee** handles all theme details  \
It reads the ```themes.cson``` theme file and stores the correct theme.  It provides getters and setters the config settings and actions are made correctly and stay in sync.  It writes the theme colors to the ```colors.less``` file dynamically so the syntax highlighting changes when settings are changed, and automatically refreshes Less code when necessary.

3. **main.less** is where all the Less styles and variable are included.

4. **colors.less** is automatically generated with the current theme colors.  

## Folders Structure

- lib folder  \
main coffeescript code that runs the package, and head Less stylesheet code.  

- test folder  \
sample code files in different languages to test the syntax highlighting against

- style folder  \
Less styling rules and variables

## Pull Request

It'd be a good idea to create an issue first before spending time on a pull request, especially if your idea is not on the roadmap.
Please make sure to follow the [AI policy guidelines!](./README.md#Ai-Policy)  I'd really appreciate your understanding.  
