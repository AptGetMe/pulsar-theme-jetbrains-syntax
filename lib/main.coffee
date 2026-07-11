{ CompositeDisposable } = require 'atom'
ThemeManager = require './theme-manager'

mgr = new ThemeManager('light')

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
            Object.fromEntries(
                for own name, color of mgr.get()
                    [name, title: name, type: 'color', default: color]
            )
        order: 3

activate: (state) ->
    console.log 'activating'

    @subscriptions = new CompositeDisposable()
    @subscriptions.add atom.config.onDidChange 'theme-jetbrains-syntax.theme', (event) ->
        mgr.set event.newValue

deactivate: ->
    console.log 'deactivating'

    @subscriptions?.dispose()