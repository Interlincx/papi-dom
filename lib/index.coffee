
rainbow = require 'rainbow-load'


module.exports = PapiDom = (opts={}) ->
  return this


PapiDom::loadWrap = (args, cb) ->
  rainbow.config
    barThickness: 5
    barColors:
      0: "rgba(0,  0, 0, .7)"
    shadowColor  : 'rgba(0, 0, 0, 0)'

  rainbow.show()

  @[args['function']](args.args), (err, result) ->
    rainbow.hide()
    cb(err, result)


PapiDom::adpagePieceSelect = (callback, params, e) ->
  if typeof params.selected_id == 'undefined'
    params.selected_id = ''
  pass = {}

  if params.type is 'account'
    what = 'accounts'
    item_label = 'company_name'
    item_id_handle = 'account_id'
    title = 'Pick an Account'
  if params.type is 'creative_instance'
    what = 'creative_instances'
    item_label = 'creative_instance_name'
    item_id_handle = 'creative_instance_id'
    title = 'Pick a Creative Instance'
  if params.type is 'decision_tree'
    what = 'decision_trees'
    item_label = 'decision_tree_name'
    item_id_handle = 'decision_tree_id'
    title = 'Pick a Decision Tree'
  if params.type is 'ad_feed'
    what = 'feeds'
    item_label = 'feed_title'
    item_id_handle = 'ad_feed_id'
    title = 'Pick a Feed'
  if params.type is 'ad'
    what = 'ads'
    item_label = 'ad_name'
    item_id_handle = 'ad_id'
    title = 'Pick an Ad'

  options =
    item_label: item_label
    item_id_handle: item_id_handle
    selected_id: params.selected_id
    title: title
    original_event: e

  _this = @
  @listModal.createModal options, (err) ->
    _this.get what, pass, (err, results) ->
      _this.listModal.populateModal(results, callback, params, e)




PapiDom::formification = require './formify.coffee'
PapiDom::formify = (attrs, input, value, class_name) ->
  return @formification.init(attrs, input, value, class_name)

PapiDom::printForm = require './print_form.coffee'

PapiDom::listModal = require './modal.coffee'

