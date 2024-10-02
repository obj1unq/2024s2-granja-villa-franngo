import wollok.game.*
import hector.*

class Mercado {
    var property position = null
    var oroDisponible = 0
    const property mercancias = []

    method image() {
        return "market.png"
    }

    method oroDisponible() {
        return oroDisponible
    }

    method comprar(productos, oroARestar) {
        oroDisponible -= oroARestar
        mercancias.addAll(productos)
    }

    method serRegada() {}

}

class Aspersor {
    var property position = null

    method position() {
        return position
    }

    method image() {
        return "aspersor.png"
    }

    method objetosAledanhos() {
        const objs = []
        objs.addAll( game.getObjectsIn(position.up(1)) )
        objs.addAll( game.getObjectsIn(position.up(1).right(1)) )
        objs.addAll( game.getObjectsIn(position.right(1)) )
        objs.addAll( game.getObjectsIn(position.right(1).down(1)) )
        objs.addAll( game.getObjectsIn(position.down(1)) )
        objs.addAll( game.getObjectsIn(position.left(1).down(1)) )
        objs.addAll( game.getObjectsIn(position.left(1)) )
        objs.addAll( game.getObjectsIn(position.left(1).up(1)) )
        return objs
    }

    method regarAlrededor() {
        self.objetosAledanhos().forEach({objeto => objeto.serRegada()})
    }

    method serRegada() {}
    
}