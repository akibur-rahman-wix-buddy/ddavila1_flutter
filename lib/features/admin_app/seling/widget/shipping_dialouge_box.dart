import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ddavila/networks/api_acess.dart';

class ShippingUpdateDialog extends StatefulWidget {
  final String orderNumber;
  final String productName;
  final List<dynamic> productIds;
  final Function onSuccess;

  const ShippingUpdateDialog({
    super.key,
    required this.orderNumber,
    required this.productName,
    required this.productIds,
    required this.onSuccess,
  });

  @override
  State<ShippingUpdateDialog> createState() => _ShippingUpdateDialogState();
}

class _ShippingUpdateDialogState extends State<ShippingUpdateDialog> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _trackingController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: EdgeInsets.all(24.0),
        constraints: BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Shipping Information - ${widget.orderNumber}',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              widget.productName,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[700],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 24.h),
            Text(
              'Shipping Company Name',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _companyController,
              decoration: InputDecoration(
                hintText: 'Enter shipping company name',
                border: OutlineInputBorder(),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Tracking Number',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _trackingController,
              decoration: InputDecoration(
                hintText: 'Enter tracking number',
                border: OutlineInputBorder(),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            SizedBox(height: 24.h),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    padding:
                    EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                ElevatedButton(
                  onPressed: _updateShipping,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                    EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Update Shipping',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateShipping() async {
    if (_companyController.text.isEmpty || _trackingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Check if we have at least one product ID
    if (widget.productIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No product ID found')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      dynamic productId = widget.productIds.first;

      String productIdString = productId.toString();

    bool success =  await sellingOrderConfirmRx.sellingOrderConfirmInfo(
        companyName: _companyController.text,
        trackingNumber: _trackingController.text,
        productId: productIdString,
      );

    if(success){
      setState(() {
        getSellingOrderRX.getSellingOrderRX();
      });
    }

      // Call the success callback
      widget.onSuccess();

      // Close the dialog
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Shipping information updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update shipping information: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}