Paquete de clases donde se ofrecen modelos de datos y repositorios para consulta de la api FakeStore.
Incluye filtrado y criterios de búsqueda para los servicios que lo admiten.

## Features

- Obtener listado de usuarios (admite criterios de búsqueda).
- Obtener listado de categorias.
- Obtener listado de productos (admite criterios de búsqueda y filtros).
- Servicio de login.

## Getting started

Para comenzar a usar el paquete solo debes agregarlo en tu pubspec.yaml
de la siguiente manera:

```yaml
  flutter_challenge_gryffindor_fase_3:
   git: 
    url: https://github.com/andre-duquec-pragma/flutter_challenge_gryffindor_fase_3
    ref: main
```

Luego de tenerlo en tu proyecto tendras dispobible 4 repositorios para realizar tus consultas:

- AuthRepository
- CategoriesRepository
- ProductsRepository
- UsersRepository

Cada uno de estos está preparada para realizar operaciones asincronas y responder con un error o con el modelo de datos definidos.

Algunos de los servicios admiten criterios de filtrado. Así que veamos como usarlos:

```dart
    ProductsRepository productsRepository = ProductsRepositoryImpl();

    // Products limit by 2 and desc order

    final productsResponseByCategories = await productsRepository.get(
      criteria: [
        const LimitCriteria(limit: 3),
      ],
      filters: [
        const FilterByCategoryCriteria(category: "electronics"),
      ],
    );
```

Estos criterios no son obligatorios al momento de realizar una petición a la api, sin embargo los podemos combinar de la manera que deseemos para obtener resultados mas ordenados.

El consumo de un servicio sin criterios de busquedad sería el siguiente:

```dart
AuthRepository authRepository = AuthRepositoryImpl();

const loginRequest = LoginRequest(
  username: "mor_2314",
  password: "83r5^_",
);

final loginResponse = await authRepository.login(request: loginRequest);
```