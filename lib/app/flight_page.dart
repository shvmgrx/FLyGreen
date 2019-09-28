import 'package:auto_size_text/auto_size_text.dart';
import 'package:flight_co2_calculator_flutter/airport_lookup.dart';
import 'package:flight_co2_calculator_flutter_example/app/constants/text_styles.dart';
import 'package:flight_co2_calculator_flutter_example/app/flight_calculation_card.dart';
import 'package:flight_co2_calculator_flutter_example/app/flight_details_card.dart';
import 'package:flight_co2_calculator_flutter_example/blocs/flight_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FlightPage extends StatelessWidget {
  FlightPage({this.airportLookup});
  final AirportLookup airportLookup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('FlyGreen'),
        elevation: 16,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final flightDetailsBloc = Provider.of<FlightDetailsBloc>(context);
    return StreamBuilder<Flight>(
      stream: flightDetailsBloc.flightStream,
      initialData: Flight.initialData(),
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.lightGreen,
              ],
            ),
          ),
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              
              children: <Widget>[
                
                FlightDetailsCard(
                  airportLookup: airportLookup,
                  flightDetails: snapshot.data.details,
                  flightDetailsBloc: flightDetailsBloc,
                ),
                FlightCalculationCard(
                  flightCalculationData: snapshot.data.data,
                ),
                Expanded(child: Container()),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                 
                  child: Column(
                    
                    children: <Widget>[
                      AutoSizeText(
                        'TEAM FLYGREEN, HackZurich 2019',
                        minFontSize: 8.0,
                        maxLines: 1,
                        style: TextStyles.caption,
                      ),
                      // AutoSizeText(
                      //   'Flights data API: openflights.org',
                      //   minFontSize: 8.0,
                      //   maxLines: 1,
                      //   style: TextStyles.caption,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
