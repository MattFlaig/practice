register_plugin 'get-by-json-interval', {
  handler: (args) ->
    $el = $(@)
    url = args.opts.url
    interval = args.opts.interval || 10000
    refresh = ->
      setTimeout ->
        return if $el.data('stopRefresh')
        get_by_json(url).done ->
          refresh()
      , interval
    refresh()
}
