angular.module 'decoProduct', []
.controller 'DecoProductIndexCtrl', ($log, $scope, IOSService, AndroidService, CommonService, UtilService)->
  $log.log "decoProduct index controller init"
  $scope.iosService = new IOSService()
  $scope.androidService = new AndroidService()
  $scope.commonService = new CommonService()
  $scope.utilService = new UtilService()

.controller 'DecoProductViewCtrl', ($log, $scope, $sce, $state, $stateParams)->
  $log.log "decoProduct view controller init"
  iosService = $scope.iosService
  androidService = $scope.androidService
  utilService = $scope.utilService

  config = ->
    switch $stateParams.decoProductId
      when "1" then $scope.base = 198
      when "2" then $scope.base = 499
      else $scope.base = 198
    $log.log $scope.base
    $scope.showDownload = true
    $scope.innerApp = androidService.isMatch() or iosService.isMatch()
    $scope.result = 0

  load = ->

  config()
  load()

  $scope.download = utilService.appDownload
  $scope.closeDownload = -> $scope.showDownload = false

  $scope.calculate = (roomArea)->
    return $scope.result = $scope.base * 80 if roomArea < 80
    return $scope.result = $scope.base * roomArea

