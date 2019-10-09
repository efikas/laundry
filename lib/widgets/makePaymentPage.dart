import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

String backendUrl = 'https://mylaundry.com';
String paystackPublicKey = 'pk_test_bbf50126ccbe55393dee264403abf00a2c08a761';
const String appName = 'mMyLaundry';

class MakePaymentCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MakePaymentCardState();
  }
}

class MakePaymentCardState extends State<MakePaymentCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool _isLoading = false;
  dynamic serviceState;

  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: paystackPublicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final animateSubmitButton = Animator(
        duration: Duration(milliseconds: 300),
        cycles: 1,
        builder: (anim) => Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.blueAccent,
          child: MaterialButton(
            onPressed: () {
              _submit();
            },
            minWidth: _buttonAnimate(anim.value),
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: _buttonLabel(anim.value ),
          ),
        ),
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Make Payment"),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
              ),
            ),
            SizedBox(height: 30,),
            animateSubmitButton,
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  double _buttonAnimate(double tween) {

    if(_isLoading){
      return MediaQuery.of(context).size.width - ((MediaQuery.of(context).size.width - 100) * tween);
    }
    else if(_isLoading){
      return 150 + ((MediaQuery.of(context).size.width - 150) * tween);
    }
    else {
        return (MediaQuery.of(context).size.width - 100);
    }
  }

  Widget _buttonLabel(double tween) {
    if(_isLoading && tween > 0.5){
      return Container(
        width: 20,
        height: 20.0,
        child: CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 2,),
      );
    }
    else if(_isLoading && tween > 0.5){
      return Text("Make Payment",
          textAlign: TextAlign.center,
          style:TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white)
      );
    }
    else {
      return Text("Make Payment",
          textAlign: TextAlign.center,
          style:TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white)
      );
    }
  }

  void _submit() async{

     setState(() {_isLoading = true;});

    Future.delayed(const Duration(seconds: 5), () async{
       setState(() {_isLoading = false;});

        // Navigator.of(context).popAndPushNamed('/pickUpRequestSuccess');
    });
  }
}