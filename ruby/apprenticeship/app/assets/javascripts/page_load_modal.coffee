register_plugin 'page-load-modal', {
  tag: '#page_load_modal'
  handler: (args) ->
    $(@).modal 'show'
}
