import 'package:flutter/material.dart';
 
import 'package:logitrack/modules/deliveryboy/widgets/container.dart';
import 'package:logitrack/modules/deliveryboy/widgets/text_style.dart';
import 'package:logitrack/utils/responsivesize.dart';

import '../../../../../../utils/colors.dart';
 
class Payment extends StatelessWidget {
  const Payment({super.key});

  Widget dividerwidget() {
    return const Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Helper.W(context) * .050,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(
                      Helper.W(context) * .030,
                    ),
                    elevation: 4,
                    child: Container(
                      width: double.infinity,
                      height: Helper.H(context) * .130,
                      child: Row(
                        children: [
                          SizedBox(
                            width: Helper.W(context) * .050,
                          ),
                          Container(
                            width: Helper.W(context) * .150,
                            height: Helper.H(context) * .080,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/Wallet.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Helper.W(context) * .050,
                          ),
                          Text(
                            'My Wallet',
                            style: TextStyle(
                              fontSize:
                                  Helper.W(context) * .060,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Helper.W(context) * .060,
                      ),
                      const Text(
                        'Choose Payment',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.H(context) * .030,
                  ),
                  PaymentListtilewidget(
                    image: 'assets/images/payment/Google pay.png',
                    ontap: () {},
                  ),
                  PaymentListtilewidget(
                    image: 'assets/images/payment/paytm.png',
                    ontap: () {},
                  ),
                  PaymentListtilewidget(
                    image: 'assets/images/payment/phonepay.png',
                    ontap: () {},
                  ),
                  PaymentListtilewidget(
                    image: 'assets/images/payment/paypal.png',
                    ontap: () {},
                  ),
                  PaymentListtilewidget(
                    image: 'assets/images/payment/bank.png',
                    ontap: () {},
                  ),
                  SizedBox(
                    height: Helper.H(context) * .050,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Helper.W(context) * .060,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Price Details',
                              style: AppTextStyles.boldText(
                                fontSize:
                                    Helper.W(context) * .040,
                              ),
                            ),
                          ],
                        ),
                        dividerwidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Package Price',
                              style: AppTextStyles.regularText(
                                fontSize:
                                    Helper.W(context) * .050,
                              ),
                            ),
                            Text(
                              '\$400',
                              style: AppTextStyles.regularText(
                                fontSize:
                                    Helper.W(context) * .050,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Helper.H(context) * .020,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Taxes',
                              style: AppTextStyles.regularText(
                                fontSize:
                                    Helper.W(context) * .040,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '\$8.3',
                              style: AppTextStyles.regularText(
                                fontSize:
                                    Helper.W(context) * .040,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Helper.H(context) * .020,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery changes',
                              style: AppTextStyles.regularText(
                                color: Colors.grey,
                                fontSize:
                                    Helper.W(context) * .040,
                              ),
                            ),
                            Text(
                              '15',
                              style: AppTextStyles.regularText(
                                color: Colors.grey,
                                fontSize:
                                    Helper.W(context) * .040,
                              ),
                            ),
                          ],
                        ),
                        dividerwidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Package Total',
                              style: AppTextStyles.regularText(
                                fontSize:
                                    Helper.W(context) * .040,
                              ),
                            ),
                            Text(
                              '400',
                              style: AppTextStyles.regularText(
                                fontSize:
                                    Helper.W(context) * .040,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Helper.H(context) * .040,
                        ),
                        GestureDetector(
                          //
                          child: ContainerWidget(
                                        color: ColorsClass.SplashScreenbg,

                            width: double.infinity,
                            height: Helper.H(context) * .060,
                            text: 'Place Order',
                            radius: Helper.W(context) * .050,
                          ),
                        ),
                        SizedBox(
                          height: Helper.H(context) * .040,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentListtilewidget extends StatelessWidget {
  final String image;
  final VoidCallback ontap;
  const PaymentListtilewidget({
    super.key,
    required this.image,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: SizedBox(
        width: Helper.W(context) * .180,
        height: Helper.H(context) * .080,
        child: Image.asset(image),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
