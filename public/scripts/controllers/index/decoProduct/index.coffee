angular.module 'decoProduct.index', ['decoProduct']
.config ($stateProvider)->
  $stateProvider
  .state 'index.decoProduct',
    url: '/decoProduct'
    abstract: true
    template: '<div ui-view></div>'
    controller: 'DecoProductIndexCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "装修产品介绍"
  .state 'index.decoProduct.view',
    url: '/:decoProductId'
    templateUrl: 'views/index/decoProduct/view.html'
    controller: 'DecoProductViewCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "装修产品介绍"