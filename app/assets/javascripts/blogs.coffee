# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# 画像タップで写真選択
$ ->
  $('#blog__post__image').click ->
    $('#blog_image').click()
    false

  # 写真のプレビューが表示される
  $('#blog_image').on 'change', (e) ->
    file = e.target.files[0]
    reader = new FileReader
    $preview = $('.blog__image')
    t = this
    
    if file.type.indexOf('image') < 0
      return false
      
    reader.onload = do (file) ->
      (e) ->
        $preview.empty()
        $preview.attr("src",e.target.result)
          
        return
    reader.readAsDataURL file
    return
  return