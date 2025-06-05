class Api {
  //base Url
  static const String mainAppUrl = "https://ib.jamalmoallart.com/";
  //end points
  static const String baseUrl = "${mainAppUrl}api/";
  static const String doServerLoginApiCall = "${baseUrl}v2/login";
  static const String doServerRegisterApiCall = "${baseUrl}v2/register";

  static const String doServerProductsApiCall = "${baseUrl}v1/all/products";
}
