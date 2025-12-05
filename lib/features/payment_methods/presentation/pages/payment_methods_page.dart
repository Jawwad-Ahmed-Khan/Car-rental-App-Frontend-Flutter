import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../bloc/payment_state.dart';
import '../widgets/payment_app_bar.dart';
import '../widgets/payment_progress_stepper.dart';
import '../widgets/saved_card_display.dart';
import '../widgets/cash_payment_option.dart';
import '../widgets/card_info_form.dart';
import '../widgets/country_region_form.dart';
import '../widgets/terms_checkbox.dart';
import '../widgets/pay_buttons.dart';
import '../widgets/continue_button.dart';
import '../../../../routes/app_router.dart';

/// Main Payment Methods page
class PaymentMethodsPage extends StatefulWidget {
  final double totalAmount;
  
  // Booking details passed through from previous page
  final String userName;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String location;
  
  // Car details
  final String carId;
  final String carName;
  final String carDescription;
  final String carImageUrl;
  final double carRating;
  final int reviewCount;

  const PaymentMethodsPage({
    super.key,
    required this.totalAmount,
    this.userName = '',
    DateTime? pickupDate,
    DateTime? returnDate,
    this.location = '',
    this.carId = '',
    this.carName = '',
    this.carDescription = '',
    this.carImageUrl = '',
    this.carRating = 5.0,
    this.reviewCount = 100,
  })  : pickupDate = pickupDate ?? const _DefaultDateTime(),
        returnDate = returnDate ?? const _DefaultDateTimeAdd3();

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

// Helper classes to handle default DateTime values
class _DefaultDateTime implements DateTime {
  const _DefaultDateTime();
  
  @override
  dynamic noSuchMethod(Invocation invocation) => DateTime.now();
}

class _DefaultDateTimeAdd3 implements DateTime {
  const _DefaultDateTimeAdd3();
  
  @override
  dynamic noSuchMethod(Invocation invocation) => DateTime.now().add(const Duration(days: 3));
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  // Form controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();
  final _zipController = TextEditingController();

  // State variables
  bool _termsAccepted = true;
  bool _cashPaymentSelected = true;
  String _selectedCountry = 'United States';

  // Resolved DateTime values
  late DateTime _resolvedPickupDate;
  late DateTime _resolvedReturnDate;

  @override
  void initState() {
    super.initState();
    // Resolve DateTime values
    _resolvedPickupDate = widget.pickupDate is _DefaultDateTime 
        ? DateTime.now() 
        : widget.pickupDate;
    _resolvedReturnDate = widget.returnDate is _DefaultDateTimeAdd3 
        ? DateTime.now().add(const Duration(days: 3)) 
        : widget.returnDate;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _navigateToConfirmation() {
    Navigator.pushNamed(
      context,
      AppRouter.confirmation,
      arguments: {
        'userName': widget.userName.isNotEmpty ? widget.userName : 'Benjamin Jack',
        'pickupDate': _resolvedPickupDate,
        'returnDate': _resolvedReturnDate,
        'location': widget.location.isNotEmpty ? widget.location : 'Shore Dr, Chicago 0062 Usa',
        'carId': widget.carId,
        'carName': widget.carName.isNotEmpty ? widget.carName : 'Tesla Model S',
        'carDescription': widget.carDescription.isNotEmpty 
            ? widget.carDescription 
            : 'A car with high specs that are rented at an affordable price.',
        'carImageUrl': widget.carImageUrl.isNotEmpty 
            ? widget.carImageUrl 
            : 'assets/images/Tesla_car_2.png',
        'carRating': widget.carRating,
        'reviewCount': widget.reviewCount,
        'amount': widget.totalAmount > 0 ? widget.totalAmount - 15 : 1400.0,
        'serviceFee': 15.0,
        'paymentMethod': 'Mastercard',
        'paymentMethodIcon': 'assets/icons/mastercard.png',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc()
        ..add(LoadPaymentData(totalAmount: widget.totalAmount)),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Payment successful!'),
                backgroundColor: Color(0xFF388E3C),
              ),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state is PaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Scaffold(
              backgroundColor: Color(0xFFF8F8F8),
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is PaymentProcessing) {
            return Scaffold(
              backgroundColor: const Color(0xFFF8F8F8),
              appBar: const PaymentAppBar(),
              body: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color(0xFF21292B),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Processing payment...',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF7F7F7F),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: const Color(0xFFF8F8F8),
            appBar: const PaymentAppBar(),
            body: Column(
              children: [
                // Divider
                Container(
                  height: 1,
                  color: const Color(0xFFD7D7D7),
                ),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Progress stepper
                        const PaymentProgressStepper(),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Saved Card Display
                              if (state is PaymentLoaded &&
                                  state.savedCard != null) ...[
                                SavedCardDisplay(card: state.savedCard!),
                                const SizedBox(height: 24),
                              ],

                              // Select payment method section
                              const Text(
                                'select payment method',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Cash payment option
                              CashPaymentOption(
                                isSelected: _cashPaymentSelected,
                                onTap: () {
                                  setState(() {
                                    _cashPaymentSelected = !_cashPaymentSelected;
                                  });
                                },
                              ),
                              const SizedBox(height: 24),

                              // Card information form
                              CardInfoForm(
                                fullNameController: _fullNameController,
                                emailController: _emailController,
                                cardNumberController: _cardNumberController,
                                expiryController: _expiryController,
                                cvcController: _cvcController,
                              ),
                              const SizedBox(height: 24),

                              // Country or region form
                              CountryRegionForm(
                                selectedCountry: _selectedCountry,
                                zipController: _zipController,
                                onCountryTap: () {
                                  _showCountryPicker(context);
                                },
                              ),
                              const SizedBox(height: 20),

                              // Terms checkbox
                              TermsCheckbox(
                                isChecked: _termsAccepted,
                                onChanged: () {
                                  setState(() {
                                    _termsAccepted = !_termsAccepted;
                                  });
                                },
                              ),
                              const SizedBox(height: 24),

                              // Pay with card Or divider
                              const Center(
                                child: Text(
                                  'Pay with card Or',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xFF7F7F7F),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Apple Pay button
                              ApplePayButton(
                                onPressed: _navigateToConfirmation,
                              ),
                              const SizedBox(height: 12),

                              // Google Pay button
                              GooglePayButton(
                                onPressed: _navigateToConfirmation,
                              ),
                              const SizedBox(height: 24),

                              // Continue button - navigates to Confirmation page
                              ContinueButton(
                                isLoading: state is PaymentProcessing,
                                onPressed: _navigateToConfirmation,
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    final countries = [
      'United States',
      'United Kingdom',
      'Canada',
      'Australia',
      'Germany',
      'France',
      'Japan',
      'Pakistan',
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: countries.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(countries[index]),
              trailing: _selectedCountry == countries[index]
                  ? const Icon(Icons.check, color: Color(0xFF21292B))
                  : null,
              onTap: () {
                setState(() {
                  _selectedCountry = countries[index];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
