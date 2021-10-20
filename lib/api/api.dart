class Env{
  String baseURL="https://reqres.in/";

  Uri postLoginCustomer() {
    return Uri.parse(baseURL + "api/login");
  }
  Uri ListUser(){
    return Uri.parse(baseURL+"api/users?page=2");
  }
}