(local v (require :lib.hump.vector))

(local e (require :entity))
(local draw (require :draw))
(local events (require :event))

(local subs (events.new))
(local ecs (e.new subs))

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
        :update (fn [x dt] nil)
        :towers {}})

(events.subscribe subs :entity-added
                  (fn [e]
                    (when (= e.type :tower)
                      (tset tower-sys.towers e.id e)
                      (when e.tower.focus
                        (tset tower-sys :focused e)))))

(local arrows {:up true :down true :left true :right true})

(events.subscribe subs :keypressed
                  (fn [key]
                    (when (. arrows key)
                      (events.emit subs :arrow-keypressed key))))

(fn tower-move [t dir]
  (match dir
    :up (tset t.pos :y (- t.pos.y 1))
    :down nil))

(events.subscribe subs :arrow-keypressed
                 (fn [key]
                   (when tower-sys.focused
                     (tower-move tower-sys.focused key))))

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
   (print "cb:" key)
   (events.emit subs :keypressed key))
 }
