import 'package:buddhistauction/Provider/register_otp.dart';
import 'package:buddhistauction/Provider/store_text_register.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: Body(),

    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.04), // 4%
                Text(
                  'ຕື່ມຂໍ້ມູນສ່ວນໂຕ',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 62, 13, 184),
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.08),

                SignUpForm(),

                SizedBox(height: MediaQuery.of(context).size.height * 0.08),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = new TextEditingController();
  final TextEditingController _cpass = new TextEditingController();

   String name, surname, phoneNo, password, date;

  @override
  Widget build(BuildContext context) {
    return

    Form(
      key: _formKey,
      child: Column(

      children: [

        nameTextField(),

        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

        surnameTextField(),

        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

        dateTextField(),

        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

        passTextField(),

        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

        cpassTextField(),

        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

        phoneTextField(),

        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

        submitButton(),
      ],),
    );
  }

  Widget nameTextField(){
    return  Consumer<StoreTextRegister>(
      builder: (context, str, child) {

      return TextFormField(
        onChanged: (value) {
          str.setName(value);
          name = value;
        },
        autofocus: true,
        validator: (value) {
          if (value.isEmpty) {
            return 'ກະລຸນາປ້ອນຂໍ້ມູນ';
          }
          return null;
        },
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.person),
          labelText: 'ຊື່',
          contentPadding: EdgeInsets.symmetric(
              vertical: 5.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),

      );
      },);
  }

  Widget surnameTextField(){
    return Consumer<StoreTextRegister>(
      builder: (context, str, child) {
        return  TextFormField(
          onChanged: (value) {
            str.setSurname(value);
            surname = value;
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'ກະລຸນາປ້ອນຂໍ້ມູນ';
            }
            return null;
          },
          decoration:  InputDecoration(
            suffixIcon: Icon(Icons.person),
            labelText: 'ນາມສະກຸນ',
            contentPadding: EdgeInsets.symmetric(
                vertical: 5.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }

  Widget dateTextField(){
    return Consumer<StoreTextRegister>(
      builder: (context, str, child) {
        return  DateTimePicker(
          decoration:  InputDecoration(
            suffixIcon: Icon(Icons.date_range),
            labelText: 'ວັນ ເດືອນ ປີເກີດ',
            contentPadding: EdgeInsets.symmetric(
                vertical: 5.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          initialValue: '',
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          dateLabelText: 'Date',
          onChanged: (val) {
            str.setDate(val);
            date = val;
          },
          validator: (val) {
            if (val.isEmpty) {
              return 'ກະລຸນາປ້ອນຂໍ້ມູນ';
            }
            return null;
          },
        );
      },
    );
  }

  Widget passTextField(){
    return Consumer<StoreTextRegister>(
      builder: (context, str, child) {
        return   TextFormField(
          onChanged: (value) {
            str.setPassword(value);
            password = value;
          },
          controller: _pass,
          validator: (value) {
            if (value.isEmpty) {
              return 'ກະລຸນາປ້ອນຂໍ້ມູນ';
            }
            if (value.length < 8) {
              return 'ລະຫັດຜ່ານໜ້ອຍເກີນໄປ';
            }
            if (value != _cpass.text) {
              return 'ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ';
            }
            return null;
          },
          obscureText: true,
          decoration:  InputDecoration(
            suffixIcon: Icon(Icons.lock_outline),
            labelText: 'ໃສ່ລະຫັດຜ່ານ',
            contentPadding: EdgeInsets.symmetric(
                vertical: 5.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }

  Widget cpassTextField(){
    return TextFormField(
          controller: _cpass,
          validator: (value) {
            if (value.isEmpty) {
              return 'ກະລຸນາປ້ອນຂໍ້ມູນ';
            }
            if (value != _pass.text) {
              return 'ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ';
            }
            return null;
          },
          obscureText: true,
          decoration:  InputDecoration(
            suffixIcon: Icon(Icons.lock_outline),
            labelText: 'ຢືນຢັນລະຫັດຜ່ານ',
            contentPadding: EdgeInsets.symmetric(
                vertical: 5.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey),
            ),

          ),
        );

  }

  Widget phoneTextField(){
    return Consumer<StoreTextRegister>(
      builder: (context, str, child) {
        return TextFormField(
          onChanged: (val) {

            str.setPhoneNo("+"+val);
            phoneNo = "+"+val;
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'ກະລຸນາປ້ອນຂໍ້ມູນ';
            }

            return null;
          },
          decoration:  InputDecoration(
            suffixIcon: Icon(Icons.phone),
            labelText: 'ເບີໂທ 856 20 XXXX XXXX',
            contentPadding: EdgeInsets.symmetric(
                vertical: 5.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }

  Widget submitButton(){

        return ButtonTheme(
          minWidth: double.infinity,
          height: 40,
          child: RaisedButton(
            color: Color.fromARGB(255, 62, 13, 184),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text('ສືບຕໍ່',style: TextStyle(
                fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
            onPressed: (){
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                Provider.of<RegisterOTP>(context, listen: false)
                    .verifyPhone(
                    name, surname, password, phoneNo, context);
              } else {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Processing Data')));
              }
            },
          ),
        );

  }
}


class OtpArgument {
  String verificationIdArg;
  String phoneNoArg;
  String name, surname, password;
  BuildContext context;
  OtpArgument(
      {this.verificationIdArg,
      this.phoneNoArg,
      this.name,
      this.surname,
      this.password,
      this.context});
}
