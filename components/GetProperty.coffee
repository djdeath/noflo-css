noflo = require 'noflo'

class GetProperty extends noflo.Component
  description: 'Get a CSS property of a DOM element'
  constructor: ->
    @element = @property = null
    @inPorts =
      in: new noflo.Port 'bang'
      element: new noflo.Port 'object'
      property: new noflo.Port 'string'
    @outPorts =
      out: new noflo.Port 'object'

    @inPorts.element.on 'data', (element) =>
      @element = element
    @inPorts.property.on 'data', (property) =>
      @property = property
    @inPorts.in.on 'data', () =>
      return unless @element and @property
      return unless @outPorts.out.isAttached()
      @outPorts.out.send(@element.style[@property])
      @outPorts.out.disconnect()

exports.getComponent = -> new GetProperty
