class UserInfoDTO {
  final int id;
  final String username;
  final String password;
  final String fullName;
  final DateTime? dateOfBirth;
  final String? email;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final bool isActive;
  final String role;

  UserInfoDTO({
    required this.id,
    required this.username,
    required this.password,
    required this.fullName,
    this.dateOfBirth,
    this.email,
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.isActive,
    required this.role,
  });

  factory UserInfoDTO.fromJson(Map<String, dynamic> json) {
    return UserInfoDTO(
      id: json['id'] as int,
      username: json['username'] as String,
      password: json['password'] as String,
      fullName: json['fullName'] as String,
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.tryParse(json['dateOfBirth']) : null,
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      isActive: json['isActive'] is bool ? json['isActive'] : json['isActive'] == 1,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'isActive': isActive,
      'role': role,
    };
  }
}
