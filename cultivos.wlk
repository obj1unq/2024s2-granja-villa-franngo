import wollok.game.*

class Maiz {
	var property position = null
	var property etapa = bebe
	var property image = "corn_baby.png"

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

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "wheat_0.png"
	}

	method serRegada() {
		
	}

}

class Tomaco {
	var property position = null

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "tomaco.png"
	}

	method serRegada() {
		
	}

}