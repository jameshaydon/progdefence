{:mk-counter
 (fn []
   (var i -1)
   (fn []
     (set i (+ i 1))
     i))

 :rect
 (fn [x y w l]
   (love.graphics.rectangle "fill" x y w l))

 :dist2
 ;; The square-distance between two entities that have a :pos.
 (fn [x y] (: x.pos :dist2 y.pos))

 :dist
 ;; The distance between two entities that have a :pos.
 (fn [x y] (: x.pos :dist y.pos))
 }
