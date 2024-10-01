import wollok.game.*
import hector.*

class Maiz {
	var property position = null
	var property image = "corn_baby.png"
	var property etapa = bebe

	method serRegada() {
		etapa.serRegada(self)
	}

}

object bebe {

	method serRegada(maiz) {
		maiz.image("corn_adult.png")
		maiz.etapa(adulta)
	}

}

object adulta {

	method serRegada(maiz) { }

}

class Trigo {
	var property position = null
	var property image = "wheat_0.png"
	var property etapa = etapa0

	method serRegada() {
		etapa.serRegada(self)
	}

}

object etapa0 {

	method serRegada(trigo) {
		trigo.etapa(etapa1)
		trigo.image("wheat_1.png")
	}

}

object etapa1 {

	method serRegada(trigo) {
		trigo.etapa(etapa2)
		trigo.image("wheat_2.png")
	}

}
object etapa2 {

	method serRegada(trigo) {
		trigo.etapa(etapa3)
		trigo.image("wheat_3.png")
	}

}
object etapa3 {

	method serRegada(trigo) {
		trigo.etapa(etapa0)
		trigo.image("wheat_0.png")
	}

}

class Tomaco {
	var property position = null

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "tomaco.png"
	}

	method serRegada() {
		self.validarAusenciaArriba()
		self.position( game.at( position.x(), (position.y()+1).min(granja.largo()-1) ) )
	}

	method validarAusenciaArriba() {
		const posArriba = game.at(position.x(), position.y()+1)
		if( game.getObjectsIn(posArriba).size()>0 ) {
			self.error(null)
		}
	}

}