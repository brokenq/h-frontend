angular.module 'checkPoint.index', ['checkPoint']
.config ($stateProvider)->
  $stateProvider
  .state 'index.checkPoint',
    url: '/checkPoint'
    abstract: true
    template: '<div ui-view></div>'
    controller: 'CheckPointIndexCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "验收报告"
#      施工过程验收报告
  .state 'index.checkPoint.fReport',
    url: '/:checkPointId/fReport'
    templateUrl: 'views/index/checkPoint/fReport.html'
    controller: 'CheckPointFReportCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "验收报告"
#      我家工地验收报告
  .state 'index.checkPoint.report',
    url: '/:checkPointId/report'
    templateUrl: 'views/index/checkPoint/report.html'
    controller: 'CheckPointReportCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "验收报告"
#      我的消息里的验收报告
  .state 'index.checkPoint.snapshot',
    url: '/snapshot/:snapshotId'
    templateUrl: 'views/index/checkPoint/snapshot.html'
    controller: 'CheckPointSnapshotCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "验收报告"