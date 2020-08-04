import 'package:flutter/material.dart';

class EditRecipe extends StatefulWidget {
  static const routeName = '/edit_recipe';
  @override
  _EditRecipeState createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  int _difficultyChoice = 1;
  final _timeFocusNode = FocusNode();
  final _caloriesFocusNode = FocusNode();

  setChoice(int value) {
    setState(() {
      _difficultyChoice = value;
      print('Value $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Recipe Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_timeFocusNode);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Time',
                      ),
                      focusNode: _timeFocusNode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_caloriesFocusNode);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Calories',
                      ),
                      focusNode: _caloriesFocusNode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _difficultyChoice,
                          onChanged: (value) {
                            setChoice(value);
                          },
                        ),
                        Text(
                          'EASY',
                          style: TextStyle(
                            fontSize: 16.0,
                            //fontFamily: kSourceSansPro,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _difficultyChoice,
                          onChanged: (value) {
                            setChoice(value);
                          },
                        ),
                        Text(
                          'MEDIUM',
                          style: TextStyle(
                            fontSize: 16.0,
                            //fontFamily: kSourceSansPro,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 3,
                          groupValue: _difficultyChoice,
                          onChanged: (value) {
                            setChoice(value);
                          },
                        ),
                        Text(
                          'HARD',
                          style: TextStyle(
                            fontSize: 16.0,
                            //fontFamily: kSourceSansPro,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: new Text(
                    'Ingredient',
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: <Widget>[
                    new Column(
                      children: [
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timeFocusNode.dispose();
    _caloriesFocusNode.dispose();
    super.dispose();
  }
}
