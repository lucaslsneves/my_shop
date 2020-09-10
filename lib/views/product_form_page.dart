import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  final Product product;

  ProductFormPage({this.product});

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageFocus = FocusNode();
  final _imageController = TextEditingController();
  bool _isLoading = false;

  void _updateImage() {
    if (!_isValidUrl(_imageController.text)) {
      return;
    }
    setState(() {});
  }

  @override
  void initState() {
    if (widget.product != null) {
      _imageController.text = widget.product.imageUrl;
    }
    _imageFocus.addListener(_updateImage);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageFocus.removeListener(_updateImage);
    _imageController.dispose();
    _imageFocus.dispose();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    bool isValidProtocol = url.toLowerCase().startsWith('http://') ||
        url.toLowerCase().startsWith('https://');
    if (!isValidProtocol) {
      return false;
    }
    return true;
  }

  void _saveForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    
setState((){
  _isLoading = true;
});
      if (widget.product == null) {
       
        final product = Product(
            description: _formData['description'],
            imageUrl: _formData['url'],
            price: double.tryParse(_formData['price']),
            title: _formData['title']);
        bool response = await Provider.of<Products>(context, listen: false)
            .addProduct(product);
        if (!response) {
          await showDialog<Null>(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text('Ocorreu um erro'),
                    content: Text('O produto não foi adicionado'),
                    actions: [
                      FlatButton(
                        child: Text('ok'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ));
        }
       
      } else {
        final product = Product(
            id: widget.product.id,
            description: _formData['description'],
            imageUrl: _formData['url'],
            price: double.tryParse(_formData['price']),
            title: _formData['title']);
       await Provider.of<Products>(context, listen: false).updateProduct(product);

     
      }  
  _isLoading = false;
  Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(),
          )
        ],
        title: Text('Formulário de produtos'),
      ),
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : widget.product == null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        TextFormField(
                          validator: (String value) {
                            if (value.trim().isEmpty) {
                              return 'Este campo é obrigatório';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _formData['title'] = value;
                          },
                          decoration: InputDecoration(labelText: 'Título'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (String value) {
                            FocusScope.of(context).requestFocus(_priceFocus);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (String value) {
                            if (value.trim().isEmpty) {
                              return 'Este campo é obrigatório';
                            }
                            final parsedValue = double.tryParse(value);
                            if (parsedValue < 0) {
                              return 'Digite um preço válido';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _formData['price'] = value;
                          },
                          decoration: InputDecoration(labelText: 'Preço'),
                          focusNode: _priceFocus,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (String value) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocus);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (String value) {
                            if (value.trim().isEmpty) {
                              return 'Este campo é obrigatório';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _formData['description'] = value;
                          },
                          decoration: InputDecoration(labelText: 'Descrição'),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocus,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.trim().isEmpty) {
                                    return 'Este campo é obrigatório';
                                  }
                                  if (!_isValidUrl(value)) {
                                    return 'Url inválida';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  _formData['url'] = value;
                                },
                                decoration:
                                    InputDecoration(labelText: 'URL da imagem'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                focusNode: _imageFocus,
                                controller: _imageController,
                                onFieldSubmitted: (_) {
                                  _saveForm();
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: _imageController.text.isEmpty
                                  ? Text('Informe a URL')
                                  : Image.network(_imageController.text),
                              margin: const EdgeInsets.only(left: 10),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.purple, width: 1)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        TextFormField(
                          initialValue: widget.product.title,
                          validator: (String value) {
                            if (value.trim().isEmpty) {
                              return 'Este campo é obrigatório';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _formData['title'] = value;
                          },
                          decoration: InputDecoration(labelText: 'Título'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (String value) {
                            FocusScope.of(context).requestFocus(_priceFocus);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: '${widget.product.price}',
                          validator: (String value) {
                            if (value.trim().isEmpty) {
                              return 'Este campo é obrigatório';
                            }
                            final parsedValue = double.tryParse(value);
                            if (parsedValue < 0) {
                              return 'Digite um preço válido';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _formData['price'] = value;
                          },
                          decoration: InputDecoration(labelText: 'Preço'),
                          focusNode: _priceFocus,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (String value) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocus);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.product.description,
                          validator: (String value) {
                            if (value.trim().isEmpty) {
                              return 'Este campo é obrigatório';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _formData['description'] = value;
                          },
                          decoration: InputDecoration(labelText: 'Descrição'),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocus,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.trim().isEmpty) {
                                    return 'Este campo é obrigatório';
                                  }
                                  if (!_isValidUrl(value)) {
                                    return 'Url inválida';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  _formData['url'] = value;
                                },
                                decoration:
                                    InputDecoration(labelText: 'URL da imagem'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                focusNode: _imageFocus,
                                controller: _imageController,
                                onFieldSubmitted: (_) {
                                  _saveForm();
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: _imageController.text.isEmpty
                                  ? Text('Informe a URL')
                                  : Image.network(_imageController.text),
                              margin: const EdgeInsets.only(left: 10),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.purple, width: 1)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
