import 'package:flutter/material.dart';
import 'package:health_connect/service/reservationService.dart';
import 'package:health_connect/theme/extention.dart';
import 'package:health_connect/ui/widgets/doctors/header.widget.dart';

import '../../model/reservation .dart';
import '../../theme/light_color.dart';
import '../widgets/bottom_navigation_bar.widget.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  late String query;

  void _search(String query) async {}
  List<Reservation> reservations = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Reservation>> _fetchReservations() async {
    print("Fetching reservations...");
    List<Reservation> fetchedReservations =
    await ReservationService().getReservationsByDoctor("64693c015d856c471bfc2d9b");
    print("==========================>$fetchedReservations");
      reservations = fetchedReservations;
    return reservations;
  }

  void updateReservationStatus(Reservation reservation) {
    setState(() {
      reservation.confirmed = !reservation.confirmed;
    });

    // Call the confirmReservation method from the ReservationService
    ReservationService.confirmReservation(reservation.doctor.id!, reservation.id!)
        .then((updatedReservation) {
      setState(() {
        // Update the reservation in the list
        int index = reservations.indexWhere((r) => r.id == updatedReservation.id);
        if (index != -1) {
          reservations[index] = updatedReservation;
        }
      });
    }).catchError((error) {
      // Handle error
      print('Failed to update reservation status: $error');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Search(),
              ],
            ),
          ),
          SliverFillRemaining(
            child: FutureBuilder<List<Reservation>>(
              future: _fetchReservations(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final reservations = snapshot.data!;
                  return ListView.builder(
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      Reservation reservation = reservations[index];
                      return AppointmentCard(
                        doctorName: reservation.patient.firstname!,
                        appointmentDate: reservation.appointmentDate!,
                        reservationDate: reservation.reservationDate!,
                        comment: reservation.comment!,
                        confirmed: reservation.confirmed,
                        onPressed: () {
                          updateReservationStatus(reservation);
                        },
                      ).vP4;
                    },
                  ).p(20);
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String appointmentDate;
  final String reservationDate;
  final String comment;
  final bool confirmed;
  final VoidCallback onPressed;

  const AppointmentCard({
    required this.doctorName,
    required this.appointmentDate,
    required this.reservationDate,
    required this.comment,
    required this.confirmed,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^$appointmentDate');
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(doctorName),
        subtitle: Text('$appointmentDate'),
        trailing: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: confirmed ? LightColor.green : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            confirmed ? "Confirmed" : "Not Confirmed",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 12,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
          suffixIcon: IconButton(
            onPressed: () {
              // Perform search
            },
            icon: Icon(Icons.search, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
