/*

class AddRequestModel{
/*
  bool  status = false;
  String  msessage ="" , data="";
  String  title="" , body="" ;
  double fromLocation=0.0 , toLocation=0.0 ,  priceRangemin=0.0,  priceRangemax=00.0 , timeRange=0.00 ;  
*/
  bool?  status;
  String?  msessage , data;
  String?  title, body;
//  double? fromLocation , toLocation,  priceRangemin,  priceRangemax , timeRange ;  

  AddRequestModel(
    this.msessage,
    this.data,
    this.status,
     this.title ,
     this.body ,
  /*   this.fromLocation ,
     this.toLocation ,
     this.priceRangemin , 
     this.priceRangemax, 
     this.timeRange
  */
     );

  //  Map<String, dynamic> map = new Map<String, dynamic>.from();
  AddRequestModel.fromJson(Map<String,dynamic> map){
    this.msessage=map["msessage"];
    this.status = map["status"];
    this.data = map["data"];
  
    this.title = map["data"]["title"];  
    this.body  = map["data"]["body"];
 
 /*   fromLocation = map["data"]["fromLocation"]["coordinates"];
    toLocation   = map["data"]["toLocation"]["coordinates"];
    priceRangemin= map["data"]["priceRange"]["min"];
    priceRangemax= map["data"]["priceRange"]["max"];   
    timeRange    = map["data"]["val"];
  */
  }

}
*/

class AddRequestModel{
/*
  bool  status = false;
  String  msessage ="" , data="";
  String  title="" , body="" ;
  double fromLocation=0.0 , toLocation=0.0 ,  priceRangemin=0.0,  priceRangemax=00.0 , timeRange=0.00 ;  
*/
  bool?  status;
  String?  msessage , data;
  String?  title, body;
//  double? fromLocation , toLocation,  priceRangemin,  priceRangemax , timeRange ;  

  AddRequestModel(
    msessage,
    data,
    status,
     title ,
     body ,
  /*   this.fromLocation ,
     this.toLocation ,
     this.priceRangemin , 
     this.priceRangemax, 
     this.timeRange
  */
     );

  //  Map<String, dynamic> map = new Map<String, dynamic>.from();
  AddRequestModel.fromJson(Map<String,dynamic>map){
  //AddRequestModel(Map<String,dynamic> map){
    msessage = map["msessage"];
    status = map["status"];
    data = map["data"];
  
    title = map["data"]["title"];  
    body  = map["data"]["body"];
 
 /*   fromLocation = map["data"]["fromLocation"]["coordinates"];
    toLocation   = map["data"]["toLocation"]["coordinates"];
    priceRangemin= map["data"]["priceRange"]["min"];
    priceRangemax= map["data"]["priceRange"]["max"];   
    timeRange    = map["data"]["val"];
  */
  }

}