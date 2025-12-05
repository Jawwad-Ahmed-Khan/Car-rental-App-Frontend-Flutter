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
import '../../../booking/domain/entities/booking.dart';

// Helper classes to handle default DateTime values
class _DefaultDateTime implements DateTime {
  const _DefaultDateTime();

  @override
  bool isBefore(DateTime other) => DateTime.now().isBefore(other);

  @override
  bool isAfter(DateTime other) => DateTime.now().isAfter(other);

  @override
  bool isAtSameMomentAs(DateTime other) =>
      DateTime.now().isAtSameMomentAs(other);

  @override
  int compareTo(DateTime other) => DateTime.now().compareTo(other);

  @override
  DateTime add(Duration duration) => DateTime.now().add(duration);

  @override
  DateTime subtract(Duration duration) => DateTime.now().subtract(duration);

  @override
  Duration difference(DateTime other) => DateTime.now().difference(other);

  @override
  String toIso8601String() => DateTime.now().toIso8601String();

  @override
  DateTime toLocal() => DateTime.now().toLocal();

  @override
  DateTime toUtc() => DateTime.now().toUtc();

  @override
  String toString() => DateTime.now().toString();

  @override
  int get year => DateTime.now().year;

  @override
  int get month => DateTime.now().month;

  @override
  int get day => DateTime.now().day;

  @override
  int get hour => DateTime.now().hour;

  @override
  int get minute => DateTime.now().minute;

  @override
  int get second => DateTime.now().second;

  @override
  int get millisecond => DateTime.now().millisecond;

  @override
  int get microsecond => DateTime.now().microsecond;

  @override
  int get weekday => DateTime.now().weekday;

  @override
  dynamic noSuchMethod(Invocation invocation) => DateTime.now();
}

class _DefaultDateTimeAdd3 implements DateTime {
  const _DefaultDateTimeAdd3();

  @override
  bool isBefore(DateTime other) =>
      DateTime.now().add(const Duration(days: 3)).isBefore(other);

  @override
  bool isAfter(DateTime other) =>
      DateTime.now().add(const Duration(days: 3)).isAfter(other);

  @override
  bool isAtSameMomentAs(DateTime other) =>
      DateTime.now().add(const Duration(days: 3)).isAtSameMomentAs(other);

  @override
  int compareTo(DateTime other) =>
      DateTime.now().add(const Duration(days: 3)).compareTo(other);

  @override
  DateTime add(Duration duration) =>
      DateTime.now().add(const Duration(days: 3)).add(duration);

  @override
  DateTime subtract(Duration duration) =>
      DateTime.now().add(const Duration(days: 3)).subtract(duration);

  @override
  Duration difference(DateTime other) =>
      DateTime.now().add(const Duration(days: 3)).difference(other);

  @override
  String toIso8601String() =>
      DateTime.now().add(const Duration(days: 3)).toIso8601String();

  @override
  DateTime toLocal() => DateTime.now().add(const Duration(days: 3)).toLocal();

  @override
  DateTime toUtc() => DateTime.now().add(const Duration(days: 3)).toUtc();

  @override
  String toString() => DateTime.now().add(const Duration(days: 3)).toString();

  @override
  int get year => DateTime.now().add(const Duration(days: 3)).year;

  @override
  int get month => DateTime.now().add(const Duration(days: 3)).month;

  @override
  int get day => DateTime.now().add(const Duration(days: 3)).day;

  @override
  int get hour => DateTime.now().add(const Duration(days: 3)).hour;

  @override
  int get minute => DateTime.now().add(const Duration(days: 3)).minute;

  @override
  int get second => DateTime.now().add(const Duration(days: 3)).second;

  @override
  int get millisecond =>
      DateTime.now().add(const Duration(days: 3)).millisecond;

  @override
  int get microsecond =>
      DateTime.now().add(const Duration(days: 3)).microsecond;

  @override
  int get weekday => DateTime.now().add(const Duration(days: 3)).weekday;

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      DateTime.now().add(const Duration(days: 3));
}

/// Main Payment Methods page
class PaymentMethodsPage extends StatefulWidget {
  final Booking? booking;
  final String userName;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String pickupLocation;
  final String returnLocation;
  final String carId;
  final String carName;
  final String carDescription;
  final String carImageUrl;
  final double carRating;
  final int reviewCount;
  final double totalAmount;
  final String cnic;
  final double pricePerDay;

  const PaymentMethodsPage({
    super.key,
    this.booking,
    this.userName = '',
    this.pickupDate = const _DefaultDateTime(),
    this.returnDate = const _DefaultDateTimeAdd3(),
    this.pickupLocation = '',
    this.returnLocation = '',
    required this.carId,
    this.carName = '',
    this.carDescription = '',
    this.carImageUrl = '',
    this.carRating = 0.0,
    this.reviewCount = 0,
    required this.totalAmount,
    this.cnic = '',
    this.pricePerDay = 0.0,
  });

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
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
        'userName': widget.userName.isNotEmpty
            ? widget.userName
            : 'Benjamin Jack',
        'pickupDate': _resolvedPickupDate,
        'returnDate': _resolvedReturnDate,
        'pickupLocation': widget.pickupLocation.isNotEmpty
            ? widget.pickupLocation
            : 'Shore Dr, Chicago 0062 Usa',
        'returnLocation': widget.returnLocation.isNotEmpty
            ? widget.returnLocation
            : 'Shore Dr, Chicago 0062 Usa',
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
        'cnic': widget.cnic,
        'pricePerDay': widget.pricePerDay,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PaymentBloc()..add(LoadPaymentData(totalAmount: widget.totalAmount)),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            Navigator.pushNamed(
              context,
              AppRouter.paymentStates,
              arguments: {
                'carName': widget.carName,
                'pickupDate': _resolvedPickupDate,
                'returnDate': _resolvedReturnDate,
                'userName': widget.userName,
                'transactionId': state.bookingId.toString(),
                'paymentMethod': state.paymentMethod == 'cash'
                    ? 'Cash'
                    : 'Credit Card',
                'amount': widget.totalAmount > 0
                    ? widget.totalAmount - 15
                    : 1400.0,
                'serviceFee': 15.0,
                'totalAmount': widget.totalAmount,
                'pricePerDay': widget.pricePerDay,
              },
            );
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
                    CircularProgressIndicator(color: Color(0xFF21292B)),
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

          final isCashSelected =
              state is PaymentLoaded && state.selectedPaymentMethodId == 'cash';
          final isCardSelected =
              state is PaymentLoaded &&
              state.selectedPaymentMethodId == 'credit_card';

          return Scaffold(
            backgroundColor: const Color(0xFFF8F8F8),
            appBar: const PaymentAppBar(),
            body: Column(
              children: [
                // Divider
                Container(height: 1, color: const Color(0xFFD7D7D7)),

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
                              // Saved Card Display (Only for Card)
                              if (isCardSelected &&
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

                              // Cash payment option (Toggle)
                              CashPaymentOption(
                                isSelected: isCashSelected,
                                onTap: () {
                                  final newMethod = isCashSelected
                                      ? 'credit_card'
                                      : 'cash';
                                  context.read<PaymentBloc>().add(
                                    SelectPaymentMethod(newMethod),
                                  );
                                },
                              ),
                              const SizedBox(height: 24),

                              if (isCashSelected) ...[
                                // Cash Payment Details
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFFE0E0E0),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Payment Details',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Total Amount:',
                                            style: TextStyle(
                                              color: Color(0xFF7F7F7F),
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            '\$${widget.totalAmount.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF21292B),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        'Please pay the total amount at the counter upon vehicle pickup.',
                                        style: TextStyle(
                                          color: Color(0xFF7F7F7F),
                                          fontSize: 14,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],

                              if (isCardSelected) ...[
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
                              ],

                              // Continue Button
                              ContinueButton(
                                onPressed: () {
                                  final bookingId = widget.booking?.id;
                                  if (bookingId == null || bookingId == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Invalid booking ID. Please try again.',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }

                                  context.read<PaymentBloc>().add(
                                    ConfirmPayment(bookingId: bookingId),
                                  );
                                },
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
