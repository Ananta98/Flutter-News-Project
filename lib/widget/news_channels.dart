import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/source_controller.dart';
import 'package:flutter_news_app/screen/source_details.dart';
import 'package:get/get.dart';

class NewsChannels extends StatelessWidget {
  const NewsChannels({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SourceController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 115,
      child: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SourceDetails(
                                  model: controller.sources[index])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/logos/${controller.sources[index].id}.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.sources[index].name,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              height: 1.4,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          controller.sources[index].category,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              height: 1.4,
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                              fontSize: 9.0),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
