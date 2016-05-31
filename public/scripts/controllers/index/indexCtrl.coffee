angular.module 'index', []
.controller 'IndexCtrl', ($log, $scope)->
  $log.log "index controller init"
#    quill = new Quill '#editor', theme: 'snow'
#    quill.setContents([
#      { insert: 'Hello ' },
#      { insert: 'World!', attributes: { bold: true } },
#      { insert: '\n' }
#    ])
#    quill.addModule 'toolbar', container: '#toolbar'

  # =====test=====
#    $scope.imgs = ['/images/test1.jpg', '/images/test2.png']
#    $scope.show = false
#    $scope.preview = (idx)->
#      $scope.show = true
#      $scope.currImg = $scope.imgs[idx]
#
#    $(".img-preview-mobile").click (e)->
#      if e.target.tagName isnt "IMG"
#        $scope.show = false
#        $scope.$digest()
#        return
#
#    setPreviewImg = ->
#      $img = $(".img-preview-mobile img")
#      $img.height if $(window).height() > $(window).width() then "auto" else "100%"
#
#    setPreviewImg()
#    $(window).resize -> setPreviewImg()

.controller 'AppDownloadCtrl', ($log, $scope, $uibModalInstance)->
  $log.log "appDownload controller init"
  $scope.close = ->
    $uibModalInstance.dismiss()