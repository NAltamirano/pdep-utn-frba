class Point {
	var x
	var y

	constructor(_x,_y) {
		x = _x
		y = _y
	}

	method primerCuadrante() {
		return (x>=0 && y>=0)
	}
}

class Point3D inherits Point {
	var z

	constructor(_x,_y,_z) {
		super(_x,_y) {
			z = _z
		}
	}

	method centro() {
		return (x==0 && y==0 && z==0)
	}

	override method primerCuadrante() {
		return (super() && z>=0)
	}
}