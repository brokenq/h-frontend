angular.module 'checkPoint', []
.controller 'CheckPointIndexCtrl', ($log, $scope, IOSService, AndroidService, CommonService, UtilService, CheckPointService)->
  $log.log "checkPoint index controller init"
  iosService = new IOSService()
  androidService = new AndroidService()
  commonService = new CommonService()
  utilService = new UtilService()
  checkPointService = new CheckPointService()

  $scope.config = ->
    $scope.showDownload = true
    $scope.innerApp = androidService.isMatch() or iosService.isMatch()
    $scope.qiNiuUrl = commonService.getQiNiuUrl()
    $scope.pop = "show": false, "images": [], "currImage": "", "index": 0
    $(".pop-content").click (e)->
      return if e.target.tagName is "IMG"
      $scope.pop.show = false
      $scope.$digest()

  _warpReport = (response)->
    for item in response.checkItemReportList
      images = []
      for image in item.checkImageList
        img = image.yhImage
        img.status = image.status
        images.push img
      item.checkImages4Show = utilService.imageRepackage images, 3
      item.checkItem.typicalImages4Show = utilService.imageRepackage item.checkItem.typicalImageList, 3
      item.inspectImage4Show = utilService.imageRepackage item.inspectImageList, 3
      item.showTypical = false
    $scope.checkPoint = response
    $scope.project = response.project

  $scope.getReport = (checkPointId)->
    checkPointService.getCheckPoint "checkPointId": checkPointId, (response)->
      _warpReport response

  $scope.getSnapshotReport = (snapshotId)->
    checkPointService.getCheckPointSnapshot "snapshotId": snapshotId, (response)->
      _warpReport response

  $scope.download = utilService.appDownload
  $scope.closeDownload = -> $scope.showDownload = false

  $scope.preview = (images, index)->
    getKeys = (images)->
      result = []
      for image in images
        result.push if image.yhImage? then image.yhImage.url else image.url
      return result
    keys = getKeys images
    return if androidService.preview keys, index
    return if iosService.preview keys, index
    return if utilService.isMobile()
    $scope.pop.images = []
    for image in images
      $scope.pop.images.push if image.yhImage? then image.yhImage else image
    $scope.pop.currImage = $scope.pop.images[index]
    $scope.pop.index = index
    $scope.pop.show = true

  $scope.prev = (index)->
    $scope.pop.index = index - 1
    $scope.pop.currImage = $scope.pop.images[$scope.pop.index]

  $scope.next = (index)->
    $scope.pop.index = index + 1
    $scope.pop.currImage = $scope.pop.images[$scope.pop.index]

.controller 'CheckPointFReportCtrl', ($log, $scope, $stateParams)->
  $log.log "checkPoint fReport controller init"
  config = ->
    $scope.config()
  load = ->
    $scope.getReport($stateParams.checkPointId)
  config()
  load()

.controller 'CheckPointReportCtrl', ($log, $scope, $stateParams)->
  $log.log 'checkPoint report controller init'
  config = ->
    $scope.config()
  load = ->
    $scope.getReport($stateParams.checkPointId)
  config()
  load()

.controller 'CheckPointSnapshotCtrl', ($log, $scope, $stateParams)->
  $log.log 'checkPoint snapshot controller init'
  config = ->
    $scope.config()
  load = ->
    $scope.getSnapshotReport($stateParams.snapshotId)
  config()
  load()