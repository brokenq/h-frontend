angular.module 'lib.ios', []
.factory 'IOSService', ($log)->
  $log.log "ios service init"
  class IOSService
    constructor: ->
      @connectToSwiftWebViewBridge (bridge)->
        bridge.init (message, responseCallback)->
          responseCallback "status": "connected"
      @matched = if window.SwiftWebViewBridge then true else false

    connectToSwiftWebViewBridge: (callback)->
      return callback SwiftWebViewBridge if window.SwiftWebViewBridge
      document.addEventListener "SwiftWebViewBridgeReady", (event)->
        callback SwiftWebViewBridge
      , false

    isMatch: -> @matched

    preview: (images, index)->
      data = "index": index, "images": images
      SwiftWebViewBridge.callSwiftHandler 'preview', data if @matched
      return @matched

    redirect: (url, title)->
      data = "url": url, "title": title
      SwiftWebViewBridge.callSwiftHandler 'redirect', data if @matched
      return @matched