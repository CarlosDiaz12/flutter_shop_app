import 'package:flutter/material.dart';
import 'package:flutter_shop_app/pages/edit_product_page.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final Function(String) onDelete;
  const UserProductItem({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.id,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductPage.routeName, arguments: id);
            },
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete.call(id);
            },
            color: Theme.of(context).errorColor,
          ),
        ],
      ),
    );
  }
}
