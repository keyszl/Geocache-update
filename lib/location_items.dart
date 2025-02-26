import 'package:flutter/material.dart';
import 'package:geocaching_app/compass.dart';

class Item {
  const Item(
      {required this.name, required this.latitude, required this.longitude});
      //

  final String name;
  final double latitude;
  final double longitude;
  //final String subtitle;
}

typedef LocationChangedCallback = Function(Item item, bool saved);

class LocationItem extends StatelessWidget {
  LocationItem({
    required this.item,
    required this.saved,
    required this.onListChanged,
  }) : super(key: ObjectKey(item));

  final Item item;
  //final double latitude;
  //final double longitude;
  final bool saved;
  final LocationChangedCallback onListChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return saved //
        ? Colors.green
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!saved) return null;

    return const TextStyle(
      color: Colors.black54,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(
          item, 
          saved
          );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompassScreen(item: item),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://www.iconpacks.net/icons/2/free-location-pin-icon-3090-thumb.png'),
        backgroundColor: Color.fromARGB(0, 231, 230, 230),
      ),
      title: Text(
        item.name,
        style: _getTextStyle(context),
      ),
      subtitle: Text("(" +
         item.latitude.toString() +
          ", " +
          item.longitude.toString() +
          ")"),
    );
  }
}
