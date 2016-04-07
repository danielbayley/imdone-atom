{$, $$, $$$, SelectListView} = require 'atom-space-pen-views'
{Emitter} = require 'atom'
util = require 'util'

module.exports =
class ProductSelectionView extends SelectListView
  initialize: ->
    super
    @emitter = new Emitter

  setItems: (products) ->
    super(products)
    @selectProduct @getSelectedItem()

  updateItem: (item) ->
    for product, i in @items
      if product.name == item.name
        @items[i] = item
    selectedItem = @getSelectedItem()
    itemSelector = "li[data-name=#{selectedItem.name}]"
    @populateList()
    @selectItemView(@list.find itemSelector)
    @confirmSelection()

  selectProduct: (product) ->
    @confirmed product

  confirmed: (product) ->
    @emitter.emit 'product.selected', product

  viewForItem: (product) ->
    icon   = if product.enabled then 'icon-cloud-upload' else 'icon-sign-in'
    text   = if product.enabled then 'text-success' else 'text-info'

    $$ ->
      @li class:"integration-product", 'data-name': product.name, =>
        @div class:"pull-right icon #{icon} #{text}"
        @div =>
          @h4 product.name

  getFilterKey: -> 'name'

  cancel: ->
    console.log("cancelled")