angular.module 'decoProcess', []
.controller 'DecoProcessIndexCtrl', ($log, $scope, IOSService, AndroidService, CommonService, UtilService, DecoProcessService)->
  $log.log "decoProcess index controller init"
  $scope.iosService = new IOSService()
  $scope.androidService = new AndroidService()
  $scope.decoProcessService = new DecoProcessService()
  $scope.commonService = new CommonService()
  $scope.utilService = new UtilService()

.controller 'DecoProcessViewCtrl', ($log, $scope, $sce, $state, $stateParams, $location)->
  $log.log "decoProcess view controller init"
  iosService = $scope.iosService
  androidService = $scope.androidService
  commonService = $scope.commonService
  utilService = $scope.utilService
  decoProcessService = $scope.decoProcessService

  config = ->
    $scope.qiNiuUrl = commonService.getQiNiuUrl()
    $scope.showInMobile = utilService.isMobile() && !androidService.isMatch() && !iosService.isMatch()
    $scope.pop = "show": false, "showInMobile": false, "images": [], "currImage": "", "index": 0
    $(".pop-content").click (e)->
      return if e.target.tagName is "IMG"
      $scope.pop.show = false
      $scope.$digest()

  load = ->
    decoProcessService.getDecoProcesses "decoProcessId": $stateParams.decoProcessId, (response)->
      reg = new RegExp("\n", "g")
      for resp in response.itemList
        for item in resp.itemList when item.type is "LiveReport"
          if $scope.showInMobile
            item.content.liveReport.images4Show = utilService.imageRepackage item.content.liveReport.imageList, 3
          for communication in item.content.communications
            communication.content4Show = $sce.trustAsHtml(communication.content.replace(reg, "<br />"))

      $scope.progress = response

  config()
  load()

  $scope.preview = (images)->
    getKeys = (images)->
      result = []
      result.push image.url for image in images
      return result
    keys = getKeys images
    return if androidService.preview keys
    return if iosService.preview keys
    $scope.pop.images = []
    $scope.pop.images.push image for image in images
    $scope.pop.currImage = $scope.pop.images[0]
    $scope.pop.index = 0
    $scope.pop.show = true

  $scope.toCheckPointPage = (checkPointId, checkPointName)->
    domain = $location.absUrl().substring 0, $location.absUrl().indexOf("#") + 1
    url = "#{domain}/index/checkPoint/#{checkPointId}/report?projectId=#{$stateParams.decoProcessId}"
    return if androidService.redirect url, "#{checkPointName}验收报告"
    return if iosService.redirect url, "#{checkPointName}验收报告"
    $state.go "index.checkPoint.report", {"checkPointId": checkPointId, "projectId": $stateParams.decoProcessId}

  $scope.prev = (index)->
    $scope.pop.index = index - 1
    $scope.pop.currImage = $scope.pop.images[$scope.pop.index]

  $scope.next = (index)->
    $scope.pop.index = index + 1
    $scope.pop.currImage = $scope.pop.images[$scope.pop.index]

  $scope.loadMore = ->
    lastItem = $scope.progress.itemList[$scope.progress.itemList.length - 1]
    lastTime = lastItem.itemList[lastItem.itemList.length - 1].postTime
    decoProcessService.getDecoProcesses {"decoProcessId": $stateParams.decoProcessId, "lastTime": lastTime}, (response)->
      $scope.progress.hasMore = response.hasMore
      if lastItem.dateStr is response.itemList[0].dateStr
        lastItem.itemList = lastItem.itemList.concat response.itemList[0].itemList
        response.itemList.splice 0, 1
        $scope.progress.itemList = $scope.progress.itemList.concat response.itemList
      else
        $scope.progress.itemList = $scope.progress.itemList.concat response.itemList
      if $scope.showInMobile
        for resp in response.itemList
          for item in resp.itemList when item.type is "LiveReport"
            item.content.liveReport.images4Show = utilService.imageRepackage item.content.liveReport.imageList, 3
