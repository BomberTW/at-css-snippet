AtCssSnippetView = require './at-css-snippet-view'
{CompositeDisposable} = require 'atom'

module.exports = AtCssSnippet =
  atCssSnippetView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atCssSnippetView = new AtCssSnippetView(state.atCssSnippetViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atCssSnippetView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'at-css-snippet:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atCssSnippetView.destroy()

  serialize: ->
    atCssSnippetViewState: @atCssSnippetView.serialize()

  toggle: ->
    console.log 'AtCssSnippet was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
