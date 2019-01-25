{:new
 (fn [] {})

 :subscribe
 (fn [subs key f]
   (tset subs key (or (. subs key) {}))
   (tset (. subs key) f f))

 :remove 42
 
 :emit
 (fn [subs key ev]
   (print "Emitting: " key ev)
   (each [id sub (pairs (. subs key))]
     (sub ev)))
 }
