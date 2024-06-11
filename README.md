# FakeStore Repository

Paquete de clases donde se ofrecen modelos de datos y repositorios para consulta de la api FakeStore.
Incluye filtrado y criterios de búsqueda para los servicios que lo admiten.

## Features

- Obtener listado de usuarios (admite criterios de búsqueda).
- Obtener listado de categorías.
- Obtener listado de productos (admite criterios de búsqueda y filtros).
- Servicio de login.

## Getting started

Para comenzar a usar el paquete solo debes agregarlo en tu pubspec.yaml
de la siguiente manera:

```yaml
  fake_store_repository:
   git: 
    url: https://github.com/andre-duquec-pragma/flutter_challenge_gryffindor_fase_3
    ref: main
```

Luego de tenerlo en tu proyecto tendrás disponible 5 funciones para realizar tus consultas:

- login
- getCategories
- getProducts
- getProductById
- getUsers

Cada uno de estos está preparada para realizar operaciones asíncronas y responder con un error o con el modelo de datos definidos.

El valor de retorno de cada una de las funciones mencionadas es un dato tipo 'Either' donde el lado izquierdo corresponde a un error de tipo 'DataError' y el derecho corresponderá al modelo especifico de datos de cada función.

El modelo 'DataError' hereda de la clase 'Error' y contiene una propiedad llamada 'message'. Esta propiedad es la que va a contener el mensaje específico del error.

Ahora, algunos de los servicios admiten criterios de filtrado y búsqueda. Así que veamos como usarlos:

Tenemos dos criterios de búsqueda:

- LimitCriteria: Este criterio hace referencia a la cantidad máxima de resultados que queremos obtener en la lista final obtenida de la api.

```dart
    /// al momento de instanciar el objeto podremos definir el número limite de resultados
    const limitCriteria = LimitCriteria(limit: 3);
```

- OrderCriteria: Este criterio hace referencia al orden en el que queremos obtener una lista de resultados. Puede ser de manera ascendente o descendente. Puede recibir solo dos valores como parámetros: FilterOrder.asc o FilterOrder.desc

```dart
    /// al momento de instanciar el objeto podremos definir el orden de los resultados
    const sortCriteria = OrderCriteria(order: FilterOrder.asc);
```

Adicionalmente también te tenemos un criterio de filtrado que sirve para las consultas relacionadas con próductos:

- FilterByCategoryCriteria: Este criterio nos permitirá realizar un filtro sobre los productos a consular y obtener solo los productos de una categoría en específico.

```dart
    /// al momento de instanciar el objeto podremos definir la categoría deseada.
    const filterCriteria = FilterByCategoryCriteria(category: "electronics");
```

Estos criterios no son obligatorios al momento de realizar una petición a la api, sin embargo los podemos combinar de la manera que deseemos para obtener resultados mas ordenados.

Los criterios de búsqueda se encuentran disponibles para las siguientes funciones:

- getProducts
- getUsers

Los criterios de filtrado se encuentran disponibles para las siguientes funciones:

- getProducts

Estos criterios se pueden combinar, pues las funciones que los usan están preparadas para recibir, uno, varios o ninguno.

Un ejemplo de como usarlos sería el siguiente:

```dart
    /// Products limit by 2 and desc order

    final productsResponseByCategories = await getProducts(
      criteria: [
        const LimitCriteria(limit: 3),
      ],
      filters: [
        const FilterByCategoryCriteria(category: "electronics"),
      ],
    );
```

Y el consumo de un servicio sin criterios de búsqueda sería el siguiente:

```dart
    final products = await getProducts();
```

# Funciones

## getProducts

Esta función nos permite obtener una lista de productos de manera asíncrona.
Retorna un valor de tipo Either donde el lado izquierdo corresponde a un error y el lado derecho corresponde a un lista de objetos tipo ProductResponse.

Para obtener todos los productos basta con ejecutar la función.

```dart
    final products = await getProducts();
    
    products.fold(
      (error) {
        /// Bloque de código para error
      },
      (products) {
        /// Bloque de código donde se tiene acceso a los productos obtenidos
      },
    );
```

Nota: Esta función admite criterios de búsqueda y filtrado.

## getProductById

Esta función nos permite obtener un producto en específico de manera asíncrona.
Retorna un valor de tipo Either donde el lado izquierdo corresponde a un error y el lado derecho corresponde a un objeto de tipo ProductResponse.

En caso de no encontrar el producto solicitado retornara un Either con un error.

La función recibe como parámetro un entero que corresponde al id del producto a buscar.

```dart
    final product = await getProductsById(id: 1);
    
    product.fold(
      (error) {
        /// Bloque de código para error
      },
      (item) {
        /// Bloque de código donde se tiene acceso al producto obtenido.
      },
    );
```

## login

Esta función nos permite realizar una operación asíncrona para autenticar a un usuario y obtener un token.
Retorna un valor de tipo Either donde el lado izquierdo corresponde a un error y el lado derecho corresponde a un objeto de tipo LoginResponse.

La función recibe como parámetro un objeto de tipo LoginRequest que corresponde a la data del usuario que vamos a autenticar. Específicamente hace contiene el usuario y contraseña del usuario.

```dart
const loginRequest = LoginRequest(
  username: "mor_2314",
  password: "83r5^_",
);

final loginResponse = await login(request: loginRequest);

loginResponse.fold(
  (error) {
    /// Bloque de código para error
  },
  (response) {
    /// Bloque de código donde se tiene acceso al token del usuario
  },
);
```

## getUsers

Esta función nos permite obtener una lista de usuarios previamente registrados en la "fakestore" de manera asíncrona.
Retorna un valor de tipo Either donde el lado izquierdo corresponde a un error y el lado derecho corresponde a un lista de objetos tipo UserResponse.

Para obtener todos los usuarios basta con ejecutar la función.

```dart
    final users = await getUsers();
    
    users.fold(
      (error) {
        /// Bloque de código para error
      },
      (products) {
        /// Bloque de código donde se tiene acceso a los usuarios obtenidos
      },
    );
```

Nota: Esta función admite criterios de búsqueda.

## getCategories

Esta función nos permite obtener de manera asíncrona. la lista de categorías disponibles para los productos.
Retorna un valor de tipo Either donde el lado izquierdo corresponde a un error y el lado derecho corresponde a un objeto de tipo CategoriesResponse.

Para obtener todos los usuarios basta con ejecutar la función.

```dart
    final categories = await getCategories();
    
    categories.fold(
      (error) {
        /// Bloque de código para error
      },
      (products) {
        /// Bloque de código donde se tiene acceso a las categorías obtenidas
      },
    );
```

# Modelos

## UserResponse

Modelo de datos para representar la data de un usuario.
Está compuesto de los siguientes atributos:

- address: Objeto compuesto que contiene toda la información de la dirección.
- id: Entero que representa una identificación para el usuario.
- email: Texto que representa la dirección de correo electrónico del usuario.
- username: Texto que representa el nombre de usuario.
- password: Texto que representa la contraseña del usuario.
- name: Objeto compuesto que contiene toda la información del nombre del usuario.
- phone: Texto que representa el teléfono del usuario.

Todos sus atributos pueden ser nulos.

## ProductResponse

Modelo de datos para representar la data de un producto.
Está compuesto de los siguientes atributos:

- id: Entero que representa una identificación para el usuario.
- title: Texto que representa el nombre del producto.
- price: Número real que representa el precio del producto.
- description: Texto que representa una descripción detallada del usuario.
- category: Texto que representa la categoría especifica a la que pertenece el producto.
- rating: Objeto compuesto que contiene toda la información de las calificaciones del producto.
- image: Texto que representa una url donde se encuentra almacenada la imagen correspondiente para el producto.

Todos sus atributos pueden ser nulos.

## CategoriesResponse

Modelo de datos para representar la lista de categorías de los productos.
Está compuesto de los siguientes atributos:

- data: Una lista en la que cada item es un texto que representa una categoría.

La lista puede estar vacía.

## LoginResponse

Modelo de datos para representar el resultado obtenido luego de realizar un proceso de autenticación de un usuario.
Está compuesto de los siguientes atributos:

- token: Un texto que representa una token de autenticación para el usuario.
