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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reto Flutter Fase 3'),
      ),
      body: _buildList(),
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

  Future _loadProducts() async {
    final products = await widget.productsRepository.get(
      criteria: [
        const LimitCriteria(limit: 10),
      ],
    );

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

  Future _loadCategories() async {
    final categories = await widget.categoriesRepository.get();

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

  Future _loadUsers() async {
    final users = await widget.usersRepository.get();

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
