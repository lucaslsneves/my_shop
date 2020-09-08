
import 'package:flutter/material.dart';
enum ProductFormState {
  initial,error,loading,loaded
}

class ProductFormPage extends StatefulWidget {
  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageFocus = FocusNode();
  final _imageController = TextEditingController();
  ProductFormState state = ProductFormState.initial;
  
  void _updateImage() {
    try{
      setState(() {
        ProductFormState.loading;
      });
    }catch(e) {

    }
  }

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CNB HyperX tksh'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
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
                decoration: InputDecoration(labelText: 'Preço'),
                focusNode: _priceFocus,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
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
                      decoration: InputDecoration(labelText: 'URL da imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageFocus,
                      controller: _imageController,
                      onFieldSubmitted: (_) {
                        setState(() {
                          
                        });
                      } ,
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
                        border: Border.all(color: Colors.purple, width: 1)),
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
