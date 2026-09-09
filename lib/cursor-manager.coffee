Debounce = require 'debounce'

{ CompositeDisposable } = require 'atom'

class CursorManager
    constructor: (editor) ->
        @subscriptions = new CompositeDisposable()
               
        @editor = editor
        @highlight()

        debounceEvent = Debounce @highlight, 1, { immediate: true }

        @subscriptions.add @editor.onDidChangeCursorPosition debounceEvent
        @subscriptions.add @editor.onDidChange debounceEvent

    highlight: =>
        decoration.destroy() for decoration in @editor.getDecorations { class: 'cursor-line-current' }            

        curRow = @editor.getCursorBufferPosition().row
        markerRange = @editor.getBuffer().rangeForRow curRow, true

        gutterMarker = @editor.markBufferRange markerRange
        lineMarker = @editor.markBufferRange markerRange

        @editor.decorateMarker gutterMarker, { type: 'line-number', class: 'cursor-line-current' }
        if @editor.getBuffer().isRowBlank curRow
            @editor.decorateMarker lineMarker, { type: 'line', class: 'cursor-line-current' }
        else
            @editor.decorateMarker lineMarker, { type: 'highlight', class: 'cursor-line-current' }

    dispose: ->
        @subscriptions?.dispose()

module.exports = CursorManager