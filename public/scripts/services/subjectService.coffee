angular.module 'services.subject', ['ngResource', 'services.base']
.factory 'SubjectService', ($log, $resource, BaseService)->
  $log.log "subject service init"
  class DecoProcessService
    constructor: ->
      @baseService = new BaseService()
      domain = @baseService.getDomain()
      @subject = $resource "#{domain}/subject/:subjectId"
      @commentCountService = $resource "#{domain}/subject/:subjectId/commentCount"
      @commentMoreService = $resource "#{domain}/subject/:subjectId/comment"

    getSubject: (params, successCb, errorCb)->
      return if !successCb
      promise = @subject.get( params ).$promise
      @baseService.deal promise, successCb, errorCb

    getCommentCount: (params, successCb, errorCb)->
      return if !successCb
      promise = @commentCountService.get( params ).$promise
      @baseService.deal promise, successCb, errorCb

    getComments: (params, successCb, errorCb)->
      return if !successCb
      promise = @commentMoreService.get( params ).$promise
      @baseService.deal promise, successCb, errorCb
