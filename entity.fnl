(local u (require :util))

{:new
 ;; Creates an entity set.
 (fn []
   (local next-id (u.mk-counter))
   {:next-id next-id
    :entities {}
    :systems {}})
 
 :add-entity
 ;; Adds a new entity and returns the ID.
 (fn [es x]
   (local id (es.next-id))
   (tset x :id id)
   (tset es.entities id x)
   id)

 :run-system
 (fn [es sys ...]
   (each [_ x (pairs es.entities)]
     (when (sys.filter x)
       (sys.update x ...))))
 }

