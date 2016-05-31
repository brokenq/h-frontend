angular.module 'services.discuss', []
.factory 'DiscussService', ($log, $resource, BaseService)->
  $log.log "discuss service init"
  class DecoProcessService
    constructor: ->
      @baseService = new BaseService()
      domain = @baseService.getDomain()
      @discuss = $resource "#{domain}/discuss/:discussId"
      @discussComment = $resource "#{domain}/discuss/:discussId/comment"
      @discussCommentCount = $resource "#{domain}/discuss/:discussId/commentCount"

    getDiscuss: (params, successCb, errorCb)->
      return if !successCb
      promise = @discuss.get( params ).$promise
      @baseService.deal promise, successCb, errorCb

    getDiscussComment: (params, successCb, errorCb)->
      return if !successCb
      promise = @discussComment.get( params ).$promise
      @baseService.deal promise, successCb, errorCb

    getDiscussCommentCount: (params, successCb, errorCb)->
      return if !successCb
      promise = @discussCommentCount.get( params ).$promise
      @baseService.deal promise, successCb, errorCb