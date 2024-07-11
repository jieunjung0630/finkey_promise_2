import '../../domain/entities/user_input.dart';

class UserInputModel extends UserInput {
  UserInputModel({
    required String mbti,
    required String bloodType,
    required DateTime birthday,
  }) : super(mbti: mbti, bloodType: bloodType, birthday: birthday);
}
