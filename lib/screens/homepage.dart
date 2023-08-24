import 'package:flutter/material.dart';
import '../services/news_client.dart';
import '../services/news_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

NewsClient nClient = NewsClient();

Future<List<NewsModel>> getNEWS() async {
  Map<String, dynamic> newsMap =
      await nClient.GetNewsDataFromAPI(); //complete news JSON/map
  List<dynamic> nList = newsMap['articles'];
  List<NewsModel> newsList = genericToSpecificObject(nList);
  return newsList;
}

genericToSpecificObject(List<dynamic> list) {
  List<NewsModel> newsList = list.map((singleObject) {
    NewsModel singleNews = NewsModel.extractFromJSON(singleObject);
    return singleNews;
  }).toList();

  return newsList;
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 6, 28, 75),
          title: const Text("NEWS APP",
          style: TextStyle( fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Container(
            color: Colors.blueGrey,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
                future: getNEWS(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context , index){
                        return SizedBox(
                          width: MediaQuery.of(context).size.width*0.6,
                          height: MediaQuery.of(context).size.height*0.7,
                          child: Card(
                            color: const Color.fromARGB(255 , 241 ,239 ,239),
                            child: Column(
                              children: [
                                Image.network(snapshot.data![index].urlToImage),
                                Text(snapshot.data![index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  )),
                                 Text(snapshot.data![index].description,
                                  style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 20,
                                  )),
                                Text(snapshot.data![index].url,
                                  style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 20,
                                  )),
                                Text(snapshot.data![index].author,
                                  style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 20,
                                  ))
                              
                              ],
                            ),
                          ),
                        );
                      });
                    // return const Center(
                    //   child: Text("SUCCESS",
                    //   style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 50),),
                    // );
                  }
                  return Container();
                })),
      ),
    );
  }
}
