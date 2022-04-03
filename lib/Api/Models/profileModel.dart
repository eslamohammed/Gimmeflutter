class ProfileModel{
  String? id , name , email , phone ,  img ;
  
  ProfileModel(this.id , this.name , this.email , this.phone , this.img);

  ProfileModel.fromJson(Map <String , dynamic> map){
    id = map["_id"];
    email = map["email"];
    name = map["name"];
    phone = map["phone"];
    img = map["img"];

    
  }

}