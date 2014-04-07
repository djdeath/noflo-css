noflo = require 'noflo'

class SetProperty extends noflo.Component
  description: 'Set a CSS property of a DOM element'
  constructor: ->
    @element = @property = null
    @inPorts =
      element: new noflo.Port 'object'
      property: new noflo.Port 'string'
      value: new noflo.Port 'string'

    @element = @property = @value = null

    @inPorts.element.on 'data', (element) =>
      @element = element
      @applyValue()
    @inPorts.property.on 'data', (property) =>
      @property = property
      @applyValue()
    @inPorts.value.on 'data', (value) =>
      @value = value
      @applyValue()

  applyValue: () ->
    return unless @element != null and @property != null and @value != null
    @element.style[@property] = @value
    @value = null

exports.getComponent = -> new SetProperty
