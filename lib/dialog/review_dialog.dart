import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tcc/providers/review_doc.dart';

class ReviewCreateDialog extends StatefulWidget {
  @override
  _ReviewCreateDialogState createState() => _ReviewCreateDialogState();
}

class _ReviewCreateDialogState extends State<ReviewCreateDialog> {
  double rating = 0;
   String review ='';

  @override
  Widget build(BuildContext context) {
    Color color = rating == 0 ? Colors.grey : Colors.amber;
    return AlertDialog(
      title: Text('Adicione um comentário'),
      content: Container(
        width: math.min(MediaQuery.of(context).size.width, 740),
        height: math.min(MediaQuery.of(context).size.height, 180),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: SmoothStarRating(
                starCount: 5,
                rating: rating,
                color: color,
                borderColor: Colors.grey,
                size: 32,
                onRated: (value) {
                  if (mounted) {
                    rating = value;
                  }
                },
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: 'Deixe seu comentário.'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) {
                  if (mounted) {
                    setState(() {
                      review = value;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.pop(context, null),
        ),
        ElevatedButton(
          child: Text('Salvar'),
          onPressed: () => Navigator.pop(
            context,
            Review.fromUserInput(rating: rating, text: review
          
            ),
          ),
        ),
      ],
    );
  }
}
