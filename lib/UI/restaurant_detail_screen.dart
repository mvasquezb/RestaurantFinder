import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/favourite_bloc.dart';

import '../DataLayer/restaurant.dart';
import 'image_container.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({Key key, this.restaurant}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildBanner(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  restaurant.cuisines,
                  style: textTheme.subtitle.copyWith(fontSize: 18),
                ),
                Text(
                  restaurant.address,
                  style: textTheme.subtitle.copyWith(fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          _buildDetails(context),
          _buildFavouriteButton(context)
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return ImageContainer(
      height: 200,
      url: restaurant.imageUrl,
    );
  }

  Widget _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 16);

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Price: ${restaurant.priceDisplay}',
            style: style,
          ),
          SizedBox(width: 40),
          Text(
            'Rating: ${restaurant.rating.average}',
            style: style,
          ),
        ],
      ),
    );
  }

  Widget _buildFavouriteButton(BuildContext context) {
    final bloc = BlocProvider.of<FavouriteBloc>(context);
    return StreamBuilder<List<Restaurant>>(
      stream: bloc.favouritesStream,
      initialData: bloc.favourites.toList(),
      builder: (context, snapshot) {
        List<Restaurant> favourites =
            (snapshot.connectionState == ConnectionState.waiting)
                ? bloc.favourites.toList()
                : snapshot.data;
        bool isFavourite = favourites.contains(restaurant);

        return FlatButton.icon(
          onPressed: () => bloc.toggleFavourite(restaurant),
          textColor: isFavourite ? Theme.of(context).accentColor : null,
          icon: Icon(isFavourite ? Icons.favorite : Icons.favorite_border),
          label: Text('Favourite'),
        );
      },
    );
  }
}