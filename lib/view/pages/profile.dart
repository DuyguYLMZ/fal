import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:example/values/dropDownList.dart';
import 'package:example/values/theme.dart';
import 'package:example/view/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../dialogs.dart';

class ProfileTabWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProfileTabState();
  }
}

class ProfileTabState extends State<ProfileTabWidget>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  int genderIndex = 0;
  int relativeIndex = 0;
  int jobIndex = 0;
  late String _relativeStatu = dropdownJobList[0];
  late String _genderStatu = dropdownGenderList[0];
  late String _jobStatu = dropdownRelativeList[0];


  DateTime _selectedDateTime = DateTime.now();
  final TextEditingController _nameController = TextEditingController();

  Image buildImage2(AssetImage assetsImage) => new Image(image: assetsImage);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(),
      backgroundColor: Colors.transparent,
    );
  }

  _buildBody() {
    var assetsImage = new AssetImage(
        'assets/images/purple_logo.png'); //<- Creates an object that fetches an image.

    final nameContainer = Flexible(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "İsim",
            style: TextStyle(
              color: white,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                border: Border.all()),
            child: TextField(
              controller: _nameController,
              onChanged: (girilendeger) {},
              autofocus: false,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
              obscureText: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(6.0),
                focusColor: Colors.blue,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(38),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
    final birthdayTile = new Material(
      color: Colors.transparent,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Doğum Tarihi",
            style: TextStyle(
              color: white,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                border: Border.all()),
            child: CupertinoDateTextBox(
                initialValue: _selectedDateTime,
                onDateChange: onBirthdayChange,
                hintText: DateFormat.yMd().format(_selectedDateTime)),
          ),
        ],
      ),
    );
    final genderContainer = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cinsiyet",
          style: TextStyle(
            color: white,
          ),
        ),
        DropGenderContainer(dropdownGenderList),
      ],
    );
    final relativeContainer = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "İlişki Durumu",
          style: TextStyle(
            color: white,
          ),
        ),
        DropRelativeContainer(dropdownRelativeList),
      ],
    );
    final jobContainer = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Çalışma Durumu",
          style: TextStyle(
            color: white,
          ),
        ),
        DropJobContainer(dropdownJobList),
      ],
    );

    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20,),
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          child: buildImage2(assetsImage),
                          radius: 38.0,
                        ),
                      ),
                    )),
                nameContainer,
                birthdayTile,
                genderContainer,
                relativeContainer,
                jobContainer,
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(cardBlue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide.none))),
                      onPressed: () async {
                        if(_nameController.text == null || _nameController.text == ""){
                          alertMissingFieldDialog(context);
                        } else {
                          _saveProfile(context);
                        }
                      },
                      child: const Text(
                        'Kaydet',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget DropGenderContainer(List<String> list) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all()),
      child: DropdownButton(
        icon: Icon(Icons.arrow_downward),
        iconSize: 16,
        elevation: 8,
        isExpanded: true,
        style: TextStyle(color: Colors.black),
        focusColor: Colors.black,
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        value: list[this.genderIndex].toString(),
        onChanged: (newValue) {
          if (list.contains(newValue)) {
            setState(() {
              _genderStatu = newValue!.toString();
              this.genderIndex = list.indexOf(newValue!);
            });
          }
        },
        items: list.map((index) {
          return DropdownMenuItem(
            child: new Text(index),
            value: index,
          );
        }).toList(),
      ),
    );
  }

  Widget DropRelativeContainer(List<String> list) {
    return Container(
      padding: EdgeInsets.all(6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all()),
      child: DropdownButton(
        icon: Icon(Icons.arrow_downward),
        iconSize: 16,
        elevation: 8,
        isExpanded: true,
        style: TextStyle(color: Colors.black),
        focusColor: Colors.black,
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        value: list[this.relativeIndex].toString(),
        onChanged: (newValue) {
          if (list.contains(newValue)) {
            setState(() {
              _relativeStatu = newValue!.toString();
              this.relativeIndex = list.indexOf(newValue!);
            });
          }
        },
        items: list.map((index) {
          return DropdownMenuItem(
            child: new Text(index),
            value: index,
          );
        }).toList(),
      ),
    );
  }

  Widget DropJobContainer(List<String> list) {
    return Container(
      padding: EdgeInsets.all(6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all()),
      child: DropdownButton(
        icon: Icon(Icons.arrow_downward),
        iconSize: 16,
        elevation: 8,
        isExpanded: true,
        style: TextStyle(color: Colors.black),
        focusColor: Colors.black,
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        value: list[this.jobIndex].toString(),
        onChanged: (newValue) {
          if (list.contains(newValue)) {
            setState(() {
              _jobStatu = newValue!.toString();
              this.jobIndex = list.indexOf(newValue!);
            });
          }
        },
        items: list.map((index) {
          return DropdownMenuItem(
            child: new Text(index),
            value: index,
          );
        }).toList(),
      ),
    );
  }

  void onBirthdayChange(DateTime birthday) {
    setState(() {
      _selectedDateTime = birthday;
    });
  }

  Future _saveProfile(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    //await Future.delayed(Duration(milliseconds: 200));

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.email)
        .set({
          'name': _nameController.text,
          'gender': _genderStatu,
          'job': _jobStatu,
          'realtive': _relativeStatu,
          'birthday': _selectedDateTime,
        })
        .then((_)  => showPopUp(context, 'Teşekkürler',
            'Değişiklikleriniz başarılı bir şekilde kaydedilmiştir'))
        .catchError((error)  =>  showPopUp(context, 'Bir Hata Oluştu!',
            'Değişiklikleriniz kaydedilememiştir'));
  }


  showPopUp(BuildContext context, String title, String popUpText)  {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.whiteColor,
          title:  Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(popUpText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam',style: TextStyle(color: AppTheme.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),),
              onPressed: ()  {
                Navigator.pop(context,true);// It worked for me instead of above line
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()),);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
