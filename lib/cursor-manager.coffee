class CursorManager
    constructor: (editor) ->
        @editor = editor
        @highlight editor.getCursorBufferPosition()

    highlight: (cursorPos) ->
        if @editor.getBuffer().isDestroyed()
            return
        @marker?.destroy()

        @marker = @editor.markBufferRange [cursorPos, cursorPos]
        @editor.decorateMarker @marker, { type: 'line-number', class: 'cursor-line-current' }

module.exports = CursorManager