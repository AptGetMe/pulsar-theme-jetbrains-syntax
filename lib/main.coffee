season = require 'season'
path = require 'path'

module.exports =
config:
    font:
        title: 'Code Font'
        description: 'Activates specially curiated font.'
        type: 'string'
        default: 'none'
        enum: [
            {value: 'none', description: 'use system font'}
            {value: 'jetbrains', description: 'use Jetbrains Mono font (credit to Jetbrains)'}
        ]
        radio: yes
        order: 1
    theme:
        title: 'Syntax Theme'
        description: 'Choose theme syntax highlighting.'
        type: 'string'
        default: 'light'
        enum: [
            {value: 'light', description: 'Jetbrains light'}
            {value: 'dark', description: 'Jetbrains Dark'}
            {value: 'darcula', description: 'Jetbrains Darcula'}
        ]
        radio: yes
        order: 2
    palette:
        title: 'Color Palette'
        description: 'Specific palette of colors for the currently selected theme.'
        type: 'object'
        properties: do ->
            try
                cson = path.join(__dirname, 'themes.cson')
                themes = season.readFileSync cson
                Object.fromEntries(
                    for own name, color of themes.jetbrains_light
                        [name, title: name, type: 'color', default: color]
                )
            catch err
                atom.notifications.addError 'error reading or parsing theme cson file while generating config',
                    detail: err.message,
                    dismissable: yes
        order: 3

activate: (state) ->
    console.log 'activating'

deactivate: ->
    console.log 'deactivating'