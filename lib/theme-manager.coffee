Season = require 'season'
Path = require 'path'

class ThemeManager
    constructor: (name) ->
        try
            @cson = Path.join(__dirname, 'themes.cson')
            @themes = Season.readFileSync @cson
        catch err
            atom.notifications.addError 'error reading or parsing theme cson file while generating config',
                detail: err.message,
                dismissable: yes        
    
        @curTheme = switch name
            when 'light' then @themes.jetbrains_light
            when 'dark' then @themes.jetbrains_dark
            when 'darcula' then @themes.jetbrain_darcula
            else atom.notifications.addError 'unknown theme',
                detail: name,
                dismissable: yes

    get: ->
        @curTheme
    set: (name) ->
        @curTheme = switch name
            when 'light' then @themes.jetbrains_light
            when 'dark' then @themes.jetbrains_dark
            when 'darcula' then @themes.jetbrain_darcula
            else atom.notifications.addError 'unknown theme',
                detail: name,
                dismissable: yes
                
module.exports = ThemeManager