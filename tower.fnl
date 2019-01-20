;;;;;;;;;;;
;; Tower ;;
;;;;;;;;;;;

(local vec (require :lib.hump.vector))

{:update
 (fn [dt id m] nil)
 :draw
 (fn [e] (util.rect e.pos.x e.pos.y 50 50))

 ;; Shoot a missile at the nearest enemy!
 :shoot
 (fn [t]
   (local target (+ t.pos (vec.fromPolar t.angle t.shell-dist)))
   (ents.new
    {:type :missile
     :moves true
     :pos t.pos
     :target target}))

 :signal
 (fn [t x]
   (local a (if (< x t.pos.x)
                math.pi
                0))
   (tset t
         :angle
         a))
 }
