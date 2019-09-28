import 'dart:async';

import 'package:flight_co2_calculator_flutter/airport.dart';
import 'package:flight_co2_calculator_flutter/airport_lookup.dart';
import 'package:flight_co2_calculator_flutter/flight_class.dart';
import 'package:flight_co2_calculator_flutter_example/app/airport_search_delegate.dart';
import 'package:flight_co2_calculator_flutter_example/app/airport_widget.dart';
import 'package:flight_co2_calculator_flutter_example/app/common_widgets/vertical_spacing.dart';
import 'package:flight_co2_calculator_flutter_example/app/constants/palette.dart';
import 'package:flight_co2_calculator_flutter_example/app/constants/text_styles.dart';
import 'package:flight_co2_calculator_flutter_example/app/segmented_control.dart';
import 'package:flight_co2_calculator_flutter_example/blocs/flight_details_bloc.dart';
import 'package:flutter/material.dart';

class FlightDetailsCard extends StatelessWidget {
  FlightDetailsCard({
    @required this.flightDetails,
    @required this.flightDetailsBloc,
    @required this.airportLookup,
  });
  final FlightDetails flightDetails;
  final FlightDetailsBloc flightDetailsBloc;
  final AirportLookup airportLookup;

   final Map<FlightType, Widget> flightTypeChildren = const <FlightType, Widget>{
    FlightType.oneWay: Text('ONE WAY'),
    FlightType.twoWays: Text('RETURN FLIGHT'),
  };

  final Map<FlightClass, Widget> flightClassChildren = const <FlightClass, Widget>{
    FlightClass.economy: Text('ECONOMY'),
    FlightClass.business: Text('BUSINESS'),
    FlightClass.first: Text('FIRST CLASS'),
  };

 

  Future<Airport> _showSearch(BuildContext context) async {
    return await showSearch<Airport>(
        context: context,
        delegate: AirportSearchDelegate(
          airportLookup: airportLookup,
        ));
  }

  void _selectDeparture(BuildContext context) async {
    final departure = await _showSearch(context);
    flightDetailsBloc.updateWith(departure: departure);
  }

  void _selectArrival(BuildContext context) async {
    final arrival = await _showSearch(context);
    flightDetailsBloc.updateWith(arrival: arrival);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Palette.blueSkyLight,
              Palette.greenLandLight,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            VerticalSpacing(),
             VerticalSpacing(),
            AirportWidget(
              iconData: Icons.flight_takeoff,
              title: Text('FLYING FROM', style: TextStyles.caption),
              airport: flightDetails.departure,
              onPressed: () => _selectDeparture(context),
            ),
            VerticalSpacing(),
            AirportWidget(
              iconData: Icons.flight_land,
              title: Text('FLYING TO', style: TextStyles.caption),
              airport: flightDetails.arrival,
              onPressed: () => _selectArrival(context),
            ),
             VerticalSpacing(),
            SegmentedControl<FlightClass>(
              header: Text('CLASS', style: TextStyles.caption),
              value: flightDetails.flightClass,
              children: flightClassChildren,
              onValueChanged: (flightClass) => flightDetailsBloc.updateWith(flightClass: flightClass),
            ),
             VerticalSpacing(),
            SegmentedControl<FlightType>(
              header: Text('TYPE', style: TextStyles.caption),
              value: flightDetails.flightType,
              children: flightTypeChildren,
              onValueChanged: (flightType) => flightDetailsBloc.updateWith(flightType: flightType),
            ),
            VerticalSpacing(),
          ],
        ),
      ),
    );
  }
}
