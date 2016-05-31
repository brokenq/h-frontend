angular.module 'lib.filter.type', []
.filter 'userType', ->
  return (type)->
    switch type
      when 'ASSISTANT' then "运营"
      when 'INSPECTOR' then "巡检"
      when 'MANAGER' then "工长"
