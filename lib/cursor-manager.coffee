class CursorManager
    constructor: (editor) ->
        @editor = editor
        @highlight editor.getCursorBufferPosition()

    highlight: (cursorPos) ->
        if @editor.getBuffer().isDestroyed()
            return
        @gutterMarker?.destroy()
        @lineMarker?.destroy()

        @gutterMarker = @editor.markBufferRange [cursorPos, cursorPos]
        @editor.decorateMarker @gutterMarker, { type: 'line-number', class: 'cursor-line-current' }

        @lineMarker = @editor.markBufferRange [[cursorPos.row, 0], [cursorPos.row + 1, 0]]
        @editor.decorateMarker @lineMarker, { type: 'highlight', class: 'cursor-line-current' }

module.exports = CursorManager