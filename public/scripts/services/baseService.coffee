angular.module 'services.base', ['lib.constants']
.factory 'BaseService', ($log, $q, Constants)->
  $log.log "base service init"
  class BaseService
    constructor: ->
      constants = new Constants()
      @domain = constants.DOMAIN

    getDomain: -> @domain

    deal: (promise, successCb, errorCb)->
      return if !promise or !successCb
      promise.then (response)->
        successCb(response)
      , (response)->
        return errorCb(response) if errorCb
        return $q.reject response

