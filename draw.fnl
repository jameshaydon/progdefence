(fn rec [e styl w h]
  (love.graphics.rectangle styl e.pos.x e.pos.y w h))

{:draw
 (fn [x]
   (match x.type
     :enemy (rec x "fill" 100 100)
     :tower (rec x "line" 100 100)))}
