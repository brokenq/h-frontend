angular.module 'lib.util', []
.factory 'UtilService', ($log, dialogs)->
  $log.log 'util service init'
  class UtilService
    constructor: ->

    isAndroid: ->
      agent = navigator.userAgent
      return agent.indexOf("Android") > -1 or agent.indexOf("Linux") > -1

    isIOS: ->
      agent = navigator.userAgent
      return !!agent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)

    isWX: ->
      agent = navigator.userAgent.toLocaleLowerCase()
      return agent.match(/MicroMessenger/i) is 'micromessenger'

    isMobile: ->
      agent = navigator.userAgent
      return !!agent.match(/AppleWebKit.*Mobile.*/)

    isChrome: ->
      return navigator.userAgent.indexOf("Chrome") > -1

    imageRepackage: (images, cols, excludeStatus)->
      result = []
      temp = []
      imageList = []
      if excludeStatus
        for image in images
          imageList.push image if image.status isnt excludeStatus
      else
        imageList = images

      for image, i in imageList
        if (i % cols) is 0
          result.push temp if temp.length isnt 0
          temp = []
        temp.push image
      result.push temp if temp.length isnt 0
      return result

    appDownload: ()->
      utilService = new UtilService()
      return window.location.href = "http://a.app.qq.com/o/simple.jsp?pkgname=info.yihua.manager" if utilService.isAndroid() or utilService.isIOS()
#        return window.location.href = "http://app.yihua.info/apks/decobird.apk" if utilService.isAndroid()
#        return window.location.href = "https://itunes.apple.com/cn/app/pang-niao-gong-zhang/id1097695936?mt=8" if utilService.isIOS()
      dialogs.create "/index/appDownload.html", "AppDownloadCtrl", null, {"size": "md"}