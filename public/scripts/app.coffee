angular.module 'core', [
  'ngSanitize'
  'pascalprecht.translate'
  'ui.router'
  'ui.bootstrap'
  'dialogs.main'
  'dialogs.default-translations'
  'uib/template/modal/backdrop.html'
  'ngProgress'

  'lib.android'
  'lib.common'
  'lib.constants'
  'lib.ios'
  'lib.util'

  'lib.filter.status'
  'lib.filter.type'
  'lib.filter.util'

  'services.base'
  'services.checkPoint'
  'services.decoProcess'
  'services.houseCase'
  'services.houseCaseImage'
  'services.project'
  'services.subject'
  'services.discuss'

  'index.index'
]

.config ($urlRouterProvider, dialogsProvider, $translateProvider)->
  $urlRouterProvider.otherwise '/index'
  dialogsProvider.useBackdrop 'static'
  dialogsProvider.useEscClose false
  dialogsProvider.useCopy false
  dialogsProvider.setSize 'sm'
  $translateProvider.translations 'zh-CN',
    DIALOGS_ERROR: "错误",
    DIALOGS_ERROR_MSG: "系统错误",
    DIALOGS_CLOSE: "关闭",
    DIALOGS_PLEASE_WAIT: "请等待",
    DIALOGS_PLEASE_WAIT_ELIPS: "请等待...",
    DIALOGS_PLEASE_WAIT_MSG: "请等待操作完成。",
    DIALOGS_PERCENT_COMPLETE: "% Complete",
    DIALOGS_NOTIFICATION: "通知",
    DIALOGS_NOTIFICATION_MSG: "通知。",
    DIALOGS_CONFIRMATION: "确认",
    DIALOGS_CONFIRMATION_MSG: "确认请求。",
    DIALOGS_OK: "完成",
    DIALOGS_YES: "确认",
    DIALOGS_NO: "取消"
  $translateProvider.preferredLanguage 'zh-CN'

.run ($log, $rootScope, ngProgressFactory)->
  $rootScope.progressbar = ngProgressFactory.createInstance()
  $rootScope.progressbar.setColor "#337ab7"
  $rootScope.progressbar.start()
  $rootScope.$on '$viewContentLoaded', ->
    $rootScope.progressbar.complete()

