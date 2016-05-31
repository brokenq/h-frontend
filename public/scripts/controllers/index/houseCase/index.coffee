angular.module 'houseCase.index', ['houseCase']
.config ($stateProvider)->
  $stateProvider
  .state 'index.houseCase',
    url: '/houseCase'
    abstract: true
    template: '<div ui-view></div>'
    controller: 'HouseCaseIndexCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "样板房"
  .state 'index.houseCase.view',
    url: '/:houseCaseId'
    templateUrl: 'views/index/houseCase/view.html'
    controller: 'HouseCaseViewCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "样板房详情"