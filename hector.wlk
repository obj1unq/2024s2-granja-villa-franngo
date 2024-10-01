import wollok.game.*
import cultivos.*

object hector {
	var property position = game.center()
	const property image = "player.png"
	const property cultivos = []

	method anchoGranja() {
		return game.width()
	}

	method largoGranja() {
		return game.height()
	}

	method hayCultivoEn(posicion) {
		return 
		cultivos.any({cultivo => cultivo.position().x() == posicion.x() && cultivo.position().y() == posicion.y()})
	}

	method plantarMaiz() {
		const nuevoMaiz = new Maiz()
		nuevoMaiz.position(self.position())
		game.addVisual(nuevoMaiz)
		cultivos.add(nuevoMaiz)
	}

	method plantarTrigo() {
		const nuevoTrigo = new Trigo()
		nuevoTrigo.position(self.position())
		game.addVisual(nuevoTrigo)
		cultivos.add(nuevoTrigo)
	}

	method plantarTomaco() {
		const nuevoTomaco = new Tomaco()
		nuevoTomaco.position(self.position())
		game.addVisual(nuevoTomaco)
		cultivos.add(nuevoTomaco)
	}

}