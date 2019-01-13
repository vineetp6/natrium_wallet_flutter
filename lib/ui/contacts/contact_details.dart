import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalium_wallet_flutter/colors.dart';

import 'package:kalium_wallet_flutter/dimens.dart';
import 'package:kalium_wallet_flutter/kalium_icons.dart';
import 'package:kalium_wallet_flutter/styles.dart';
import 'package:kalium_wallet_flutter/ui/util/ui_util.dart';
import 'package:kalium_wallet_flutter/ui/widgets/buttons.dart';
import 'package:kalium_wallet_flutter/ui/widgets/sheets.dart';

// Contact Details Sheet
class ContactDetailsSheet {
  mainBottomSheet(BuildContext context) {
    KaliumSheets.showKaliumHeightNineSheet(
        context: context,
        animationDurationMs: 200,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Trashcan Button
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: FlatButton(
                        onPressed: () {
                          return null;
                        },
                        child: Icon(KaliumIcons.trashcan,
                            size: 24, color: KaliumColors.text),
                        padding: EdgeInsets.all(13.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                      ),
                    ),
                    // The header of the sheet
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "CONTACT",
                            style: KaliumStyles.TextStyleHeader,
                          ),
                        ],
                      ),
                    ),
                    // Search Button
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 10.0, right: 10.0),
                      child: FlatButton(
                        onPressed: () {
                          return null;
                        },
                        child: Icon(KaliumIcons.search,
                            size: 24, color: KaliumColors.text),
                        padding: EdgeInsets.all(13.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                      ),
                    ),
                  ],
                ),

                // The main container that holds monKey, Contact Name and Contact Address
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // monKey container
                      Container(
                        height: 100,
                        width: 100,
                        color: KaliumColors.primary,
                      ),
                      // Contact Name container
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.105,
                          right: MediaQuery.of(context).size.width * 0.105,
                          top: 15,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: KaliumColors.backgroundDarkest,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "@yekta",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: KaliumColors.primary,
                            fontFamily: 'NunitoSans',
                          ),
                        ),
                      ),
                      // Contact Address
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.105,
                            right: MediaQuery.of(context).size.width * 0.105,
                            top: 15),
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 15.0),
                        decoration: BoxDecoration(
                          color: KaliumColors.backgroundDarkest,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: UIUtil.threeLineAddressText(
                          "ban_1yekta1xn94qdnbmmj1tqg76zk3apcfd31pjmuy6d879e3mr469a4o4sdhd4",
                        ),
                      ),
                      // Address Copied text container
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("Address Copied",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: KaliumColors.success,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ],
                  ),
                ),

                // A column with "Send" and "Close" buttons
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // Send Button
                          KaliumButton.buildKaliumButton(
                              KaliumButtonType.PRIMARY,
                              'Send',
                              Dimens.BUTTON_TOP_DIMENS, onPressed: () {
                            return null;
                          }),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          // Close Button
                          KaliumButton.buildKaliumButton(
                              KaliumButtonType.PRIMARY_OUTLINE,
                              'Close',
                              Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                            Navigator.pop(context);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
        });
  }
}
