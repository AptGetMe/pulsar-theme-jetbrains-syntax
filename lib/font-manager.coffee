class FontManager
    constructor: ->
        curFont = atom.config.get 'theme-jetbrains-syntax.font'
        if curFont == 'jetbrains'
            @load()

    load: ->
        workspace = document.querySelector('atom-workspace')

        workspace.style.setProperty('--editor-font-family', 'JetBrainsMono');
        workspace.style.setProperty('--editor-font-size', 'small');
        workspace.style.setProperty('--editor-line-height', '22px');

    unload: ->
        workspace = document.querySelector('atom-workspace')

        workspace.style.removeProperty('--editor-font-family');
        workspace.style.removeProperty('--editor-font-size');
        workspace.style.removeProperty('--editor-line-height');

module.exports = FontManager