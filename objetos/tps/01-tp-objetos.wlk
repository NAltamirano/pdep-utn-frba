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

/////////// Punto 1 //////////////
// Hulk
object hulk {
	var vida
	var vidaNormal
	var poderes = []
	var calmado

	method vida() = vida
	method vida(_vida) { vida = _vida }

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
}

//// Pruebas para punto 1.a.
hulk.serMolestado()
hulk.serMolestado()
hulk.vida()

//// Punto 1.b 
hulk.serCalmado()
hulk.vida()

//// Punto 1.c
hulk.serMolestado()
hulk.serMolestado()
hulk.disminuirVida(10)
hulk.vida()

/////////// Punto 2 //////////////