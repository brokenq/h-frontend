angular.module 'services.project', ['ngResource', 'services.base']
.factory 'ProjectService', ($log, $resource, BaseService)->
  $log.log "project service init"
  class DecoProcessService
    constructor: ->
      @baseService = new BaseService()
      domain = @baseService.getDomain()
      @project = $resource "#{domain}/project/:projectId"

    getProject: (params, successCb, errorCb)->
      return if !successCb
      promise = @project.get( params ).$promise
      @baseService.deal promise, successCb, errorCb