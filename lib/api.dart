class Env{
  String baseURL="https://reqres.in/";

  Uri postLoginCustomer() {
    return Uri.parse(baseURL + "api/login");
  }

}