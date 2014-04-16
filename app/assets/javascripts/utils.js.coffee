window.Utils =
  is_empty: (obj)->
    return true if not obj? or obj.length is 0
    return false if obj.length? and obj.length > 0
    for key of obj
      return false if Object.prototype.hasOwnProperty.call(obj,key) 
    return true
