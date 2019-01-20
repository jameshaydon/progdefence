(local vec (require :lib.hump.vector))
(local timer (require :lib.hump.timer))

(local draw-entity (require :draw))
(local update-entity (require :update))
(local enemy (require :enemy))
(local tower (require :tower))

(local main-tower
       {:type :tower
        :pos (vec 250 100)
        :life 100
        :angle 0
        :shell-dist 170 
        :fire-every 2})

(ents.new main-tower)

(enemy.spawn 100)
(tower.signal main-tower 100)

(timer.every 20
             (fn []
               (enemy.spawn 100)
               (tower.signal main-tower 100)))
(timer.after 10
             (fn []
               (enemy.spawn 400)
               (tower.signal main-tower 400)
               (timer.every 20 (fn [] (enemy.spawn 400)
                                 (tower.signal main-tower 400)))))

(timer.every main-tower.fire-every
             (fn []
               (tower.shoot main-tower)))

{:draw
 (fn draw [message]
   (ents.every (fn [id x] (draw-entity.entity x))))
 
 :update
 (fn update [dt set-mode]
   (timer.update dt)
   (ents.every (fn [id x] (update-entity dt id x))))

 ;; :keypressed
 ;; (fn keypressed [key set-mode]
 ;;   (if (= key "space")
 ;;      (tower.shoot main-tower)))
 }
