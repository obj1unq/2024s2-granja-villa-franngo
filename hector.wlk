import wollok.game.*
import cultivos.*

object hector {
	var property position = game.center()
	const property image = "player.png"
	const property cultivos = []
	const property cosechados = []
	var oroAcumulado = 0

	method hayCultivoEn(posicion) {
		return 
		cultivos.any({cultivo => cultivo.position().x() == posicion.x() && cultivo.position().y() == posicion.y()})
	}

	method plantar(creadorCultivo) {
		self.validarPlantar()
		const nuevoCultivo = creadorCultivo.nuevoCultivo(self.position()) //se usan objetos creadores polimórficos
		game.addVisual(nuevoCultivo)
		cultivos.add(nuevoCultivo)
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
		const cultivo = game.uniqueCollider(self)
		game.removeVisual(cultivo)
		cultivos.remove(cultivo)
		cosechados.add(cultivo)
	}

	method validarCosecha() {
		self.validarPresencia()
		self.validarAdultez()
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

	method vender() {
		cosechados.forEach({cosechado => cosechado.serVendido(self)}) //acá debemos acumular en el acumulador
		cosechados.clear()
	}

	method sumarOro(cantidad) {
		oroAcumulado += cantidad
	}

	method oroAcumulado() {
		return oroAcumulado
	}

	method enunciarPosesiones() {
		game.say(self, "Tengo " + cosechados.size() + " plantas para vender/n y " + oroAcumulado + " monedas de oro")
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