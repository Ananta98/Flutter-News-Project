import 'package:flutter/material.dart';
import 'package:flutter_news_app/screen/news_channels_list.dart';
import 'package:flutter_news_app/screen/profile.dart';
import 'package:flutter_news_app/widget/breaking_news.dart';
import 'package:flutter_news_app/widget/category_list.dart';
import 'package:flutter_news_app/widget/news_channels.dart';
import 'package:flutter_news_app/widget/popular_news_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn1.vectorstock.com/i/1000x1000/23/70/man-avatar-icon-flat-vector-19152370.jpg"),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Breaking News",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const BreakingNews(),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "News Channel",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewsChannelsList()));
                  },
                  child: const Text(
                    "More Channels",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const NewsChannels(),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Discover",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CategoryListCard(),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Hot News",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const PopularNewsList()
          ],
        ),
      ),
    );
  }
}
