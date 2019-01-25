(fn matches [x pat]
  (if (= pat :*)
      true
      (= (type x) (type pat))
      (if (= (type x) :table)
          (do (var ret true)
              (each [k v (pairs pat)]
                (when (not (matches (. x k) v))
                  (set ret false)))
              ret)
          (= x pat))
      false))

{:new
 (fn [] {})

 :subscribe
 (fn [subs pat f] (tset subs f {:pat pat :handler f}))

 :emit
 (fn [subs ev]
   (print "Emitting: " ev)
   (each [id sub (pairs subs)]
     (when (matches ev sub.pat)
       (sub.handler ev))))
 }
