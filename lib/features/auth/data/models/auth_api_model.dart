


import 'package:tridivya_spritual_wellness_app/features/auth/domain/entities/auth_entity.dart';

class AuthApiModel{
  
  final String fullName;
  final String email;
  final String username;
  final String? password;
 

  AuthApiModel({
    required this.fullName,
    required this.email,
    required this.username,
    this.password,
   
  });

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'name': fullName,
      'email': email,
      'username': username,
      'password': password,
    
    };
  }


  //fromJson
  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
     
      fullName: json['name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
    );
  }

  //toEntity

  AuthEntity toEntity (){
    return AuthEntity(
      fullName: fullName,
      email:email,
      username: username,
       
    );

  }

  //fromEntity

  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      fullName: entity.fullName,
      email:entity.email,
      username: entity.username,
      password: entity.password
    );
    // toEmtityList

   
  }

}

