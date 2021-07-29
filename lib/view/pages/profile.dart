import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:example/values/dropDownList.dart';
import 'package:example/values/theme.dart';
import 'package:example/view/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime _selectedDateTime = DateTime.now();


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

    final nameContainer = new Column(
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
            onChanged: (girilendeger) {},
            autofocus: false,
             style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
            obscureText: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(6.0),
              focusColor: Colors.blue,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
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
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            child:buildImage2(assetsImage),
                            radius: 38.0,
                          ),
                        ),)
                  ),
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
                            backgroundColor:
                            MaterialStateProperty.all(cardBlue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.white)))),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
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
              this.genderIndex = list.indexOf(newValue);
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
              this.relativeIndex = list.indexOf(newValue);
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
              this.jobIndex = list.indexOf(newValue);
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

  @override
  bool get wantKeepAlive => true;
}
