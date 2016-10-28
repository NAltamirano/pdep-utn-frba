class Cliente {
	var humor

	constructor(unHumor)
	{
		humor = unHumor
	}

	method cuantoPaga(ImporteTotal) {
		return ImporteTotal + humor.calcularPropina(ImporteTotal)
	} 
}

class Feliz {
	method calcularPropina(unImporte) {
		return 25 * unImporte / 100
	}
}

class Enojado {
	method calcularPropina(unImporte) {
		return 0
	}
}

class Indiferente {
	var bolsillo

	method calcularPropina(unImporte) {
		return bolsillo
	}
}

// Main
const feliz = new Feliz
const yo = new Cliente(feliz)
yo.cuantoPaga(200)

//////////////////////////////////////////////////////
class VendedorEspecialista {
	var premio
	var venta

	method cobra() {
		if (venta > 500) {
			return premio
		}
	} 
}

class VendedorSenior {
	var colVendedorJunior

	method cobra() {

	}
}

class VendedorJunior {
	// TODO: getter y setter
	var descuento
	var venta

	method cobra() {
		return venta * descuento / 100
	}
}