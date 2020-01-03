import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/favourite_bloc.dart';
import 'package:restaurant_finder/UI/restaurant_tile.dart';

import '../DataLayer/restaurant.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavouriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: StreamBuilder(
        stream: bloc.favouritesStream,
        initialData: bloc.favourites.toList(),
        builder: (context, snapshot) {
          List<Restaurant> favourites = 
            (snapshot.connectionState == ConnectionState.waiting)
              ? bloc.favourites.toList()
              : snapshot.data;

          if (favourites == null || favourites.isEmpty) {
            return Center(child: Text('No favourites'),); 
          }

          return ListView.separated(
            itemCount: favourites.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final restaurant = favourites[index];
              return RestaurantTile(restaurant: restaurant,);
            },
          );
        },
      ),
    );
  }
}