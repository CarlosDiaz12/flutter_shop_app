import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit-product-page';
  const EditProductPage({Key? key}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _imageUrlCtrl = TextEditingController();
  var _product = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
    isFavorite: false,
  );

  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      var productId = ModalRoute.of(context)!.settings.arguments as String?;
      if (productId != null) {
        var product = Provider.of<ProductsProvider>(context, listen: false)
            .getProductById(productId);
        _product = product;
        _imageUrlCtrl.text = _product.imageUrl;
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (_product.id.isNotEmpty) {
          await Provider.of<ProductsProvider>(context, listen: false)
              .updateProduct(_product.id, _product);
        } else {
          await Provider.of<ProductsProvider>(context, listen: false)
              .addProduct(_product);
        }
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      final snackBar = SnackBar(
          content: Text(e.toString()),
          backgroundColor: Theme.of(context).colorScheme.error);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  String? _requiredValidator(value) {
    if (value != null && value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: _requiredValidator,
                      initialValue: _product.title,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _product.title = value ?? '';
                      },
                    ),
                    TextFormField(
                      initialValue: _product.price.toString(),
                      validator: _requiredValidator,
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _product.price = double.parse(value ?? '0');
                      },
                    ),
                    TextFormField(
                      validator: _requiredValidator,
                      initialValue: _product.description,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _product.description = value ?? '';
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _imageUrlCtrl.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlCtrl.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Flexible(
                          child: TextFormField(
                            validator: _requiredValidator,
                            controller: _imageUrlCtrl,
                            decoration: InputDecoration(
                              labelText: 'Image URL',
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _product.imageUrl = value ?? '';
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
