angular.module 'discuss.index', ['discuss']
.config ($stateProvider)->
  $stateProvider
  .state 'index.discuss',
    url: '/discuss'
    abstract: true
    template: '<div ui-view></div>'
    controller: 'DiscussIndexCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "交流"
  .state 'index.discuss.view',
    url: '/:discussId'
    templateUrl: 'views/index/discuss/view.html'
    controller: 'DiscussViewCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "交流"