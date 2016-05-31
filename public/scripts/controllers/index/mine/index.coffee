angular.module 'mine.index', ['mine']
.config ($stateProvider, $urlRouterProvider)->
  $stateProvider
  .state 'index.mine',
    url: '/mine'
    abstract: true
    template: '<div ui-view></div>'
    controller: 'MineIndexCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "我的"
  .state 'index.mine.callCenter',
    url: '/callCenter'
    templateUrl: '/index/mine/call_center.html'
    controller: 'MineCallCenterCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "我的客服"
  .state 'index.mine.projectQrCode',
    url: '/projectQrCode'
    templateUrl: '/index/mine/project_qrcode.html'
    controller: 'MineProjectQrCodeCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "工地二维码"
  .state 'index.mine.decoTeam',
    url: '/decoTeam'
    templateUrl: '/index/mine/deco_team.html'
    controller: 'MineDecoTeamCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "我的施工队"
  .state 'index.mine.payment',
    url: '/payment?openId'
    templateUrl: '/index/mine/payments.html'
    controller: 'MinePaymentCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "我的装修款"
  .state 'index.mine.contract',
    url: '/contract?openId'
    templateUrl: '/index/mine/contract.html'
    controller: 'MineContractCtrl'
    resolve: $setTitle: ($rootScope)-> $rootScope.$title = "我的合同"

  $urlRouterProvider.when '/mine', '/mine/callCenter'