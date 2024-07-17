import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jobjunction/models/response/auth/profile_model.dart';
import 'package:jobjunction/services/helpers/auth_helper.dart';

class ProfileNotifier extends ChangeNotifier {
  Future<ProfileRes>? profile;

  getProfile() async{
    profile = AuthHelper.getProfile();
  }
}
