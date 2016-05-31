angular.module 'lib.filter.status', []
.filter 'checkPointStatus', ->
  return (type)->
    switch type
      when 'PAID'     then return '已结算'
      when 'CONFIRM'  then return '已验收'
      when 'CHECKING' then return '待验收'
      when 'REJECT'   then return '整改中'
      when 'CHECKED'  then return '待确认'
      when 'WAITING'   then return '未开工'
      when 'DOING'    then return '施工中'
      else return ''
