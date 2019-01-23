;;;;;;;;;;;
;; Enemy ;;
;;;;;;;;;;;

(local vec (require :lib.hump.vector))

{:update
 (fn [dt id e]
   (if (> e.pos.y (- HEIGHT 100))
       (ents.destroy id)))
 :draw
 (fn [e]
   (util.rect e.pos.x e.pos.y 50 50)
   (love.graphics.print e.life (- e.pos.x 10) (- e.pos.y 20))
   )

 :spawn
 (fn [x]
  (ents.new
   {:type :enemy
    :moves true
    :pos (vec x 2)
    :velocity (vec 0 1)
    :speed 40
    :life 100}))
 }
