import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:natrium_wallet_flutter/app_icons.dart';
import 'package:natrium_wallet_flutter/localization.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';
import 'package:natrium_wallet_flutter/dimens.dart';
import 'package:natrium_wallet_flutter/model/db/appdb.dart';
import 'package:natrium_wallet_flutter/model/db/account.dart';
import 'package:natrium_wallet_flutter/model/vault.dart';
import 'package:natrium_wallet_flutter/ui/util/ui_util.dart';
import 'package:natrium_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:natrium_wallet_flutter/ui/widgets/sheets.dart';
import 'package:natrium_wallet_flutter/ui/widgets/buttons.dart';
import 'package:natrium_wallet_flutter/styles.dart';
import 'package:natrium_wallet_flutter/util/clipboardutil.dart';
import 'package:natrium_wallet_flutter/util/caseconverter.dart';

class AppAccountsSheet {
  List<Account> _accounts;

  AppAccountsSheet(List<Account> accounts) {
    this._accounts =accounts;
  }

  mainBottomSheet(BuildContext context) {
    AppSheets.showAppHeightNineSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
                minimum: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.035,
                ),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //A container for the header
                      Container(
                        margin: EdgeInsets.only(top: 30.0, bottom: 15),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 140),
                        child: AutoSizeText(
                          CaseChange.toUpperCase("Accounts", context),
                          style: AppStyles.textStyleHeader(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                        ),
                      ),

                      //A list containing accounts
                      Expanded(
                          child: Stack(
                        children: <Widget>[
                          _accounts == null ?
                            Center(
                              child: Text("Loading"),
                            )
                          :
                          ListView.builder(
                            itemCount: _accounts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildAccountListItem(context, _accounts[index]);
                            },
                          ),
                          //List Top Gradient
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 20.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    StateContainer.of(context)
                                        .curTheme
                                        .backgroundDark00,
                                    StateContainer.of(context)
                                        .curTheme
                                        .backgroundDark,
                                  ],
                                  begin: Alignment(0.5, 1.0),
                                  end: Alignment(0.5, -1.0),
                                ),
                              ),
                            ),
                          ),
                          // List Bottom Gradient
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 20.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    StateContainer.of(context)
                                        .curTheme
                                        .backgroundDark,
                                    StateContainer.of(context)
                                        .curTheme
                                        .backgroundDark00
                                  ],
                                  begin: Alignment(0.5, 1.0),
                                  end: Alignment(0.5, -1.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                      SizedBox(
                        height: 15,
                      ),
                      //A row with Add Account button
                      Row(
                        children: <Widget>[
                          AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            "Add Account",
                            Dimens.BUTTON_TOP_DIMENS,
                            onPressed: () {
                              DBHelper().addAccount(nameBuilder: AppLocalization.of(context).defaultNewAccountName).then((_) {
                                DBHelper().getAccounts().then((accounts) {
                                  setState(() {
                                    _accounts = accounts;
                                  });
                                });
                              });
                            },
                          ),
                        ],
                      ),
                      //A row with Close button
                      Row(
                        children: <Widget>[
                          AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY_OUTLINE,
                            AppLocalization.of(context).close,
                            Dimens.BUTTON_BOTTOM_DIMENS,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          });
        });
  }

  Widget _buildAccountListItem(BuildContext context, Account account,
      {Function onPressed}) {
    return FlatButton(
      highlightColor: StateContainer.of(context).curTheme.text15,
      splashColor: StateContainer.of(context).curTheme.text15,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          return;
        }
      },
      padding: EdgeInsets.all(0.0),
      child: Column(
        children: <Widget> [
          Divider(
            height: 2,
            color:
                StateContainer.of(context).curTheme.text15,
          ),
          Container(
            height: 70.0,
            margin: new EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Account Icon
                    Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 40,
                            height: 30,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: FlatButton(
                              onPressed: () => null,
                              splashColor: Colors.pink,
                              highlightColor: Colors.pink,
                              padding: EdgeInsets.all(0.0),
                              child: Container(
                                  alignment: Alignment(-1, 0),
                                  child: Icon(
                                    AppIcons.accountwallet,
                                    color:
                                        account.selected
                                        ? StateContainer.of(context).curTheme.success
                                        : StateContainer.of(context).curTheme.primary,
                                    size: 30,
                                  )),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 40,
                            height: 30,
                            alignment: Alignment(0.6, 0.4),
                            child: Text(
                              account.getShortName(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .backgroundDark,
                                fontSize: 12,
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Account name and address
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              account.name,
                              style: TextStyle(
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: StateContainer.of(context).curTheme.text,
                              ),
                            ),
                          ),
                          // Main account address
                          Container(
                            child: Text(
                              account.address.substring(0, 11) + "...",
                              style: TextStyle(
                                fontFamily: "OverpassMono",
                                fontWeight: FontWeight.w100,
                                fontSize: 14.0,
                                color: StateContainer.of(context).curTheme.text60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "placeholder",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "NunitoSans",
                          fontWeight: FontWeight.w900,
                          color: StateContainer.of(context).curTheme.text),
                    ),
                    Text(
                      " NANO",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "NunitoSans",
                          fontWeight: FontWeight.w100,
                          color: StateContainer.of(context).curTheme.text),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
