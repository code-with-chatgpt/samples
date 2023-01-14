import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  final Map recipe;
  RecipeScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe['title']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(widget.recipe['image']),
            Text(widget.recipe['title']),
            Text('Missing Ingredients:'),
            Expanded(
              child: ListView.builder(
                itemCount: widget.recipe['missedIngredients'] != null ? widget.recipe['missedIngredients'].length : 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.recipe['missedIngredients'][index]['name']),
                  );
                },
              ),
            ),
            Text('Used Ingredients:'),
            Expanded(
              child: ListView.builder(
                itemCount: widget.recipe['usedIngredients'] != null ? widget.recipe['usedIngredients'].length : 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.recipe['usedIngredients'][index]['name']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}