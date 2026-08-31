Path = require 'path'
Season = require 'season'

{ CompositeDisposable } = require 'atom'

ThemeManager = require './theme-manager'
FontManager = require './font-manager'
CursorManager = require './cursor-manager'

module.exports =
config:
    font:
        title: 'JetBrains Mono Font  (credit: Jetbrains)'
        description: 'Activate specially curiated **JetBrains Mono** font for code editing panel.  Note that this will disable font options in the general editor settings: ```Default Font Size``` ```Font Family``` ```Font Size```'
        type: 'boolean'
        default: 'false'
        order: 1
    theme:
        title: 'Syntax Theme'
        description: 'Choose a syntax highlighting theme for the code editing panel.'
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
        description: 'Show the specific palette of colors that is used by the currently selected theme.  If you don\'t like a theme\'s default color for a syntax rule, you can alter an individual color to suit your particular taste.  😋'
        type: 'object'
        properties: do ->
            Object.fromEntries(
                for own name, color of ThemeManager.get().jetbrains_light
                    [name, title: name, type: 'color', default: color]
            )
        collapsed: true
        order: 3

subscriptions: null
themeMgr: null
fontMgr: null
cursorMgr: null

activate: (state) ->
    console.log 'activating'

    @subscriptions = new CompositeDisposable()
    @themeMgr = new ThemeManager()
    @fontMgr = new FontManager()
    
    menus = Season.readFileSync Path.join __dirname, '..', 'menus', 'menu.cson'
    atom.menu.add menus['menu']
    atom.contextMenu.add menus['context-menu']
    atom.keymaps.loadKeymap Path.join __dirname, '..', 'keymaps', 'keymap.cson'

    @subscriptions.add atom.workspace.observeActiveTextEditor (editor) => 
        if editor
            @cursorMgr?.dispose()
            @cursorMgr = new CursorManager editor

    @subscriptions.add atom.config.onDidChange 'theme-jetbrains-syntax.theme', (event) =>
        @themeMgr.set event.newValue
    @subscriptions.add atom.config.onDidChange 'theme-jetbrains-syntax.palette', (event) =>
        @themeMgr.refresh event.newValue
    @subscriptions.add atom.config.onDidChange 'theme-jetbrains-syntax.font', (event) =>
        if event.newValue then @fontMgr.load() else @fontMgr.unload()

    @subscriptions.add atom.commands.add 'atom-text-editor', 'theme-jetbrains-syntax:reset': =>
        @themeMgr.reset()

deactivate: ->
    console.log 'deactivating'

    @fontMgr.unload()
    @cursorMgr?.dispose()

    @subscriptions?.dispose()