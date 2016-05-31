angular.module 'lib.constants', []
.factory 'Constants', ($log)->
  $log.log 'constants init'
  class Constants
    constructor: ->
      @DOMAIN = "@@domain"
      @QI_NIU_URL = "@@qiNiuUrl"
      @WX_QR_CODE_PREFIX = "@@wxQrCodePrefix"