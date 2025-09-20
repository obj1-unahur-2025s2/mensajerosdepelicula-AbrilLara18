object roberto {
  var vehiculo = bicicleta
  
  method peso() {
    return 90 + vehiculo.peso()
  }
  
  method cambiarVehiculo(nuevoVehiculo) {
    vehiculo = nuevoVehiculo
  }
  
  method puedeLlamar() = false
  
}

object chuckNorris {
  method peso() = 80
  
  method puedeLlamar() = true
  
}

object peterParker {
  method peso() = 0
  
  method puedeLlamar() = true
}

object neo {
  var llamada = true
  
  method peso() = 0
  
  method puedeLlamar() = llamada
  
  method tieneCredito(estado) {
    llamada = estado
  }
  
}

object camion {
  var acoplado = 1
  
  method peso() = 500 * acoplado
  
  method cambiarAcoplado(cant) {
    acoplado = cant
  }
}

object bicicleta {
  method peso() = 5
}