import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingmall/utility/my_constant.dart';
import 'package:shoppingmall/utility/my_dialog.dart';
import 'package:shoppingmall/widgets/show_image.dart';
import 'package:shoppingmall/widgets/show_progress.dart';
import 'package:shoppingmall/widgets/show_title.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  File? file;
  double? lat, lng;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<Null> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      print('Service Location Open');

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDailog().alertLocationServeice(
              context, 'ไม่อนุณาตแชร์ Lacation', 'โปรดแชร์ Location');
        } else {
          //Find LatLng()
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDailog().alertLocationServeice(
              context, 'ไม่อนุณาตแชร์ Lacation', 'โปรดแชร์ Location');
        } else {
          // Find LatLng
          findLatLng();
        }
      }
    } else {
      print('Service Location Close');
      MyDailog().alertLocationServeice(context, 'Location Service ปิดอยู่ ?',
          'กรุณาเปิด Location Service ด้วยครับ');
    }
  }

  Future<Null> findLatLng() async {
    print('findLatLan ==> Work');
    Position? position = await findPostion();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      print('lat=$lat,lng =$lng');
    });
  }

  Future<Position?> findPostion() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.8,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Name ด้วย';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Name :',
              prefixIcon: Icon(
                Icons.fingerprint,
                color: MyConstant.dart,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dart),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPhone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.8,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Phone ด้วย';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Phone :',
              prefixIcon: Icon(
                Icons.phone_in_talk,
                color: MyConstant.dart,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dart),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.8,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก User ด้วย';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'User :',
              prefixIcon: Icon(
                Icons.account_circle,
                color: MyConstant.dart,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dart),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.8,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Password ด้วย';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Password :',
              prefixIcon: Icon(
                Icons.password_outlined,
                color: MyConstant.dart,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dart),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [buildCreateNewAccount()],
        title: Text('Create New Account'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTitle('ข้อมูลทั่วไป'),
                buildName(size),
                buildTitle('ชนิดของ User :'),
                buildRadiobuyer(size),
                buildRadioSeller(size),
                buildRadioRider(size),
                buildTitle('ข้อมูลพื้นฐาน'),
                buildAddress(size),
                buildPhone(size),
                buildUser(size),
                buildPassword(size),
                buildTitle('รูปภาพ'),
                buildSubTitle(),
                buildAvatar(size),
                buildTitle('ตำแหน่งของคุณ'),
                buildmap(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildCreateNewAccount() {
    return IconButton(
      onPressed: () {
        if (formkey.currentState!.validate()) {
          if (typeUser == null) {
            print('Non Choose type User');
            MyDailog().normalDiallog(context, 'ยังไม่ได้เลือก ชนิดของ User',
                'กรุณา Tap ที่ ชนิดของ User ที่ต้องการ');
          } else {
            print('Process Insert to Database');
          }
        }
      },
      icon: Icon(Icons.cloud_upload),
    );
  }

  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('Id'),
          position: LatLng(lat!, lng!),
          infoWindow: InfoWindow(
              title: 'คุณอยู่ที่นี่', snippet: 'Lat = $lat, lng =$lng'),
        ),
      ].toSet();

  Widget buildmap() => Container(
        width: double.infinity,
        height: 300,
        child: lat == null
            ? ShowProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 16,
                ),
                onMapCreated: (controller) {},
                markers: setMarker(),
              ),
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(double size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
          icon: Icon(
            Icons.add_a_photo,
            size: 36,
            color: MyConstant.dart,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.5,
          child: file == null
              ? ShowImage(path: MyConstant.avatar)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
          icon: Icon(
            Icons.add_a_photo_outlined,
            size: 36,
            color: MyConstant.dart,
          ),
        ),
      ],
    );
  }

  ShowTitle buildSubTitle() {
    return ShowTitle(
      title:
          'เป็นรูปภาพ ที่แสดงความเป็นตัวตนของ User (แต่ถ้าไม่สะดวกแชร์เราจะแสดงภาพ default',
      textStyle: MyConstant().h3Style(),
    );
  }

  Row buildRadiobuyer(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'buyer',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
              });
            },
            title: ShowTitle(
              title: 'ผู้ซื้อ (Buyer)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.8,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Address ด้วย';
              } else {}
            },
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Address :',
              hintStyle: MyConstant().h3Style(),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Icon(
                  Icons.home,
                  color: MyConstant.dart,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dart),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioSeller(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'Seller',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
              });
            },
            title: ShowTitle(
              title: 'ผู้ขาย (Seller)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRadioRider(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'Rider',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
              });
            },
            title: ShowTitle(
              title: 'ผู้ส่ง (Rider)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
}
