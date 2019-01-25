(local v (require :lib.hump.vector))

(local e (require :entity))
(local draw (require :draw))
(local events (require :event))

(local ecs (e.new))
(local subs (events.new))

(local draw-sys
       {:filter (fn [x] x.pos)
        :update draw.draw})

(local move-sys
       {:filter (fn [x] x.move)
        :update (fn [x dt]
                  (tset x :pos
                        (+ x.pos
                           (* x.move.speed
                              (* dt x.move.velocity)))))})

(local tower-sys
       {:filter (fn [x] x.tower)
        :update (fn [x dt] nil)})

(events.subscribe subs [:keypressed :*]
                  (fn [[_ key]]
                    (print "yay" key)))

;; (fn tower-move-canon [dir]
;;   (match dir
;;     :left _
;;     :right _))

(e.add-entity
 ecs
 {:type :enemy
  :pos (v 10 10)
  :move {:speed 40
         :velocity (v 1 1)}})

(e.add-entity
 ecs
 {:pos (v 100 100)
  :type :tower
  :tower {:canon-angle 0
          :focus true}})

{:draw
 (fn draw [message]
   (e.run-system ecs draw-sys))
 
 :update
 (fn update [dt set-mode]
   (e.run-system ecs move-sys dt)
   (e.run-system ecs tower-sys dt))

 :keypressed
 (fn keypressed [key set-mode]
   (events.emit subs [:keypressed key]))
 }
