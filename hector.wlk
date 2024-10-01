import wollok.game.*

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

}