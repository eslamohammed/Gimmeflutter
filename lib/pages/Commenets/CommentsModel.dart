// ignore_for_file: file_names

class CommentModel{
  bool?  status;
  String?  msessage , time;
  dynamic data;

    CommentModel(
    this.msessage,
    this.data,
    this.status,
    this.time,
    /* this.title ,
     this.body ,
     this.fromLocation ,
     this.toLocation ,
     this.priceRangemin , 
     this.priceRangemax, 
     this.timeRange,*/
    );

  /*
    print(comments[0]['data'][0/*insex*/]['time']['unit']);
    print(comments[0]['data'][0/*insex*/]['time']['val']);
    print(comments[0]['data'][0/*insex*/]['_id']); //user { request create by} ID
    print(comments[0]['data'][0/*insex*/]['userId']); //user {2nd part : current user who'm make the comment} ID
    print(comments[0]['data'][0/*insex*/]['text']); //
    print(comments[0]['data'][0/*insex*/]['price']);
    print(comments[0]['data'][0/*insex*/]['mod']);
   */



  CommentModel.fromJson(Map<String,dynamic> CommentData){
    msessage=CommentData["msessage"];
    status = CommentData["status"];
    data = CommentData["data"];
  //  time = CommentData[0]["data"][0]["time"]['val'];


  }
} 