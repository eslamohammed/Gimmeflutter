class RequestOpenModel{
  
  String? title , body , fromLocation , toLocation ,  priceRange , timeRange;

  RequestOpenModel(
    this.title , 
    this.body,
    this.fromLocation ,
    this.toLocation , 
    this.priceRange , 
    this.timeRange);

  RequestOpenModel.fromJson(Map <String , dynamic> map){
    title = map["title"];
    body = map["body"];
    fromLocation = map["toLocation"];
    priceRange = map["priceRange"];
    timeRange = map["timeRange"];
 
    //timeRange = map["timeRange"]["max"];


  }

}

/*
  String? title , body , fromLocation , toLocation ,  priceRange , timeRange;

"title" : "Electronic parts needed",
    "body" : "I need someone to bring me some Electronic parts from this store, I will be waiting for it, thanks in advance",
    "fromLocation" : {
            "type" : "Point",
            "coordinates" : [23.402, 22.204]
    },
    "toLocation" : {
            "type" : "Point",
            "coordinates" : [-23.402, 28.204]
    },
    "priceRange" : {
        "min" : 20,
        "max" : 90
    },
    "timeRange" : {
        "val" : 2
    }
}

*/ 