class AppConstants {

  static const String baseUrl = "http://localhost:8084";
  static const String loginUrl = "$baseUrl/api/login";
  static const String registerUrl = "$baseUrl/api/register";
  static const String logoutUrl = "$baseUrl/api/logout";

  // Storage keys
  static const String tokenKey = "TOKEN";
  static const String roleKey = "ROLE";

  // Headers
  static Map<String, String> headers(String token) => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  };

}