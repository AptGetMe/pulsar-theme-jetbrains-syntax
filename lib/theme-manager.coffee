Season = require 'season'
Path = require 'path'
Fs = require 'fs'

class ThemeManager
    constructor: (name) ->
        try
            cson = Path.join __dirname, 'themes.cson'
            @themes = Season.readFileSync cson
        catch err
            atom.notifications.addError 'error reading or parsing theme cson file while generating config',
                detail: err.message,
                dismissable: yes
        @curTheme = @find name
        @colorStylesheet = Path.join __dirname, '..', 'styles', 'colors.less'

    get: ->
        @curTheme

    set: (name) ->
        @curTheme = @find name
        atom.config.set 'theme-jetbrains-syntax.palette', @curTheme

    find: (name) ->
        switch name
            when 'light' then @themes.jetbrains_light
            when 'dark' then @themes.jetbrains_dark
            when 'darcula' then @themes.jetbrains_darcula
            else
                atom.notifications.addError 'unknown theme',
                    detail: name,
                    dismissable: yes
                name = null

    reset: ->
        atom.config.set 'theme-jetbrains-syntax.palette', @curTheme
    
    refresh: (palette) ->
        less = ("@#{name}: #{color.toHexString()};" for name, color of palette).join '\n'

        Fs.appendFile @colorStylesheet, less, 'utf8', (err) ->
            if err then atom.notifications.addError 'error writing new less stylesheet file',
                detail: err.message,
                dismissable: yes
            else
                setTimeout ->
                    atom.themes.reloadBaseStylesheets()
                    for pack in atom.packages.getActivePackages() when pack.getType() == 'atom' && pack.getStylesheetPaths().length
                        pack.reloadStylesheets()

                    for theme in atom.themes.getActiveThemes()
                        theme.reloadStylesheets()

                    atom.notifications.addSuccess 'done!',
                        detail: 'stylesheets reloaded'
                        dismissable: yes
                , 100

        atom.notifications.addInfo 'refreshing',
            detail: 'please be patient...'
            dismissable: yes

module.exports = ThemeManager