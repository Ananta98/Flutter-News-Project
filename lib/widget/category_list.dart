import 'package:flutter/material.dart';
import 'package:flutter_news_app/widget/category_card.dart';

class CategoryModel {
  String imageAssetUrl;
  String categoryName;

  CategoryModel({required this.imageAssetUrl, required this.categoryName});
}

// ignore: must_be_immutable
class CategoryListCard extends StatelessWidget {
  CategoryListCard({super.key});

  List<CategoryModel> categories = [
    CategoryModel(
        imageAssetUrl:
            "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80",
        categoryName: "Bussiness"),
    CategoryModel(
        imageAssetUrl:
            "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
        categoryName: "Entertaiment"),
    CategoryModel(
        imageAssetUrl:
            "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
        categoryName: "General"),
    CategoryModel(
        imageAssetUrl:
            "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80",
        categoryName: "Health"),
    CategoryModel(
        imageAssetUrl:
            "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80",
        categoryName: "Science"),
    CategoryModel(
        imageAssetUrl:
            "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80",
        categoryName: "Sports"),
    CategoryModel(
        imageAssetUrl:
            "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
        categoryName: "Technology")
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: categories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
         return CategoryCard(
          imageUrl: categories[index].imageAssetUrl,
          categoryName: categories[index].categoryName,
         );
      }),
    );
  }
}
