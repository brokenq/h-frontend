angular.module 'decoProcess.index', ['decoProcess']
.config ($stateProvider)->
  $stateProvider
  .state 'index.decoProcess',
    url: '/decoProcess'
    abstract: true
    template: '<div ui-view></div>'
    controller: 'DecoProcessIndexCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "施工过程"
  .state 'index.decoProcess.view',
    url: '/:decoProcessId'
    templateUrl: 'views/index/decoProcess/view.html'
    controller: 'DecoProcessViewCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "施工过程"
  .state 'index.decoProcess.checkPoint',
    url: '/checkPoint/:checkPointId'
    templateUrl: 'views/index/decoProcess/checkPoint.html'
    controller: 'DecoProcessCheckPointViewCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "验收报告"