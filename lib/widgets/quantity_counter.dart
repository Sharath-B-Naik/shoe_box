import 'package:shoe_box/widgets/app_button.dart';
import 'package:shoe_box/widgets/app_text.dart';
import 'package:flutter/material.dart';

class QuantityCounter extends StatefulWidget {
  final int quantity;
  final ValueChanged<int>? onDecrement;
  final ValueChanged<int>? onIncrement;
  const QuantityCounter({
    Key? key,
    this.quantity = 0,
    this.onDecrement,
    this.onIncrement,
  }) : super(key: key);

  @override
  State<QuantityCounter> createState() => QuantityCounterState();
}

class QuantityCounterState extends State<QuantityCounter> {
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  @override
  void didUpdateWidget(covariant QuantityCounter oldWidget) {
    if (oldWidget.quantity != widget.quantity) setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            AppButton(
              onTap: () {
                _quantity = _quantity - 1;
                widget.onDecrement?.call(_quantity);
                setState(() {});
              },
              text: "-",
              fontSize: 24,
              width: 50,
              height: double.infinity,
              elevation: 0,
              borderRadius: 0,
              textColor: Colors.white,
              backgroundColor: Colors.grey,
            ),
            Expanded(
              child: Center(
                child: AppText('$_quantity'),
              ),
            ),
            AppButton(
              onTap: () {
                _quantity = _quantity + 1;
                widget.onIncrement?.call(_quantity);
                setState(() {});
              },
              text: "+",
              fontSize: 24,
              width: 50,
              height: double.infinity,
              elevation: 0,
              borderRadius: 0,
              textColor: Colors.white,
              backgroundColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
