Utils = require './utils'

class FontManager
    constructor: ->
        curFont = atom.config.get 'theme-jetbrains-syntax.font'
        if curFont == 'jetbrains'
            workspace = document.querySelector('atom-workspace')

            workspace.style.setProperty('--editor-font-family', 'JetBrainsMono');
            workspace.style.setProperty('--editor-font-size', 'small');
            workspace.style.setProperty('--editor-line-height', '1.4');

    load: ->
        workspace = document.querySelector('atom-workspace')

        workspace.style.setProperty('--editor-font-family', 'JetBrainsMono');
        workspace.style.setProperty('--editor-font-size', 'small');
        workspace.style.setProperty('--editor-line-height', '1.4');

        setTimeout ->
            Utils.reloadStylesheets()
        , 100
        atom.notifications.addInfo 'refreshing',
            detail: 'please be patient...'
            dismissable: yes

    unload: ->
        workspace = document.querySelector('atom-workspace')

        workspace.style.removeProperty('--editor-font-family');
        workspace.style.removeProperty('--editor-font-size');
        workspace.style.removeProperty('--editor-line-height');

        setTimeout ->
            Utils.reloadStylesheets()
        , 100
        atom.notifications.addInfo 'refreshing',
            detail: 'please be patient...'
            dismissable: yes

module.exports = FontManager