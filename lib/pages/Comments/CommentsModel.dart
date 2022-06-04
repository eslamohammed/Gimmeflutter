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
    );



  CommentModel.fromJson(Map<String,dynamic> CommentData){
    msessage=CommentData["msessage"];
    status = CommentData["status"];
    data = CommentData["data"];
  //  time = CommentData[0]["data"][0]["time"]['val'];


  }
} 