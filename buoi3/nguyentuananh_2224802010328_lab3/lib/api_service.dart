import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();
  final String baseUrl = "https://69df07a7d6de26e11928736a.mockapi.io/";

  // Lấy danh sách users
  Future<List<dynamic>> getUsers() async {
    final response = await dio.get(baseUrl + "users");
    return response.data;
  }

  // ĐĂNG KÝ: Thêm user mới vào mockapi
  Future<bool> registerUser(String email, String password) async {
    try {
      final response = await dio.post(baseUrl + "users", data: {
        "email": email,
        "password": password,
      });
      return response.statusCode == 201; // MockAPI trả về 201 khi tạo thành công
    } catch (e) {
      return false;
    }
  }

  // RESET PASSWORD: Tìm id theo email rồi cập nhật password mới
  Future<String> resetPassword(String email, String newPassword) async {
    try {
      // 1. Lấy danh sách users để tìm user có email khớp
      final users = await getUsers();
      
      // 2. Tìm user trong danh sách
      var user = users.firstWhere(
        (u) => u['email'] == email,
        orElse: () => null,
      );

      if (user == null) {
        return "Email không tồn tại!";
      }

      // 3. Lấy ID và thực hiện cập nhật (PUT)
      String id = user['id'];
      final response = await dio.put(baseUrl + "users/$id", data: {
        "password": newPassword,
      });

      if (response.statusCode == 200) {
        return "Thành công";
      } else {
        return "Lỗi khi cập nhật mật khẩu";
      }
    } catch (e) {
      return "Đã xảy ra lỗi kết nối";
    }
  }
}