window.pluckTextFromNode = (node,tagName)->
  node.getElementsByTagName(tagName)[0].textContent
