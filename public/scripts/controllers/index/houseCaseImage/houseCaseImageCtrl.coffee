angular.module 'houseCaseImage', []
.controller 'HouseCaseImageIndexCtrl', ($log, $scope, IOSService, AndroidService, CommonService, UtilService, HouseCaseImageService)->
  $log.log "houseCaseImage index controller init"
  $scope.iosService = new IOSService()
  $scope.androidService = new AndroidService()
  $scope.houseCaseImageService = new HouseCaseImageService()
  $scope.commonService = new CommonService()
  $scope.utilService = new UtilService()

.controller 'HouseCaseImageViewCtrl', ($log, $scope, $stateParams, $sce)->
  $log.log "houseCaseImage view controller init"
  iosService = $scope.iosService
  androidService = $scope.androidService
  commonService = $scope.commonService
  utilService = $scope.utilService
  houseCaseImageService = $scope.houseCaseImageService
  config = ->
    $scope.showDownload = true
    $scope.qiNiuUrl = commonService.getQiNiuUrl()
    $scope.innerApp = androidService.isMatch() or iosService.isMatch()
    $scope.pop = "show": false, "showInMobile": false, "images": [], "currImage": "", "index": 0
    $(".pop-content").click (e)->
      return if e.target.tagName is "IMG"
      $scope.pop.show = false
      $scope.$digest()
  load = ->
    houseCaseImageService.get "houseCaseImageId": $stateParams.houseCaseImageId, (response)->
      $scope.houseCaseImage = response
    params =
      "houseCaseImageId": $stateParams.houseCaseImageId
      "pageSize": if $scope.innerApp then 20 else 7
    houseCaseImageService.getComments params, (response)->
      reg = new RegExp("\n", "g")
      for item in response.results
        item.content4Show = $sce.trustAsHtml(item.content.replace(reg, "<br />"))
      $scope.comments = response
    houseCaseImageService.getCommentCount "houseCaseImageId": $stateParams.houseCaseImageId, (response)->
      $scope.commentCount = response.count

  config()
  load()

  $scope.download = utilService.appDownload
  $scope.closeDownload = -> $scope.showDownload = false

  $scope.loadMore = ->
    params =
      "houseCaseImageId": $stateParams.houseCaseImageId
      "pageSize": 20
      "lastId": $scope.comments.results[$scope.comments.results.length - 1].createTime
    houseCaseImageService.getCommentMore params, (response)->
      reg = new RegExp("\n", "g")
      for item in response.results
        item.content4Show = $sce.trustAsHtml(item.content.replace(reg, "<br />"))
      $scope.comments.hasMore = response.hasMore
      $scope.comments.results = $scope.comments.results.concat response.results

  $scope.preview = (images)->
    getKeys = (images)->
      result = []
      result.push image for image in images
      return result
    keys = getKeys images
    return if androidService.preview keys
    return if iosService.preview keys
    $scope.pop.images = []
    $scope.pop.images.push "url": image for image in images
    $scope.pop.currImage = $scope.pop.images[0]
    $scope.pop.index = 0
    $scope.pop.show = true

  $scope.prev = (index)->
    $scope.pop.index = index - 1
    $scope.pop.currImage = $scope.pop.images[$scope.pop.index]

  $scope.next = (index)->
    $scope.pop.index = index + 1
    $scope.pop.currImage = $scope.pop.images[$scope.pop.index]

