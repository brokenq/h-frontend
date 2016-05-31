angular.module 'lib.filter.util', []
.filter 'timeConvert', ($log, $filter)->
  return (time)->
    now = new Date()
    diff = now - time
    return "刚刚" if diff / 60000 < 1
    return "#{Math.floor(diff/60000)}分钟前" if diff / (60000 * 60) < 1
    return "#{Math.floor(diff/(60000*60))}小时前" if diff / (60000 * 60 * 24) < 1
    return $filter('date')(time, 'yyyy-MM-dd H:mm')