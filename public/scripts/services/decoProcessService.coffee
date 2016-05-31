angular.module 'services.decoProcess', ['ngResource', 'services.base']
.factory 'DecoProcessService', ($log, $resource, BaseService)->
  $log.log "decoProcess service init"
  class DecoProcessService
    constructor: ->
      @baseService = new BaseService()
      domain = @baseService.getDomain()
      @decoProcess = $resource "#{domain}/decoProcess/:decoProcessId"

    getDecoProcesses: (params, successCb, errorCb)->
      return if !successCb
      promise = @decoProcess.get( params ).$promise
      @baseService.deal promise, successCb, errorCb