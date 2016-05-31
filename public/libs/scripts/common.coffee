angular.module 'lib.common', ['lib.constants']
.factory 'CommonService', ($log, Constants)->
  $log.log "common service init"
  class CommonService
    constructor: ->
      @constants = new Constants()

    getQiNiuUrl: -> @constants.QI_NIU_URL
    getWxQrCodePrefix: -> @constants.WX_QR_CODE_PREFIX
