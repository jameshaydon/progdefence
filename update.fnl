;;;;;;;;;;;;;;;;;;;
;; Update Entity ;;
;;;;;;;;;;;;;;;;;;;

(local enemy (require :enemy))
(local missile (require :missile))

(fn tower [dt id t]
  nil)

(local updaters
       {:tower tower
        :enemy enemy.update
        :missile missile.update})

(fn update-entity [dt id x]
  
  ;; First we do type-specific updates:
  (local ty (. x :type))
  (local f (. updaters ty))
  (when (and ty f)
    (f dt id x))

  ;; Remove any entities that have died:
  (when (and x.life (< x.life 1))
    (ents.destroy id))
  
  ;; Then we move all entities that move:
  (when x.moves (util.move dt x))
  )
