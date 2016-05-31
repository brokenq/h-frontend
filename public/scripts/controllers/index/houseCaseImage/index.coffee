angular.module 'houseCaseImage.index', ['houseCaseImage']
.config ($stateProvider)->
  $stateProvider
  .state 'index.houseCaseImage',
    url: '/houseCaseImage'
    abstract: true
    template: '<div ui-view></div>'
    controller: 'HouseCaseImageIndexCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "样板房图片"
  .state 'index.houseCaseImage.view',
    url: '/:houseCaseImageId'
    templateUrl: '/index/houseCaseImage/view.html'
    controller: 'HouseCaseImageViewCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "样板房图片详情"