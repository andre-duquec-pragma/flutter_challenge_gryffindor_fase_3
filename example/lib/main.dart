import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge_gryffindor_fase_3/flutter_challenge_gryffindor_fase_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fase 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // Comencemos por instanciar los tres repositorios principales de nuestro paquete.
  final ProductsRepository productsRepository = ProductsRepositoryImpl();
  final UsersRepository usersRepository = UsersRepositoryImpl();
  final CategoriesRepository categoriesRepository = CategoriesRepositoryImpl();

  MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  List<Map<String, String>> data = [];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _onItemTapped(_selectedIndex);
    });
  }

  /// Ahora, creamos una barra de navegación inferior y creamos 3 pantallas,
  /// donde cada una es la encargada de usar uno de los repos anteriormente definidos.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reto Flutter Fase 3'),
      ),
      body: Column(
        children: [
          _buildList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Usuarios',
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }

  /// Esta función nos servira para ejecutar una acción diferente cada que cambiemos de patalla.
  Future _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
      isLoading = true;
    });

    List<AsyncCallback> actions = [
      _loadProducts,
      _loadCategories,
      _loadUsers,
    ];

    actions[index]();
  }

  /// Con esta función podemos cargar una lista de productos desde la api de FakeStore.
  Future _loadProducts() async {
    /// Vamos a usar la función [get] de [productsRepository]
    /// Esta función nos traera todo el listado de productos disponibles.
    ///
    /// Para que el ejemplo sea más rápido vamos a usar un criterio de limite para que la consulta solo traiga 10 productos.
    final products = await widget.productsRepository.get(
      criteria: [
        const LimitCriteria(limit: 10),
      ],
    );

    /// Luego de esto obtendremos el resultado de nuestra consulta en un dato tipo Either
    /// En este el elemento izquierdo represeta un error y el elemento derecho representa la data obtenida.
    /// Para este ejemplo realizaremos un mapeo de la data para obtener solo los datos necesarios.
    products.fold(
      (error) {
        _updateState([]);
      },
      (products) {
        final newData = products
            .map(
              (e) => {"title": e.title ?? "", "subtitle": e.price.toString()},
            )
            .toList();

        _updateState(newData);
      },
    );
  }

  /// Con esta función podemos cargar una lista de categorias desde la api de FakeStore.
  Future _loadCategories() async {
    /// Vamos a usar la función [get] de [categoriesRepository]
    /// Esta función nos traera todo el listado de categorias disponibles.
    final categories = await widget.categoriesRepository.get();

    /// Luego de esto obtendremos el resultado de nuestra consulta en un dato tipo Either
    /// En este el elemento izquierdo represeta un error y el elemento derecho representa la data obtenida.
    /// Para este ejemplo realizaremos un mapeo de la data para obtener solo los datos necesarios.
    categories.fold(
      (_) {
        _updateState([]);
      },
      (categories) {
        final newData = categories.data
            .map(
              (e) => {"title": e, "subtitle": ""},
            )
            .toList();

        _updateState(newData);
      },
    );
  }

  /// Con esta función podemos cargar una lista de categorias desde la api de FakeStore.
  Future _loadUsers() async {
    /// Vamos a usar la función [get] de [usersRepository]
    /// Esta función nos traera todo el listado de usuarios disponibles.
    final users = await widget.usersRepository.get();

    /// Luego de esto obtendremos el resultado de nuestra consulta en un dato tipo Either
    /// En este el elemento izquierdo represeta un error y el elemento derecho representa la data obtenida.
    /// Para este ejemplo realizaremos un mapeo de la data para obtener solo los datos necesarios.
    users.fold(
      (_) {
        _updateState([]);
      },
      (users) {
        final newData = users
            .map(
              (e) => {"title": e.name?.firstName ?? "", "subtitle": e.email ?? ""},
            )
            .toList();

        _updateState(newData);
      },
    );
  }

  /// Esta es la función que nos permitirá asignar la nueva data para que corresponda con la pantalla seleccionada.
  void _updateState(List<Map<String, String>> newData) {
    setState(() {
      isLoading = false;
      data = newData;
    });
  }

  Widget _buildList() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data.isEmpty) {
      return _buildButton();
    }

    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (builderContext, index) {
          Map item = data[index];

          return ListTile(
            title: Text(
              item["title"] ?? "",
            ),
            subtitle: Text(item['subtitle']),
          );
        },
      ),
    );
  }

  Widget _buildButton() {
    return Center(
      child: IconButton(
        icon: const Icon(Icons.download),
        onPressed: () async {
          await _onItemTapped(_selectedIndex);
        },
      ),
    );
  }
}
