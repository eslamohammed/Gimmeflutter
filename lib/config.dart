


class Config {
  static const String appName = "Gimme app";
  static const apiURl = "http://192.168.1.4:8080/api";
  //static const apiURl = "http://localhost:8080/api";
  //http://192.168.1.4:8080/api/request/requests?id=


//http://192.168.1.4:8080/api/user/profile/6215bfcc9f304e65e8e337e5'
//http://192.168.1.4:8080/api/user/profile/+id
  //profiles
  static const loginAPI = "/user/login";
  static const registerAPI = "/user/register";
  static const userProfileAPI = "/user/me";
  static const othersProfileAPI = "/user/profile/";


  /// Request Url   
  /// http://localhost:8080/api/request/open
  /// 'http://localhost:8080/api/request/search?to=naser city'
  static const requestAPI = "/request";
  static const openRequestAPI = "/open";
    static const getAllRequestAPI = "/request/requests?id=";

  static const getRequestAPI = "/request/requests?id=";
  static const deleteRequestAPI = "/delete/";
  static const editRequestAPI = "/edit/:";
  static const searchRequestAPI = "/search?to=";
  static const searchFromRequestAPI = "&from=";

  ///Comment
//'http://192.168.1.4:8080/api/comment/comment/620e6aad9c7c24049b4f84e0' \
    static const commentAPI = "/comment/comment/";


  
  static const ImageURL = "https://images.unsplash.com/photo-1589883661923-6476cb0ae9f2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80";
  
  static const user2ndImageURL = "https://media.istockphoto.com/photos/yorkshire-terrier-dog-looking-down-against-white-background-picture-id962815228?k=20&m=962815228&s=612x612&w=0&h=onoh6ES3mV7eLYU8oCE_H4qERO-g8jsycrqltYpuE10=";

  



 //      http://localhost:8080/api/user/login
 //      http://localhost:8080/api/user/register

//AIzaSyA-iGDlbQj7CkHuymRPJgFo7t2VtO9M43Y

}