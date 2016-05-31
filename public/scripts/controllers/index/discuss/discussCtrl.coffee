angular.module 'discuss', []
.controller 'DiscussIndexCtrl', ($log, $scope, IOSService, AndroidService, CommonService, UtilService, DiscussService)->
  $log.log "discuss index controller init"
  $scope.iosService = new IOSService()
  $scope.androidService = new AndroidService()
  $scope.discussService = new DiscussService()
  $scope.commonService = new CommonService()
  $scope.utilService = new UtilService()

.controller 'DiscussViewCtrl', ($log, $scope, $sce, $state, $stateParams, $location)->
  $log.log "discuss view controller init"
  iosService = $scope.iosService
  androidService = $scope.androidService
  commonService = $scope.commonService
  utilService = $scope.utilService
  discussService = $scope.discussService

  setIframe = ->
    $iframe = $('iframe')
    $iframe.height $iframe.width() * 9 / 16

  config = ->
    $scope.showDownload = true
    $scope.qiNiuUrl = commonService.getQiNiuUrl()
    $scope.innerApp = androidService.isMatch() or iosService.isMatch()
    setIframe()
    $(window).resize -> setIframe()

  load = ->
    discussService.getDiscuss "discussId": $stateParams.discussId, (response)->
      reg = new RegExp("\n", "g")
      response.content = emoji.unifiedToHTML response.content if utilService.isChrome()
      response.content4Show = $sce.trustAsHtml(response.content.replace(reg, "<br />"))
      $scope.discuss = response
    params =
      "discussId": $stateParams.discussId
      "pageSize": if $scope.innerApp then 20 else 7
    discussService.getDiscussComment params, (response)->
      reg = new RegExp("\n", "g")
      for item in response.results
        item.content4Show = $sce.trustAsHtml(item.content.replace(reg, "<br />"))
      $scope.comments = response
    discussService.getDiscussCommentCount  "discussId": $stateParams.discussId, (response)->
      $scope.commentCount = response.count

  config()
  load()

  $scope.download = utilService.appDownload
  $scope.closeDownload = -> $scope.showDownload = false

  $scope.loadMore = ->
    params =
      "discussId": $stateParams.discussId
      "pageSize": 20
      "lastTime": $scope.comments.results[$scope.comments.results.length - 1].createTime
    discussService.getDiscussComment params, (response)->
      reg = new RegExp("\n", "g")
      for item in response.results
        item.content4Show = $sce.trustAsHtml(item.content.replace(reg, "<br />"))
      $scope.comments.hasMore = response.hasMore
      $scope.comments.results = $scope.comments.results.concat response.results
