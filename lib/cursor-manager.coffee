{ CompositeDisposable } = require 'atom'

class CursorManager
    constructor: (editor) ->
        @subscriptions = new CompositeDisposable()
               
        @editor = editor
        @highlight @editor.getCursorBufferPosition()

        @subscriptions.add @editor.onDidChangeCursorPosition (event) => 
            @highlight event.newBufferPosition, event.oldBufferPosition

    highlight: (cursorPos, cursorPosPrev) ->
        if @editor.getBuffer().isDestroyed()
            return
        if cursorPos.row is cursorPosPrev?.row
            return

        decoration.destroy() for decoration in @editor.getDecorations { class: 'cursor-line-current' }            

        markerRange = @editor.getBuffer().rangeForRow cursorPos.row, true

        gutterMarker = @editor.markBufferRange markerRange
        @editor.decorateMarker gutterMarker, { type: 'line-number', class: 'cursor-line-current' }

        lineMarker = @editor.markBufferRange markerRange
        @editor.decorateMarker lineMarker, { type: 'highlight', class: 'cursor-line-current' }

    dispose: ->
        @subscriptions?.dispose()

module.exports = CursorManager