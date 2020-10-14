En este ejmplo mostramos

- Simplificamos el modelo y le quitamos el Future<String>
  El Widget queda afectado, así que retiramos el Future Builder
  Obtenemos el nombre de una Closure <- introducir closures

- La idea es simular un scroll continuo
  cuando desplacemos la lista hacia arriba se añade 1 contador
  y tambien añadimos el contador con el FloatingActionButton, y si no se hace scroll

MAS:
- Probar que Floating  añada a la lista y otro al stream
  habría que controlar el hashCode del Stream para no reañadir el ultimo cada vez