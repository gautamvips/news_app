import 'package:dio/dio.dart';


class NewsClient {
  Dio dio = Dio();
  //https://newsapi.org/v2/top-headlines?country=us&apiKey=9a78277afb774bc5a28296ec8634aca8

  GetNewsDataFromAPI() async{
    String newsURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9a78277afb774bc5a28296ec8634aca8";
    try {
      var response = await dio.get(newsURL);
      print("this is the news data from the API ${response.data}");
      return response.data;
    }catch(error){
      print("GETTING DATA FROM API");

    }
  }

}
