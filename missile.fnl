;;;;;;;;;;;;;;
;; Missiles ;;
;;;;;;;;;;;;;;

(local damage-radius 100)
(local power 1000)

(fn init-missile [m]
  (local v (: (- m.target m.pos)
              :normalized))
  (tset m :velocity v)
  (tset m :speed 400))

;; When m explodes it inflicts damage on x.
(fn damage [m x]
  (when x.life
    (let [d (util.dist m x)]  
      (when (< d damage-radius)
        (tset x :life (- x.life (/ power d)))))))

{:update
 (fn [dt id m]
   (if m.velocity
       (if (< (: m.pos :dist2 m.target) 100)
           (do (ents.every (fn [id x] (damage m x)))
               (ents.destroy id)))
       (init-missile m)))
 :draw
 (fn [e] (util.rect e.pos.x e.pos.y 10 10))
 }
