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

}