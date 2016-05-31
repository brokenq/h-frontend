angular.module 'subject', []
.controller 'SubjectIndexCtrl', ($log, $scope, IOSService, AndroidService, CommonService, UtilService, SubjectService)->
  $log.log "subject index controller init"
  $scope.iosService = new IOSService()
  $scope.androidService = new AndroidService()
  $scope.subjectService = new SubjectService()
  $scope.commonService = new CommonService()
  $scope.utilService = new UtilService()

.controller 'SubjectViewCtrl', ($log, $scope, $sce, $state, $stateParams, $location)->
  $log.log "subject view controller init"
  iosService = $scope.iosService
  androidService = $scope.androidService
  commonService = $scope.commonService
  utilService = $scope.utilService
  subjectService = $scope.subjectService
  quill = new Quill '#editor',
    readOnly: true
    theme: 'snow'

  config = ->
    $scope.showDownload = true
    $scope.qiNiuUrl = commonService.getQiNiuUrl()
    $scope.innerApp = androidService.isMatch() or iosService.isMatch()


  load = ->
    subjectService.getSubject "subjectId": $stateParams.subjectId, (response)->
      quill.setContents JSON.parse response.content

  config()
  load()

  $scope.download = utilService.appDownload
  $scope.closeDownload = -> $scope.showDownload = false