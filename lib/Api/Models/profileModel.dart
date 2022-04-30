class ProfileModel{
  String? id , name , email , phone;
  String? createTime , updatedAt ;
  bool? isTrusted ;
  
  ProfileModel(
    this.id,
    this.name, 
    this.email, 
    this.phone, 
    //this.img
    this.createTime,
    this.updatedAt,
    this.isTrusted,
    );

  ProfileModel.fromJson(Map <String , dynamic> map){
    id = map['data']["_id"];
    name = map['data']["name"];
    email = map['data']["email"];
    phone = map['data']["phone"];
    createTime = map['data']["createTime"];
    updatedAt = map['data']["updatedAt"];
    isTrusted = map['data']["isTrusted"];

  }

}