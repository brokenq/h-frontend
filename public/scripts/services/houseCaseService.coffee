angular.module 'services.houseCase', ['ngResource', 'services.base']
.factory 'HouseCaseService', ($log, $resource, BaseService)->
  $log.log "houseCase service init"
  class HouseCaseService
    constructor: ->
      @baseService = new BaseService()
      domain = @baseService.getDomain()
      @houseCaseService = $resource "#{domain}/houseCase/:houseCaseId"
      @houseCaseCommentCountService = $resource "#{domain}/houseCase/:houseCaseId/commentCount"
      @houseCaseCommentMoreService = $resource "#{domain}/houseCase/:houseCaseId/comment"
      @houseCaseImageService = $resource "#{domain}/houseCaseImage/:houseCaseImageId"

    getHouseCase: (params, successCb, errorCb)->
      return if !successCb
      promise = @houseCaseService.get( params ).$promise
      @baseService.deal promise, successCb, errorCb

    getHouseCaseCommentCount: (params, successCb, errorCb)->
      return if !successCb
      promise = @houseCaseCommentCountService.get( params ).$promise
      @baseService.deal promise, successCb, errorCb

    getHouseCaseComment: (params, successCb, errorCb)->
      return if !successCb
      promise = @houseCaseCommentMoreService.get( params ).$promise
      @baseService.deal promise, successCb, errorCb

    getHouseCaseImage: (params, successCb, errorCb)->
      return if !successCb
      promise = @houseCaseImageService.get( params ).$promise
      @baseService.deal promise, successCb, errorCb

