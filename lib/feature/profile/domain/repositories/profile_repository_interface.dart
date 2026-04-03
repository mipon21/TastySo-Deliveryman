import 'package:tastyso_delivery_driver/feature/profile/domain/models/profile_model.dart';
import 'package:tastyso_delivery_driver/feature/profile/domain/models/record_location_body.dart';
import 'package:tastyso_delivery_driver/interface/repository_interface.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileRepositoryInterface implements RepositoryInterface {
  Future<dynamic> getProfileInfo();
  Future<dynamic> recordLocation(RecordLocationBody recordLocationBody);
  Future<dynamic> updateProfile(
      ProfileModel userInfoModel, XFile? data, String token);
  Future<dynamic> updateActiveStatus({int? shiftId});
  bool isNotificationActive();
  void setNotificationActive(bool isActive);
  void setOnlineStatus(bool isOnline);
  Future<dynamic> deleteDriver();
  Future<dynamic> getShiftList();
  Future<Map<String, dynamic>?> getEarningHistory({int? offset, int? limit});
}
