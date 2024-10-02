import wollok.game.*
import hector.*

class Maiz {
	var property position = null
	var property image = "corn_baby.png"
	var property etapa = bebe
	const property valor = 150

	method serRegada() {
		etapa.serRegada(self)
	}

	method esCosechable() {
		return etapa.esCosechable()
	}

	method serVendido(granjero) {
		granjero.sumarOro(valor)
	}

}

object bebe {

	method serRegada(maiz) {
		maiz.image("corn_adult.png")
		maiz.etapa(adulta)
	}

	method esCosechable() {
		return false
	}

}

object adulta {

	method serRegada(maiz) { }

	method esCosechable() {
		return true
	}

}

class Trigo {
	var property position = null
	var property image = "wheat_0.png"
	var property etapa = etapa0

	method serRegada() {
		etapa.serRegada(self)
	}

	method esCosechable() {
		return etapa.esCosechable()
	}

	method valor() {
		return (etapa.numeroEtapa()-1).max(0) * 100
	}

	method serVendido(granjero) {
		granjero.sumarOro(self.valor())
	}

}

object etapa0 {
	const property numeroEtapa = 0

	method serRegada(trigo) {
		trigo.etapa(etapa1)
		trigo.image("wheat_1.png")
	}

	method esCosechable() {
		return false
	}

}

object etapa1 {
	const property numeroEtapa = 1

	method serRegada(trigo) {
		trigo.etapa(etapa2)
		trigo.image("wheat_2.png")
	}

	method esCosechable() {
		return false
	}

}

object etapa2 {
	const property numeroEtapa = 2

	method serRegada(trigo) {
		trigo.etapa(etapa3)
		trigo.image("wheat_3.png")
	}

	method esCosechable() {
		return true
	}

}

object etapa3 {
	const property numeroEtapa = 3

	method serRegada(trigo) {
		trigo.etapa(etapa0)
		trigo.image("wheat_0.png")
	}

	method esCosechable() {
		return true
	}

}

class Tomaco {
	var property position = null
	const property valor = 80

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "tomaco.png"
	}

	method serRegada() {
		self.validarAusenciaArriba()
		position = game.at( position.x(), (position.y()+1).min(granja.largo()-1) )
	}

	method validarAusenciaArriba() {
		const posArriba = position.up(1)
		if( game.getObjectsIn(posArriba).size()>0 ) {
			self.error(null)
		}
	}

	method esCosechable() {
		return true
	}

	method serVendido(granjero) {
		granjero.sumarOro(valor)
	}

}

//objetos creadores

object creadorMaiz {

	method nuevoCultivo(posicion) {
		return new Maiz(position = posicion)
	}

}

object creadorTrigo {

	method nuevoCultivo(posicion) {
		return new Trigo(position = posicion)
	}

}

object creadorTomaco {

	method nuevoCultivo(posicion) {
		return new Tomaco(position = posicion)
	}
	
}