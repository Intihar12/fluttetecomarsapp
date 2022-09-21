
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/strings.dart';
import 'package:location/location.dart' as loc;

class AskLocationWgt extends StatefulWidget {
  void Function()? onLocationEnabled;

  AskLocationWgt({
    this.onLocationEnabled,
  });

  @override
  _AskLocationWgtState createState() => _AskLocationWgtState();
}

class _AskLocationWgtState extends State<AskLocationWgt> {
  static const _indicatorSize = Dimens.size15;
  static const _indicatorStrokeWidth = Dimens.size2;
  static const _contentPadding = Dimens.size25;
  static const _sizeIcon = Dimens.size40;
  bool _loading = false;
  bool oneTime = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: Dimens.size4

      ,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.size10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(_contentPadding),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.location_on_sharp,
                size: _sizeIcon,
              ),
              SizedBox(
                height: Dimens.size10,
              ),
              Text(
                Strings.mgsLocation,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Dimens.size10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyColors.darkBlue),
                  foregroundColor: MaterialStateProperty.all(MyColors.white),
                ),
                onPressed: () => _onContinue(),
                child: _buildBtnContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBtnContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return _loading
        ? SizedBox(
      height: _indicatorSize,
      width: _indicatorSize,
      child: CircularProgressIndicator(
        strokeWidth: _indicatorStrokeWidth,
        valueColor:
        AlwaysStoppedAnimation<Color>(colorScheme.onSecondary),
      ),
    )
        : Text(Strings.sContinue);
  }

  void _onContinue() async {
    if (!_loading) {
      setState(() => _loading = true);
      // // wait for loading animation to complete
      // await Future<void>.delayed(Duration(
      //   milliseconds: 500,
      // ));
      bool enabled = await Geolocator.isLocationServiceEnabled();

      if (!enabled) {
        loc.Location location =
        loc.Location(); //explicit reference to the Location class
        // Future _checkGps() async {
        if (!await location.serviceEnabled()) {
          location.requestService();
          // }
        }
        _onContinue();
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text("Can't get Current location",
        //             textAlign: TextAlign.center,
        //             style: Theme.of(context).textTheme.headline2),
        //         content: Text(
        //           'Please make sure you enable GPS and try again',
        //           textAlign: TextAlign.center,
        //           style: Theme.of(context)
        //               .textTheme
        //               .headline5
        //               ?.copyWith(fontWeight: FontWeight.w300),
        //         ),
        //         actions: <Widget>[
        //           FlatButton(
        //               child: Text('Ok'),
        //               onPressed: () {
        //
        //                 if(oneTime){
        //                 final AndroidIntent intent = AndroidIntent(
        //                     action:
        //                         'android.settings.LOCATION_SOURCE_SETTINGS');
        //                 intent.launch();
        //                 Navigator.of(context, rootNavigator: true).pop();
        //                 oneTime=false;
        //                 }
        //
        //                 _onContinue();
        //                 // Navigator.pop(context);
        //               })
        //         ],
        //       );
        //     });
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        _showMyDialog(context);
        await Geolocator.requestPermission();
      } else {
        try {
          final perm = await Geolocator.requestPermission();

          if ((perm == LocationPermission.always && enabled == true) ||
              (perm == LocationPermission.whileInUse && enabled == true)) {
            widget.onLocationEnabled?.call();
          } else {}
        } catch (e) {
          print(e);
        }
      }
    }

    setState(() => _loading = false);
  }

  Future _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Strings.permissionRequired,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  Strings.permissionText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                _onContinue();
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
