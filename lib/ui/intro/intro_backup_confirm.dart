import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalium_wallet_flutter/colors.dart';
import 'package:kalium_wallet_flutter/dimens.dart';
import 'package:kalium_wallet_flutter/styles.dart';
import 'package:kalium_wallet_flutter/kalium_icons.dart';
import 'package:kalium_wallet_flutter/ui/widgets/buttons.dart';
import 'package:kalium_wallet_flutter/ui/widgets/security.dart';
import 'package:kalium_wallet_flutter/util/sharedprefsutil.dart';
import 'package:kalium_wallet_flutter/model/vault.dart';

class IntroBackupConfirm extends StatefulWidget {
  @override
  _IntroBackupConfirmState createState() => _IntroBackupConfirmState();
}

class _IntroBackupConfirmState extends State<IntroBackupConfirm> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarIconBrightness: Brightness.light));

    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: KaliumColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
              children: <Widget>[
                //A widget that holds the header, the paragraph and Back Button
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.075),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            // Back Button
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 50,
                              width: 50,
                              child: FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Icon(KaliumIcons.back,
                                      color: KaliumColors.text, size: 24)),
                            ),
                          ],
                        ),
                        // The header
                        Container(
                          margin: EdgeInsets.only(top: 15.0, left: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Backup your seed",
                                style: KaliumStyles.TextStyleHeaderColored,
                              ),
                            ],
                          ),
                        ),
                        // The paragraph
                        Container(
                          margin:
                              EdgeInsets.only(left: 50, right: 50, top: 15.0),
                          child: Text(
                              "Are you sure that you backed up your wallet seed?",
                              style: KaliumStyles.TextStyleParagraph),
                        ),
                      ],
                    ),
                  ),
                ),

               //A column with YES and NO buttons
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // YES Button
                        KaliumButton.buildKaliumButton(
                            KaliumButtonType.PRIMARY,
                            'YES',
                            Dimens.BUTTON_TOP_DIMENS, 
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new PinScreen(PinOverlayType.NEW_PIN, (_pinEnteredCallback));
                            }));
                        }),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        // NO BUTTON
                        KaliumButton.buildKaliumButton(
                            KaliumButtonType.PRIMARY_OUTLINE,
                            'NO',
                            Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                              Navigator.of(context).pop();
                        }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }

  void _pinEnteredCallback(String pin) {
    SharedPrefsUtil.inst.setSeedBackedUp(true).then((result) {
      Vault.inst.writePin(pin).then((result) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      });
    });
  }
}