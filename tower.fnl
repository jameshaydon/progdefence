;;;;;;;;;;;
;; Tower ;;
;;;;;;;;;;;

(local vec (require :lib.hump.vector))

(fn inc-cp [t]
  (tset t :code-pointer (+ t.code-pointer 1)))

(fn val [t x]
  (let [ty (type x)]
    (if (= ty :number) x
        (= ty :string) (. t.registers x)
        (print x))))

;; This function assumes that the code is *valid*. This should be
;; checked at spawn time by a seprate fn.
(fn step-code [t]
  (let [c (. t.code (+ t.code-pointer 1))]
    (match c
      [:lt x y] (do (tset t.registers :t (if (< (val t x) (val t y)) 1 0))
                    (inc-cp t))
      [:fjmp i] (if (= (val t :t) 1)
                    (inc-cp t)
                    (tset t :code-pointer (val t i)))
      [:copy x y] (do (tset t.registers y (val t x))
                      (inc-cp t))
      [:jump i] (tset t :code-pointer (val t i))
      [:sig x] (when t.signal
                 (tset t.registers x t.signal)
                 (tset t :signal nil)
                 (inc-cp t)))))

{:spawn
 (fn []
   (print "spawning tower")
   (local t
          {:type :tower
           :pos (vec 250 100)
           :life 100
           :shell-dist 170 
           :fire-every 2
           :registers {:a 0}
           :code
           [[:sig :x]
            [:lt :x 250]
            [:fjmp 5]
            [:copy 180 :a]
            [:jump 0]
            [:copy 0 :a]
            [:jump 0]]
           :code-pointer 0
           })
   (timer.every 0.4 (fn [] (step-code t)))
   (ents.new t)
   t)

 :update
 (fn [dt id m] nil)
 :draw
 (fn [e] (util.rect e.pos.x e.pos.y 50 50))

 ;; Shoot a missile at the nearest enemy!
 :shoot
 (fn [t]
   (local target (+ t.pos (vec.fromPolar (math.rad t.registers.a) t.shell-dist)))
   (ents.new
    {:type :missile
     :moves true
     :pos t.pos
     :target target}))

 :signal
 (fn [t x]
   (tset t :signal x))
 }
