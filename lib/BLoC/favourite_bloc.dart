import 'dart:async';

import '../DataLayer/restaurant.dart';
import 'bloc.dart';

class FavouriteBloc implements Bloc {
  var _restaurants = Set<Restaurant>();
  Set<Restaurant> get favourites => _restaurants;
  final _controller = StreamController<List<Restaurant>>.broadcast();

  Stream<List<Restaurant>> get favouritesStream => _controller.stream;

  void toggleFavourite(Restaurant restaurant) {
    if (_restaurants.contains(restaurant)) {
      _restaurants.remove(restaurant);
    } else {
      _restaurants.add(restaurant);
    }

    _controller.sink.add(_restaurants.toList());
  }

  @override
  void dispose() {
    _controller.close();
  }
}