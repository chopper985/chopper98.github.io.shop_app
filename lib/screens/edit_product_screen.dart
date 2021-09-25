import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = new FocusNode();
  final _descriptionFocusNode = new FocusNode();
  final _urlImageFocusNode = new FocusNode();
  final _titleController = new TextEditingController();
  final _priceController = new TextEditingController();
  final _urlImageController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  final _formkey = new GlobalKey<FormState>();
  var _editProduct = Product(
      id: null as String, title: '', price: 0, description: '', imageUrl: '');
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    _urlImageFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _urlImageController.dispose();
    _priceController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _urlImageFocusNode.removeListener(() => _updateImage);
    _urlImageFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productID = ModalRoute.of(context)!.settings.arguments as String;
      if (productID != null) {
        _editProduct = Provider.of<Products>(context).findID(productID);
        _urlImageController.text = _editProduct.imageUrl;
        _titleController.text = _editProduct.title;
        _descriptionController.text = _editProduct.description;
        _priceController.text = _editProduct.price.toString();
        print(_urlImageController.text);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImage() {
    if (!_urlImageFocusNode.hasFocus ||
        (_urlImageController.text.isEmpty) ||
        (!_urlImageController.text.endsWith('png') &&
            !_urlImageController.text.endsWith('jpg') &&
            !_urlImageController.text.endsWith('jpeg')) ||
        (!_urlImageController.text.startsWith('http') &&
            !_urlImageController.text.startsWith('https'))) {
      setState(() {});
    }
  }

  Future<void> _saveProduct() async {
    final valid = _formkey.currentState!.validate();
    if (!valid) {
      return;
    }
    _formkey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    // ignore: unnecessary_null_comparison
    if (_editProduct.id == null) {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editProduct);
      } catch (e) {
        showDialog<Null>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('An error occurred!'),
                  content: Text('Something went wrong.'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Okey'))
                  ],
                ));
      }
    } else {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editProduct.id, _editProduct);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Product',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).primaryColor))),
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter a title!';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          _editProduct = Product(
                              id: _editProduct.id,
                              title: val!,
                              description: _editProduct.description,
                              price: _editProduct.price,
                              imageUrl: _editProduct.imageUrl,
                              isFavorite: _editProduct.isFavorite);
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                            labelText: 'Price',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).primaryColor))),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter a price!';
                          }
                          if (double.tryParse(val) == null) {
                            return 'Please enter a valid number!';
                          }
                          if (double.parse(val) <= 0) {
                            return 'Please enter a number great!';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          _editProduct = Product(
                              id: _editProduct.id,
                              title: _editProduct.title,
                              description: _editProduct.description,
                              price: double.parse(val!),
                              imageUrl: _editProduct.imageUrl,
                              isFavorite: _editProduct.isFavorite);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).primaryColor))),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_urlImageFocusNode);
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter a description!';
                          }
                          if (val.length <= 10) {
                            return 'Should be at least 10 characters long!';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          _editProduct = Product(
                              id: _editProduct.id,
                              title: _editProduct.title,
                              description: val!,
                              price: _editProduct.price,
                              imageUrl: _editProduct.imageUrl,
                              isFavorite: _editProduct.isFavorite);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.grey)),
                              child: _urlImageController.text.isEmpty
                                  ? Center(child: Text('No image'))
                                  : FittedBox(
                                      child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/circle.gif',
                                      image: _urlImageController.text.toString(),
                                      fit: BoxFit.cover,
                                    ))),
                          Expanded(
                            child: TextFormField(
                              onFieldSubmitted: (_) {
                                _saveProduct();
                              },
                              decoration: InputDecoration(
                                  labelText: 'UrlImage',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          width: 2,
                                          color:
                                              Theme.of(context).primaryColor))),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.url,
                              focusNode: _urlImageFocusNode,
                              controller: _urlImageController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please enter a url!';
                                }
                                if (!val.startsWith('http') &&
                                    !val.startsWith('https')) {
                                  return 'Please enter a valid url';
                                }
                                if (!val.endsWith('png') &&
                                    !val.endsWith('jpg') &&
                                    !val.endsWith('jpeg')) {
                                  return 'Please enter a valid image url';
                                }

                                return null;
                              },
                              onSaved: (val) {
                                _editProduct = Product(
                                    id: _editProduct.id,
                                    title: _editProduct.title,
                                    description: _editProduct.description,
                                    price: _editProduct.price,
                                    isFavorite: _editProduct.isFavorite,
                                    imageUrl: val!);
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () => _saveProduct(),
                              child: Text('Save Product'))),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
