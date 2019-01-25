(local u (require :util))
(local events (require :event))

{:new
 ;; Creates an entity set.
 (fn [subs]
   (local next-id (u.mk-counter))
   {:next-id next-id
    :subs subs
    :entities {}})
 
 :add-entity
 ;; Adds a new entity and returns the ID.
 (fn [es x]
   (local id (es.next-id))
   (tset x :id id)
   (tset es.entities id x)
   (events.emit es.subs :entity-added x)
   id)

 :run-system
 (fn [es sys ...]
   (each [_ x (pairs es.entities)]
     (when (sys.filter x)
       (sys.update x ...))))
 }

