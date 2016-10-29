//// Modelo primero todos los poderes necesarios
// Poderes
object fuerza {
	method usar(atacante,atacado) {
		atacado.vida() -= 40
	}
}

object vuelo {
	method usar(atacante,atacado) {
		atacante.vida() += 20
	}
}

object telequinesis {
	method usar(atacante,atacado) {
		atacado.vida() -= 50
		atacante.vida() -= 1
	}
}

object objetosCortantes {
	method usar(atacante,atacado) {
		atacado.vida() -= 30
	}
}
//// Lo mismo con las reacciones
// Reacciones
object culpa {
	method afectar(heroe) {
		heroe.vida() -= 5
	}
}

object experiencia {
	method afectar(heroe) {
		heroe.vida() += 10
	}
}

object absorcion {
	method afectar(atacante,atacado) {
		atacado.poderes.forEach { poder => atacante.poderes.add(poder) }
	}
}

object caraDeNaipe {
	method afectar() {
	}
}

//// Peleas
object peleas {
	method luchar(atacante,atacado) {
		atacante.atacar(atacado)

		if (atacado.estarVivo()) {
			peleas.luchar(atacado,atacante)
		} else {
			atacado.morir()
			atacante.inicializar()
		}
	}
}
/////////// Punto 1 //////////////
// Hulk
object hulk {
	var nombre = "Hulk"
	var vida
	var vidaNormal
	var poderes = []
	var calmado

	method vida() = vida
	method vida(_vida) { vida = _vida }

	method nombre()

	method inicializar() {
		self.serCalmado()
		vidaNormal = 50
		vida = vidaNormal
	}

	method serMolestado() {
		poderes.add(fuerza)
		vida = self.calcularVida()
	}

	method serCalmado() {
		vida = vidaNormal
		poderes.clear()
		calmado = true
	}

	method atacar(atacado) {
		poderes.forEach { poder => poder.usar(self,atacado) }
		culpa.afectar(self)
	}

	method morir() {
		self.serCalmado()
		vida = 0
	}

	method disminuirVida(danio) {
		vida -= danio
	}

	method calcularVida() {
		return vidaNormal + poderes.size() * 100
	}

	method estarVivo() {
		if (self.vida() > 0) { 
			return true 
		} else { 
			return false
		}
	}
}

/////////// Punto 2 //////////////
object magneto {
	var nombre = "Magneto"
	var vida
	var casco
	var poderes = []

	method vida() = vida
	method vida(_vida) { vida = _vida }

	method nombre() = nombre
	method nombre(_nombre) { nombre = _nombre }

	method inicializar() {
		vida = 100
		casco = false
	}
	method ponerCasco() {
		if (! casco) {
			casco = true
			vida *= 10
		}
	}

	method sacarCasco() {
		if (casco) {
			casco = false
			vida /= 10
		}
	}

	method cargarPoderes() {
		poderes.add(vuelo)
		poderes.add(telequinesis)
		poderes.add(objetosCortantes)
	}

	method atacar(atacado) {
		poderes.forEach { poder => poder.usar(self,atacado) }
		experiencia.afectar(self)
	}

	method morir() {
		vida = 0
	}

	method estarVivo() {
		if (self.vida() > 0) return true else return false
	}
}