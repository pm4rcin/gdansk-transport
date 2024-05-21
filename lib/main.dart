import 'package:flutter/material.dart';
import 'package:trufi_core/base/blocs/map_configuration/map_configuration_cubit.dart';
import 'package:trufi_core/base/blocs/theme/theme_cubit.dart';
import 'package:trufi_core/base/models/trufi_latlng.dart';
import 'package:trufi_core/base/utils/graphql_client/hive_init.dart';
import 'package:trufi_core/default_values.dart';
import 'package:trufi_core/trufi_core.dart';
import 'package:trufi_core/trufi_router.dart';

final ThemeData standardTheme = ThemeData();
final ThemeData darkTheme = ThemeData.dark();
const accentColor = Color(0xFF00FF00);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(
    TrufiApp(
      appNameTitle: 'Gdańsk transport',
      blocProviders: [
        ...DefaultValues.blocProviders(
          otpEndpoint: "http://192.168.0.10:8080/otp/routers/default",
          otpGraphqlEndpoint:
              "http://192.168.0.10:8080/otp/routers/default/index/graphql",
          mapConfiguration: MapConfiguration(
              center: const TrufiLatLng(54.37069, 18.689787), onlineZoom: 11),
          searchAssetPath: "assets/data/search.json",
          photonUrl: "https://photon.komoot.io",
        )
      ],
      trufiRouter: TrufiRouter(
        routerDelegate: DefaultValues.routerDelegate(
          appName: 'Gdańsk Transport',
          cityName: 'Gdańsk',
          countryName: 'Polska',
          backgroundImageBuilder: (_) {
            return Image.asset(
              'assets/images/gdansk.png',
              fit: BoxFit.cover,
            );
          },
          urlFeedback: 'https://ztm.gda.pl',
          emailContact: 'ztm@gdansk.gda.pl',
          urlShareApp: 'https://example/share',
          shareBaseUri: Uri(
            scheme: "http",
            host: "trufi.example",
          ),
        ),
      ),
      trufiBaseTheme: TrufiBaseTheme(
        themeMode: ThemeMode.system,
        brightness: Brightness.dark,
        theme: standardTheme.copyWith(
          colorScheme:
              standardTheme.colorScheme.copyWith(secondary: accentColor),
        ),
        darkTheme: darkTheme.copyWith(
          colorScheme: darkTheme.colorScheme.copyWith(secondary: accentColor),
        ),
      ),
    ),
  );
}
