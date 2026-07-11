Season = require 'season'
Path = require 'path'
Fs = require 'fs'

class ThemeManager
    constructor: (name) ->
        try
            cson = Path.join(__dirname, 'themes.cson')
            @themes = Season.readFileSync cson
        catch err
            atom.notifications.addError 'error reading or parsing theme cson file while generating config',
                detail: err.message,
                dismissable: yes        
        @curTheme = switch name
            when 'light' then @themes.jetbrains_light
            when 'dark' then @themes.jetbrains_dark
            when 'darcula' then @themes.jetbrains_darcula
            else atom.notifications.addError 'unknown theme',
                detail: name,
                dismissable: yes
        @colorStylesheet = Path.join(__dirname, '..', 'styles', 'colors.less')

    get: ->
        @curTheme
    
    set: (name) ->
        @curTheme = switch name
            when 'light' then @themes.jetbrains_light
            when 'dark' then @themes.jetbrains_dark
            when 'darcula' then @themes.jetbrains_darcula
            else atom.notifications.addError 'unknown theme',
                detail: name,
                dismissable: yes
        atom.config.set 'theme-jetbrains-syntax.palette', @curTheme
    
    refresh: (palette) ->
        less = ("@#{name}: #{color.toHexString()};" for name, color of palette).join '\n'
        
        try
            Fs.appendFileSync @colorStylesheet, less, 'utf8'
        catch err
            atom.notifications.addError 'error writing new less stylesheet file',
                detail: err.message,
                dismissable: yes

        atom.themes.reloadBaseStylesheets()
        for pack in atom.packages.getActivePackages()
            pack.reloadStylesheets()

        for theme in atom.themes.getActiveThemes()
            theme.reloadStylesheets()

module.exports = ThemeManager