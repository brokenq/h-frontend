angular.module 'houseCase', []
.controller 'HouseCaseIndexCtrl', ($log, $scope, IOSService, AndroidService, CommonService, UtilService, HouseCaseService)->
  $log.log "houseCase index controller init"
  $scope.iosService = new IOSService()
  $scope.androidService = new AndroidService()
  $scope.houseCaseService = new HouseCaseService()
  $scope.commonService = new CommonService()
  $scope.utilService = new UtilService()

.controller 'HouseCaseViewCtrl', ($log, $scope, $state, $sce, $stateParams, $location, dialogs)->
  $log.log "houseCase view controller init"
  iosService = $scope.iosService
  androidService = $scope.androidService
  commonService = $scope.commonService
  utilService = $scope.utilService
  houseCaseService = $scope.houseCaseService

  config = ->
    $scope.qiNiuUrl = commonService.getQiNiuUrl()
    $scope.showDownload = true
    $scope.innerApp = androidService.isMatch() or iosService.isMatch()
    $scope.pop = "show": false, "showInMobile": false, "images": [], "currImage": "", "index": 0
    $(".pop-content").click (e)->
      return if e.target.tagName is "IMG"
      $scope.pop.show = false
      $scope.$digest()

  load = ->
    houseCaseService.getHouseCase "houseCaseId": $stateParams.houseCaseId, (response)->
      $scope.houseCase = response
    params =
      "houseCaseId": $stateParams.houseCaseId
      "pageSize": if $scope.innerApp then 20 else 7
    houseCaseService.getHouseCaseComment params, (response)->
      reg = new RegExp("\n", "g")
      for item in response.results
        item.content4Show = $sce.trustAsHtml(item.content.replace(reg, "<br />"))
      $scope.comments = response
    houseCaseService.getHouseCaseCommentCount "houseCaseId": $stateParams.houseCaseId, (response)->
      $scope.commentCount = response.count

  config()
  load()

  $scope.download = utilService.appDownload
  $scope.closeDownload = -> $scope.showDownload = false

  $scope.loadMore = ->
    params =
      "houseCaseId": $stateParams.houseCaseId
      "pageSize": 20
      "lastId": $scope.comments.results[$scope.comments.results.length - 1].createTime
    houseCaseService.getHouseCaseCommentMore params, (response)->
      reg = new RegExp("\n", "g")
      for item in response.results
        item.content4Show = $sce.trustAsHtml(item.content.replace(reg, "<br />"))
      $scope.comments.hasMore = response.hasMore
      $scope.comments.results = $scope.comments.results.concat response.results

  $scope.toDecoProcessPage = (decoProcessId)->
    domain = $location.absUrl().substring 0, $location.absUrl().indexOf("#") + 1
    url = "#{domain}/index/decoProcess/#{decoProcessId}"
    return if androidService.redirect url, "施工过程"
    return if iosService.redirect url, "施工过程"
    $state.go "index.decoProcess.view", "decoProcessId": decoProcessId

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


