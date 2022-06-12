class SearchRequestModel{

  bool?  status;
  String?  msessage ;
  dynamic data;
  String?  title, body;
  
  SearchRequestModel(
    this.msessage,
    this.data,
    this.status,
     this.title ,
     this.body ,

    );

  SearchRequestModel.fromJson(Map <String , dynamic> requestsData){
    msessage=requestsData["msessage"];
    status = requestsData["status"];
    data = requestsData["data"];
  
    title = requestsData["data"][0]["title"];  
    body  = requestsData["data"][0]["body"];


  }

}