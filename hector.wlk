import wollok.game.*
import cultivos.*

object hector {
	var property position = game.center()
	const property image = "player.png"
	const property cultivos = []
	const property cosechados = []

	method hayCultivoEn(posicion) {
		return 
		cultivos.any({cultivo => cultivo.position().x() == posicion.x() && cultivo.position().y() == posicion.y()})
	}

	method plantarMaiz() {
		self.validarPlantar()
		const nuevoMaiz = new Maiz(position = self.position())
		game.addVisual(nuevoMaiz)
		cultivos.add(nuevoMaiz)
	}

	method plantarTrigo() {
		self.validarPlantar()
		const nuevoTrigo = new Trigo(position = self.position())
		game.addVisual(nuevoTrigo)
		cultivos.add(nuevoTrigo)
	}

	method plantarTomaco() {
		self.validarPlantar()
		const nuevoTomaco = new Tomaco(position = self.position())
		game.addVisual(nuevoTomaco)
		cultivos.add(nuevoTomaco)
	}

	method validarPlantar() {
		if(self.hayCultivoEn(self.position())) {
			self.error("No se puede plantar acá debido a que ya hay otra planta")
		}
	}

	method regar() {
		self.validarRegar()
		const plantaAca = game.uniqueCollider(self)
		plantaAca.serRegada()
	}

	method validarRegar() {
		if(!self.hayCultivoEn(self.position())) {
			self.error("No se puede regar acá debido a que no hay ninguna planta")
		}
	}

	method cosechar() {
		self.validarCosecha()
	}

	method validarCosecha() {
		self.validarPresencia()
		self.validarAdultez()
		const cultivo = game.uniqueCollider(self)
		game.removeVisual(cultivo)
		cultivos.remove(cultivo)
		cosechados.add(cultivo)
	}

	method validarPresencia() {
		if(game.colliders(self).isEmpty()) {
			self.error("No se puede cosechar acá ya que no hay ningún cultivo")
		}
	}

	method validarAdultez() {
		const cultivo = game.uniqueCollider(self)
		if(!cultivo.esCosechable()) {
			self.error("No se puede cosechar este cultivo porque aún no está listo")
		}
	}

}

object granja {

	method ancho() {
		return game.width()
	}

	method largo() {
		return game.height()
	}

}