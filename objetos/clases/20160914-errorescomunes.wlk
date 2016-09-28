class Perro {
	var peso

	// getter
	method peso() {
		return peso
	}
	
	//setter
	method peso(_peso) {
		peso = _peso
	}

	method come(unaComida) {
		peso += unaComida.peso() // Trato al atributo como interno y puedo asignarlo. Es una variable.
		// Un error común es: self.peso += unaComida.peso()
		self.peso(self.peso() + unaComida.peso()) // Utilizando el getter + setter
	}
}

// Instanciación de objetos desde una Clase.
const firulay = new Perro()

//		_____________________________
//		|_Perro_____________________|
//		| peso (variable instancia)	|
//		|___________________________|
//		| peso()					|
//		| peso(_peso)				| ==> Metodos de instancia
//		| come(unaComida)			|
//		|___________________________|


class Gato {
	var peso

	method peso() {
		return peso
	}

	method peso(_peso) {
		peso = _peso
	}

	method come(unaComida) { // Polimorfismo
		self.peso(self.peso() + unaComida.peso() * 0.1)
	}
}

class Animal {
	var peso
	var km

	method camina(_km) {
		self.km(self.km() + _km)
	}
}

// Para heredar en una clase.
class Gato inherits Animal {
	construct(_peso) {
		peso = _peso
		km = 0
	}

	method camina(_km) {
		super.camina(_km)
		self.peso(self.peso() - (_km * 0.1))
	}
}

const michifus = new Gato
michifus.come(arroz)
michifus.camina(3)