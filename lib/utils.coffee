class Utils
    @reloadStylesheets: ->
        atom.themes.reloadBaseStylesheets()
        for pack in atom.packages.getActivePackages() when pack.getType() is 'atom' and pack.getStylesheetPaths().length
            pack.reloadStylesheets()

        for theme in atom.themes.getActiveThemes()
            theme.reloadStylesheets()

        atom.notifications.addSuccess 'done!',
            detail: 'stylesheets reloaded'
            dismissable: yes

module.exports = Utils