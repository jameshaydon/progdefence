(local enemy (require :enemy))
(local missile (require :missile))
(local tower (require :tower))

(local drawers
       {:tower tower.draw
        :enemy enemy.draw
        :missile missile.draw})

(fn entity [e]
  ((. drawers (. e :type)) e))

{:entity entity}
