# C10

Modificaremos la aplicación para que tengamos una lista de contadores según el modelo anterior.

APRENDER
- Parametro opcional en el modelo, vs posicionales o nombrados. 
- Ajustamos la columna arriba. Eliminamos Center y establecemos ajustes de layout
- Manejo de listas con add y aplanamiento ...

CORREGIR
- SE PRODUCE UN ERROR
   Bottom Ovwerflowed BY XX Pixels
- TAMPOCO PODEMOS HACER SCROLL
   Obliga a covertir la Column a ListView
   
```dart
// El modelo
class Contador {
  String nombre;
  int valor;
  Contador(this.nombre, [this.valor = 0]);

  // Podríamos haber introducido aquí el meodode incrementar
}
```

Manejo de listas de Widgets
```dart
   children: <Widget>[
      // lista de widgets..
      // aplanamiento de listas
      for (var item in _list) ...[
         // lista de widgets por cada contador
      ]),
      ],
          
```