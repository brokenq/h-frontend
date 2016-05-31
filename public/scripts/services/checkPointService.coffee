angular.module 'services.checkPoint', ['ngResource', 'services.base']
.factory 'CheckPointService', ($log, $resource, BaseService)->
  $log.log "checkPoint service init"
  class DecoProcessService
    constructor: ->
      @baseService = new BaseService()
      domain = @baseService.getDomain()
      @checkPoint = $resource "#{domain}/checkPoint/:checkPointId/report"
      @snapshotService = $resource "#{domain}/checkPoint/snapshot/:snapshotId"

    getCheckPoint: (params, successCb, errorCb)->
      return if !successCb
      promise = @checkPoint.get( params ).$promise
      @baseService.deal promise, successCb, errorCb

    getCheckPointSnapshot: (params, successCb, errorCb)->
      return if !successCb
      promise = @snapshotService.get( params ).$promise
      @baseService.deal promise, successCb, errorCb