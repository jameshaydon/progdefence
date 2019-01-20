-- bootstrap the compiler
fennel = require("lib.Fennel.fennel")
table.insert(package.loaders, fennel.make_searcher({correlate=true}))
pp = function(x) print(require("lib.Fennel.fennelview")(x)) end
lume = require("lib.lume.lume")

require("wrap")
