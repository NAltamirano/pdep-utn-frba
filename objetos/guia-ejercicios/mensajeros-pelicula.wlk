///////////// Mensajeros ////////////////
object roberto {
	var viajaEn
	var peso
	var puedeLlamar = false

	method viajaEn(vehiculo) {
		viajaEn = vehiculo
	}

	method viajaEn() {
		return viajaEn
	}

	method peso(viajaEn) {
		if (viajaEn == camion) {
			peso += (1000 * viajaEn.cantidadAcoplados()) // Asumo que todos los pesos son en kg.
		}
	}

	method peso() {
		return peso
	}

	method puedeLlamar() {
		return puedeLlamar
	}
}

object chuckNorris {
	var puedeLlamar = true
	var peso = 900 // Los pesos son en kg.

	method puedeLlamar() {
		return puedeLlamar
	}

	method peso() {
		return peso
	}
}

object neo {
	var peso = 0
	var puedeLlamar = true

	method peso() {
		return peso
	}

	method puedeLlamar() {
		return puedeLlamar
	}
}

//////////// Vehiculos /////////////
object bicicleta {
}

// Objeto que determina un camion y la cantidad de acoplados que lleva.
object camion(acoplados) {
	var cantidadAcoplados

	method cantidadAcoplados(cantidad) {
		cantidadAcoplados = cantidad
	}

	method cantidadAcoplados() {
		return cantidadAcoplados
	}
}

//////////// Destinos /////////////
object puenteBrooklyn {
	method puedePasar(unMensajero) {
		if (unMensajero.peso() < 1000) {
			return true
		} else {
			return false
		}
	}
}

object laMatrix {
	method puedePasar(unMensajero) {
		if (unMensajero.puedeLlamar()) {
			return true
		} else {
			return false
		}
	}
}

///////// Corrección //////////
object paquete {
	var peso
	var pago

	method puedeSerEntregado(unMensajero, unDestino) {
		return (self.pago() && unDestino.puedePasar(unMensajero))
	}
}