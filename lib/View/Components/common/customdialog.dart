import 'package:flutter/material.dart';
import 'package:zulassung123/View/Components/common/customtexts.dart';

void CustomDialog(context, String warnText) {
  Size sz = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (c) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: sz.height * 0.2,
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: BlackTextBG(warnText)),
                    SizedBox(
                      height: sz.height * 0.03,
                    ),
                    ButtonTheme(
                        minWidth: 100,
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.pop(c);
                            },
                            color: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            child: Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                        )
                    )
                  ],
                )
            ),
          ),
        );
      }
  );
}

void ConfirmDialog(context, int id, int sid) {
  Size sz = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (c) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: 150,
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Are you sure you want to delete this item'),
                    SizedBox(
                      height: sz.width * 0.02,
                    ),
                    ButtonTheme(
                        minWidth: sz.width * 0.6,
                        child: RaisedButton(
                            onPressed: () async {
                              Navigator.pop(c);
                            },
                            color: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                        )
                    )
                  ],
                )
            ),
          ),
        );
      }
  );
}