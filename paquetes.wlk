import mensajeros.*
import destinos.*

object paquete {
  var pago = false
  var destino = puenteBrooklyn
  
  method precio() = 50
  
  method cambiarDestino(nuevoDestino) {
    destino = nuevoDestino
  }

  method estaPago() {
    pago = true
  }

  method puedeEntregarse(mensajero) = pago && destino.puedeEntrar(mensajero)
  
}

object paquetito {
  var destino = puenteBrooklyn
  
  method precio() = 0
  
  method cambiarDestino(nuevoDestino) {
    destino = nuevoDestino
  }
  
  method puedeEntregarse(mensajero) = destino.puedeEntrar(mensajero)
}

object paquetonViajero {
  const destinos = [puenteBrooklyn, matrix]
  var importePago=0
  
  method precio() = 100 * self.destinosvisitados()
  
  method destinosvisitados() = destinos.size()
  
  method agregarDestino(nuevoDestino) {
    destinos.add(nuevoDestino)
  }
  
  method pagar(cant) {
    importePago = (importePago + cant).min(self.precio())
  }
  
  method estaPago() = self.precio() == importePago
  
  method puedeEntregarse(mensajero) = self.estaPago() && destinos.all(
    { destino => destino.puedeEntrar(mensajero) }
  )
}

object paqueteAzul {
  var pastillas = 1
  var pago = false
  var destino = puenteBrooklyn
  
  method cantPastillas(num) {
    pastillas = num
  }
  
  method precio() = 50 * pastillas
  
  method pagar(cant) {
    pago = true
  }
  
  method cambiarDestino(nuevoDestino) {
    destino = nuevoDestino
  }
  
  method puedeEntregarse(mensajero) = pago && destino.puedeEntrar(mensajero)
}

object empresaMensajeria {
  const mensajeros = [roberto, neo, chuckNorris]
  const paquetePendientes = []
  const paquetesEnviados = []
  
  method mensajeros() = mensajeros
  
  method mensajerosPeso() = mensajeros.sum({ mensajero => mensajero.peso() })
  
  method paquetePendientes() = paquetePendientes
  
  method primerMensajero() = mensajeros.first()
  
  method despedirA(mensajero) {
    mensajeros.remove(mensajero)
  }
  
  method contratarA(mensajero) {
    mensajeros.add(mensajero)
  }
  
  method despedirATodos() {
    mensajeros.clear()
  }
  
  method paquetesEnviados() = paquetesEnviados
  
  method esGrande() = mensajeros.size() > 2
  
  method puedeEntregarElPrimero(unPaquete) = unPaquete.puedeEntregarse(
    self.primerMensajero()
  )
  
  method pesoDelUltimo() = mensajeros.last().peso()
  
  method puedeEntregarAlguno(unPaquete) = mensajeros.any(
    { mensajero => unPaquete.puedeEntregarse(mensajero) }
  )
  
  method losQuePuendenEntregar(unPaquete) = mensajeros.filter(
    { mensajero => unPaquete.puedeEntregarse(mensajero) }
  )
  
  method tieneSobrepeso() = (self.mensajerosPeso() / mensajeros.size()) > 500
  
  method enviarPaquete(unPaquete) {
    if (self.puedeEntregarAlguno(unPaquete)) paquetesEnviados.add(unPaquete)
    else paquetePendientes.add(unPaquete)
  }
  
  method enviarTodos(conjPaquete) {
    conjPaquete.forEach({ unPaquete => self.enviarPaquete(unPaquete) })
  }
  
  method enviarElMasCaro() {
    if (self.puedeEntregarAlguno(
      paquetePendientes.max({ unPaquete => unPaquete.precio() })
    )) {
      self.enviarPaquete(
        paquetePendientes.max({ unPaquete => unPaquete.precio() })
      )
      paquetePendientes.remove(
        paquetePendientes.max({ unPaquete => unPaquete.precio() })
      )
    }
  }
  
  method facturacion() = paquetesEnviados.sum({ paquete => paquete.precio() })
}