Debounce = require 'debounce'

{ CompositeDisposable } = require 'atom'

class CursorManager
    constructor: (editor) ->
        @subscriptions = new CompositeDisposable()
               
        @editor = editor
        @highlight()

        debounceEvent = Debounce @highlight, 1, { immediate: true }

        @subscriptions.add @editor.onDidChangeCursorPosition (event) =>
            if event.newBufferPosition.row isnt event.oldBufferPosition.row
                debounceEvent()
        @subscriptions.add @editor.getBuffer().onDidChange (event) =>
            if event.newRange.start.column is 0
                debounceEvent()
            

    highlight: =>
        decoration.destroy() for decoration in @editor.getDecorations { class: 'cursor-line-current' }            

        curRow = @editor.getCursorBufferPosition().row
        markerRange = @editor.getBuffer().rangeForRow curRow, true

        gutterMarker = @editor.markBufferRange markerRange, { invalidate: 'surround' }
        lineMarker = @editor.markBufferRange markerRange, { invalidate: 'surround' }

        @editor.decorateMarker gutterMarker, { type: 'line-number', class: 'cursor-line-current' }
        if @editor.getBuffer().isRowBlank curRow
            @editor.decorateMarker lineMarker, { type: 'line', class: 'cursor-line-current' }
        else
            @editor.decorateMarker lineMarker, { type: 'highlight', class: 'cursor-line-current' }

    dispose: ->
        @subscriptions?.dispose()

module.exports = CursorManager