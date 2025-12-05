import 'package:flutter/material.dart';
import '../../data/datasources/home_local_data_source.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/usecases/get_cars.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_field.dart';
import '../widgets/brand_selector.dart';
import '../widgets/car_card.dart';
import '../../domain/entities/car.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dependency Injection (Manual for now, usually done with GetIt/Provider)
  late final GetCars _getCars;
  List<Car> _cars = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final dataSource = HomeLocalDataSourceImpl();
    final repository = HomeRepositoryImpl(localDataSource: dataSource);
    _getCars = GetCars(repository);
    _loadCars();
  }

  Future<void> _loadCars() async {
    final cars = await _getCars();
    setState(() {
      _cars = cars;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // From Figma
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeAppBar(),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SearchField(),
              ),
              const SizedBox(height: 20),
              const BrandSelector(),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Best Cars',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(context: context, 
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Warning"),
                            content: Text('This page is under development. Thank you for your patience.'),
                            actions:<Widget> [
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, child: Text('Close'))
                            ],
                          );
                        });
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          color: Color(0xFF7F7F7F),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Available',
                  style: TextStyle(
                    color: Color(0xFF7F7F7F),
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 280,
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 20),
                        itemCount: _cars.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CarCard(car: _cars[index]),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Nearby',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(context: context, 
                        builder: (BuildContext context){
                          return AlertDialog(
                          title: Text('Warning'),
                          content: Text('This page is under development. Sorry for inconvenience.'),
                          actions: <Widget>[
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, 
                            child: Text('Cancel'))
                          ],
                        );
                        });
                        
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          color: Color(0xFF7F7F7F),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/car_banner.png'), // Placeholder for banner
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                   decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100), // Bottom padding for floating nav bar
            ],
          ),
        ),
      ),
    );
  }
}
