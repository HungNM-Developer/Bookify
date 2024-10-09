import 'package:flutter/material.dart';

import '../../../model/book.dart';
import '../../detail/detail.dart';
import 'category_title.dart';

class RecommendedBook extends StatelessWidget {
  final recommendedList = Book.generateRecommendedBook();
  RecommendedBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CategoryTitle('Recommended for you'),
        SizedBox(
          height: 250,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(20),
              itemBuilder: (_, index) {
                var book = recommendedList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailPage(book)));
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  book.imgUrl!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                book.name!,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              book.author!,
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          top: 10,
                          left: 10,
                          child: _buildIconText(
                              Icons.star, Colors.orange[300]!, '${book.score}'))
                    ],
                  ),
                );
              },
              separatorBuilder: (_, index) => const SizedBox(
                    width: 15,
                  ),
              itemCount: recommendedList.length),
        )
      ],
    );
  }

  Widget _buildIconText(IconData icon, Color color, String text) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 14,
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            text,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          )
        ],
      ),
    );
  }
}
