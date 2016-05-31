angular.module 'lib.android', []
.factory 'AndroidService', ($log)->
  $log.log "android service init"
  class AndroidService
    constructor: ->
      @matched = navigator.userAgent.match 'user-pangniao'

    isMatch: -> @matched

    preview: (images, index)->
      data = "index": index, "images": images
      window.control.preview JSON.stringify data if @matched
      return @matched

    redirect: (url, title)->
      data = "url": url, "title": title
      window.control.redirect JSON.stringify data if @matched
      return @matched