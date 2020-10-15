# C30

Modificamos la aplicación simplificando el modelo, le quitamos el Future<String>, y como el Widget queda afectado, así que retiramos el Future Builder.
El objetivo es sólo entender el comportamiento de un controlador de scroll

APRENDER
- Obtenemos el nombre de una Closure <- introducir closures
- Maneja un StreamController -  Controllers manejadores de bajo nivel
- La idea es simular un scroll continuo
  cuando desplacemos la lista hacia arriba se añade 1 contador
  y tambien añadimos el contador con el FloatingActionButton, y si no se hace scroll

MAS:
- Probar que Floating  añada a la lista y otro al stream
  habría que controlar el hashCode del Stream para no reañadir el ultimo cada vez