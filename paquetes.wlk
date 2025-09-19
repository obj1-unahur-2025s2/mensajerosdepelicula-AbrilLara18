import mensajeros.*
import destinos.*

object paquete {
  var pago = 50
  var destino=puenteBrooklyn 
  method precio() = 50
  
  method pagar(cant) {
    pago=0
  }
  method cambiarDestino(nuevoDestino){
    destino = nuevoDestino
  }

  method puedeEntregarse(mensajero) {
    return self.estaPago() && destino.puedeEntrar(mensajero)
  }
  
  method estaPago() = pago == 0
  
  method valor() = self.precio()
}

object empresaMensajeria {
  const mensajeros = [roberto, neo, chuckNorris]
  const paquetePendiente = []
  var facturacion = 0

  method mensajeros(){
    return mensajeros.sum({mensajero =>mensajero.peso()})
  }
  
  method primerMensajero(){
    return mensajeros.first()
  }
  method despedirA(mensajero) {
    mensajeros.remove(mensajero)
  }
  
  method contratarA(mensajero) {
    mensajeros.add(mensajero)
  }
  
  method despedirATodos() {
    mensajeros.clear()
  }
  
  method esGrande() = mensajeros.size() > 2
  
  method puedeEntregarElPrimero(unPaquete) = unPaquete.puedeEntregarse(self.primerMensajero())
  
  method pesoDelUltimo() = mensajeros.last().peso()
  
  method puedeEntregarAlguno(unPaquete) = mensajeros.any(
    { mensajero => unPaquete.puedeEntregarse(mensajero) }
  )
  
  method losQuePuendenEntregar(unPaquete) {
    return mensajeros.filter({mensajero => unPaquete.puedeEntregarse(mensajero)})
  }
  
  method tieneSobrepeso() = (mensajeros.sum({mensajero =>mensajero.peso()})/mensajeros.size()) > 500
  
  method enviarPaquete( unPaquete) {
    if (self.puedeEntregarAlguno(unPaquete)) {
      facturacion += unPaquete.valor()
    } else {
      paquetePendiente.add(unPaquete)
    }
  }
  
  method enviarTodos(conjPaquete) {
    conjPaquete.forEach({unPaquete =>
      self.enviarPaquete(unPaquete)})
  }
  
  method enviarElMasCaro() {
    if (self.puedeEntregarAlguno(paquetePendiente.max({unPaquete => unPaquete.precio()}))) {
      self.enviarPaquete(paquetePendiente.max({unPaquete => unPaquete.precio()})
      )
      paquetePendiente.remove(
        paquetePendiente.max({unPaquete => unPaquete.precio()})
      )
    }
  }
  method facturacion(){
    return facturacion
  }
}

object paquetito {
  method precio() = 0
  var destino=puenteBrooklyn 
  
  method estaPago() = true
  
  method valor() = self.precio()

  method cambiarDestino(nuevoDestino){
    destino = nuevoDestino
  }
  method puedeEntregarse( mensajero) {
    return self.estaPago() && destino.puedeEntrar(mensajero)
  }
}

object paquetonViajero {
  const destinos=[puenteBrooklyn,matrix]
  var precioActual = self.precio()
  
  method precio() = 100 * self.destinosvisitados()
  
  method destinosvisitados() {
    return destinos.size()
  }
  method agregarDestino(nuevoDestino){
    destinos.add(nuevoDestino)
  }
  
  method pagar(cant) {
    precioActual = (precioActual - cant).max(0)
  }
  
  method estaPago() = precioActual == 0
  
  method valor() = self.precio()
  
  method puedeEntregarse( mensajero) {
    return self.estaPago() && destinos.all({destino => destino.puedeEntrar(mensajero)})
  }
}

object paqueteAzul {
  var pastillas = 1
  var precio = 50
  var destino=puenteBrooklyn 
  method cantPastillas(num) {
    pastillas = num
  }
  
  method precio() = 50 * pastillas
  
  method pagar(cant) {
    precio = 0
  }
  method cambiarDestino(nuevoDestino){
    destino = nuevoDestino
  }
  
  method estaPago() = precio == 0
  
  method valor() = self.precio()
  
  method puedeEntregarse( mensajero) {
    return self.estaPago() && destino.puedeEntrar(mensajero)
  }
}