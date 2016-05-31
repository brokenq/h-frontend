angular.module 'services.houseCaseImage', ['ngResource', 'services.base']
.factory 'HouseCaseImageService', ($log, $resource, BaseService)->
  $log.log "houseCaseImage service init"
  class HouseCaseImageService
    constructor: ->
      @baseService = new BaseService()
      domain = @baseService.getDomain()
      @service = $resource "#{domain}/houseCaseImage/:houseCaseImageId"
      @commentCountService = $resource "#{domain}/houseCaseImage/:houseCaseImageId/commentCount"
      @commentMoreService = $resource "#{domain}/houseCaseImage/:houseCaseImageId/comment"

    get: (params, successCb, errorCb)->
      return if !successCb
      promise = @service.get( params ).$promise
      @baseService.deal promise, successCb, errorCb

    getCommentCount: (params, successCb, errorCb)->
      return if !successCb
      promise = @commentCountService.get( params ).$promise
      @baseService.deal promise, successCb, errorCb

    getComments: (params, successCb, errorCb)->
      return if !successCb
      promise = @commentMoreService.get( params ).$promise
      @baseService.deal promise, successCb, errorCb
