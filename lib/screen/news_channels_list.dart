import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/source_controller.dart';
import 'package:flutter_news_app/screen/source_details.dart';
import 'package:get/get.dart';

class NewsChannelsList extends StatelessWidget {
  const NewsChannelsList({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SourceController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("News Channels"),
          centerTitle: true,
        ),
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.86),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SourceDetails(
                                  model: controller.sources[index])));
                    },
                    child: Container(
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[100]!,
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: const Offset(
                              1.0,
                              1.0,
                            ),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: controller.sources[index].id,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/logos/${controller.sources[index].id}.png")),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 15.0,
                                bottom: 15.0),
                            child: Text(
                              controller.sources[index].name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })));
  }
}
