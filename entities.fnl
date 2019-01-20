(var entities {})

(local next-id (util.mk-counter))

{:new
 (fn new-entity [x]
   (local id (next-id))
   (tset x :id id)
   (tset entities id x)
   )

 :destroy
 (fn [id]
   (tset entities id nil)
   )

 :every
 (fn [f]
   (each [k v (pairs entities)]
     (f k v)))

 :nearest
 ;; Returns the entity that is nearest to id0, or nil if there are
 ;; none.
 (fn [x pred]
   (var d nil)
   (var nearest nil)
   (each [id y (pairs entities)]
     (when (and (~= y.id x.id) (pred y))
       (let [d_ (util.dist2 x y)]
         (when (or (not d) (< d_ d))
           (set d d_)
           (set nearest y)))))
   nearest)
 }
