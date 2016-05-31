angular.module 'subject.index', ['subject']
.config ($stateProvider)->
  $stateProvider
  .state 'index.subject',
    url: '/subject'
    abstract: true
    template: '<div ui-view></div>'
    controller: 'SubjectIndexCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "专题"
  .state 'index.subject.view',
    url: '/:subjectId'
    templateUrl: '/index/subject/view.html'
    controller: 'SubjectViewCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "专题"