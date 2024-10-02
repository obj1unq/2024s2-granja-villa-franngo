import wollok.game.*
import cultivos.*
import extras.*

object hector {
	var property position = game.at(5,5)
	const property image = "player.png"
	const property cultivos = []
	const property cosechados = []
	var oroAcumulado = 0
	const property mercados = []

	method hayCultivoEn(posicion) {
		return 
		cultivos.any({cultivo => cultivo.position() == posicion})
	}

	method hayMercadoEn(posicion) {
		return
		mercados.any({mercado => mercado.position() == posicion})
	}

	method plantar(creadorCultivo) {
		self.validarPlantar()
		const nuevoCultivo = creadorCultivo.nuevoCultivo(self.position()) //se usan objetos creadores polimórficos
		game.addVisual(nuevoCultivo)
		cultivos.add(nuevoCultivo)
	}

	//se pasó de preguntar si hayCultivoEn(self.position()) && hayMercadoEn(self.position()) a directamente preguntar si hay algo en la
	//celda actual (además de hector), ya que también se puede dar que haya un aspersor, los cuales no tenemos recordados.
	//si hay cualquier cosa (además de hector) en la celda actual, entonces no es lugar para plantar
	method validarPlantar() {
		if( self.hayObjetoObstruyendoAca() ) { 
			self.error("No se puede plantar acá debido a que ya hay otro cultivo, un mercado o un aspersor")
		}
	}

	method hayObjetoObstruyendoAca() {
		return game.colliders(self).size() > 0
	}

	method regar() {
		self.validarPresenciaParaRegar()
		const plantaAca = game.uniqueCollider(self)
		plantaAca.serRegada()
	}

	method validarPresenciaParaRegar() {
		if(!self.hayCultivoEn(self.position())) {
			self.error("No se puede regar acá debido a que no hay ningún cultivo")
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
		self.validarPresenciaParaCosechar()
		const cultivo = game.uniqueCollider(self)
		self.validarAdultez(cultivo)
	}

	method validarPresenciaParaCosechar() {
		if(!self.hayCultivoEn(self.position())) {
			self.error("No se puede cosechar acá ya que no hay ningún cultivo")
		}
	}

	method validarAdultez(cultivo) {
		if(!cultivo.esCosechable()) {
			self.error("No se puede cosechar este cultivo porque aún no está listo")
		}
	}

	method vender() {
		self.validarVender()
		const mercado = game.uniqueCollider(self)
		const sumaProductos = cosechados.sum({cosechado => cosechado.valor()})
		mercado.comprar(cosechados, sumaProductos)
		cosechados.forEach({cosechado => cosechado.serVendido(self)})
		cosechados.clear()
	}

	method validarVender() {
		self.validarPresenciaMercado()
		const mercado = game.uniqueCollider(self)
		self.validarOroMercado(mercado)
	}

	method validarPresenciaMercado() {
		if(!self.hayMercadoEn(self.position())) {
			self.error("No se puede vender, ya que no hay un mercado acá")
		}
	}

	method validarOroMercado(mercado) {
		const sumaProductos = cosechados.sum({cosechado => cosechado.valor()})
		if(mercado.oroDisponible() < sumaProductos) {
			self.error("No se puede vender, ya que este mercado no tiene oro suficiente")
		}
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

	method ponerAspersor() {
		self.validarPonerAspersor()
		const aspersor = new Aspersor(position = self.position())
		game.addVisual(aspersor)
		game.onTick(1000, "regar alrededor", {aspersor.regarAlrededor()})
	}

	method validarPonerAspersor() {
		if( self.hayObjetoObstruyendoAca() ) { 
			self.error("No se puede poner acá debido a que ya hay otro aspersor, un mercado o un cultivo")
		}
	}

	method serRegada() {} //polimorfismo necesario para que funcione el aspersor

}

object granja {

	method ancho() {
		return game.width()
	}

	method largo() {
		return game.height()
	}

}