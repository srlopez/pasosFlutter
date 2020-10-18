# C00

Ejemplo inicial tras `flutter create c00`. 
Es la aplicación de contador con alguna modificación. 

APRENDER:
- Esquema general de una aplicación Flutter
- Stateful vs Stateless Widget
- setState  
  


Esquema general
```dart
    void main() {
    runApp(MyApp());
    }

    class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
    ...
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
    }
    }

    class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);
    final String title;

    @override
    _MyHomePageState createState() => _MyHomePageState();
    }

    class _MyHomePageState extends State<MyHomePage> {
    ...
    @override
    Widget build(BuildContext context) {
    return Scaffold(
    ...
        body: 
    ...
        );
    }
    }
```

Ver la diferencia de un `StatelessWidget` y un `StatefulWidget` con `State`

La llamada a `setState` le dice al framework que algo
cambiaó en este `estado`, lo que hace que se vuelva a ejecutar el método de `build` a continuación para que la pantalla pueda reflejar los valores actualizados.  Se compara el arbol de elementos mostrados en pantalla, con el arbol de widgets reconstruido, y los elementos que cambian se pintan.

```dart
    setState(() {
        ...
    });
```