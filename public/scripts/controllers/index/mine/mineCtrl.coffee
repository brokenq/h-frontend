angular.module 'mine', []
.controller 'MineIndexCtrl', ($log, $scope, IOSService, AndroidService, CommonService, UtilService)->
  $log.log "mine index controller init"
  $scope.iosService = new IOSService()
  $scope.androidService = new AndroidService()
  $scope.commonService = new CommonService()
  $scope.utilService = new UtilService()

.controller 'MineCallCenterCtrl', ($log, $scope)->
  $log.log 'mine callCenter controller init'
  config = ->
  load = ->
  $scope.project = {}
  config()
  load()

.controller 'MineProjectQrCodeCtrl', ($log, $scope)->
  $log.log 'mine project qrCode controller init'
  commonService = $scope.commonService
  androidService = $scope.androidService
  iosService = $scope.iosService
  config = ->
    $scope.wxQrCodePrefix = commonService.getWxQrCodePrefix()
  load = ->
    $scope.project = {}
  config()
  load()

  $scope.preview = (image)->
    return if androidService.preview [image]
    return if iosService.preview [image]

.controller 'MineDecoTeamCtrl', ($log, $scope)->
  $log.log 'mine decoTeam controller init'
  config = ->
  load = ->
  config()
  load()

.controller 'MinePaymentCtrl', ($log, $scope)->
  $log.log 'mine payment controller init'
  config = ->
  load = ->
  config()
  load()

.controller 'MineContractCtrl', ($log, $scope)->
  $log.log 'mine contract controller init'
  commonService = $scope.commonService
  androidService = $scope.androidService
  iosService = $scope.iosService
  config = ->
    $scope.qiNiuUrl = commonService.getQiNiuUrl()
  load = ->
    $scope.project = {}
  config()
  load()

  $scope.preview = (images, index)->
    return if androidService.preview images, index
    return if iosService.preview images, index

