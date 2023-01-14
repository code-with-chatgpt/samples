import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'recipe_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Finder',
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _ingredients;
  List _recipes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Finder'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Ingredients (comma-separated)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some ingredients';
                }
                return null;
              },
              onSaved: (value) {
                _ingredients = value.toString();
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  _searchRecipes(_ingredients);
                }
              },
              child: Text('Search'),
            ),
            Expanded(
              child: _buildResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    if (_recipes == null) {
      return Container();
    }
    return ListView.builder(
      itemCount: _recipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_recipes[index]['title']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeScreen(recipe: _recipes[index]),
              ),
            );
          },
        );
      },
    );
  }

  void _searchRecipes(String ingredients) async {
    final response = await http.get(
      Uri.parse('https://api.spoonacular.com/recipes/findByIngredients?ingredients=$ingredients&apiKey=c5631638a3ec4c7d96e02b956507a388'),
    );
    if (response.statusCode == 200) {
      setState(() {
        _recipes = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}


