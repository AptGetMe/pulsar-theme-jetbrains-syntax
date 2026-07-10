module.exports =
config:
    font:
        title: 'Enable Theme Font'
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
        description: 'Choose syntax highlighting.'
        type: 'string'
        default: 'light'
        enum: [
            {value: 'light', description: 'Jetbrains light'}
            {value: 'dark', description: 'Jetbrains Dark'}
            {value: 'darcula', description: 'Jetbrains Darcula'}
        ]
        radio: yes
        order: 2

activate: (state) ->
    console.log 'activating'

deactivate: ->
    console.log 'deactivating'