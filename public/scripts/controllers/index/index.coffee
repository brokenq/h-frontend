angular.module 'index.index', [
  'index'
  'decoProcess.index'
  'checkPoint.index'
  'houseCase.index'
  'houseCaseImage.index'
  'subject.index'
  'mine.index'
  'discuss.index'
  'decoProduct.index'
]
.config ($stateProvider)->
  $stateProvider
  .state 'index',
    url: '/index'
    templateUrl: 'views/index/index.html'
    controller: 'IndexCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "首页"