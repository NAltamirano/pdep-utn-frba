class Persona {
	var nombre
	var domicilio

	constructor(_nombre, _domicilio) {
		nombre = _nombre
		domicilio = _domicilio
	} 

	method nombre() {
		return nombre
	}

	method domicilio() = domicilio
}