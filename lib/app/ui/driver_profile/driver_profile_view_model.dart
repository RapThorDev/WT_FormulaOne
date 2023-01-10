import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/service/driver_profile/driver_profile_service.dart';
import 'package:f1_application/lib/service/grid/grid_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DriverProfileViewModel {
  DriverProfileViewModel(this._context);

  final BuildContext _context;

  bool get isDriverProfileFetching => Provider.of<DriverProfileService>(_context, listen: false).isGoogleImageFetching;

  String get imageUrl => Provider.of<DriverProfileService>(_context, listen: false).googleImageUrl ?? "";

  Driver? get driver => Provider.of<GridService>(_context, listen: false).selectedDriver;


}
