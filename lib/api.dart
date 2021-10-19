class Env{
  String baseURL="https://apitopup.kiselindonesia.net";

  Uri postLoginCustomer() {
    return Uri.parse(baseURL + "/login");
  }

}