import 'package:flutter/material.dart';
import 'package:flutter_music/pages/home_page/home.service.dart';
import 'package:flutter_music/shared/app.service.dart';

/// home 页面的drawer
class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 70,
            child: DrawerHeader(
              child: Center(child: Text('设置列表')),
            ),
          ),
          StreamBuilder(
            stream: appService.appConfig$,
            builder: (config, r) {
              if (r.connectionState == ConnectionState.waiting ||
                  !r.hasData) {
                return Container();
              }

              return ListTile(
                leading: Text(appService.isDark ? 'dark theme' : "light theme"),
                trailing: Switch(
                  activeColor: Theme.of(context).primaryColorDark,
                  activeTrackColor: Theme.of(context).primaryColorLight,
                  value: appService.isDark,
                  onChanged: (bool v) {
                    appService
                        .setTheme(v ? AppThemeState.Dark : AppThemeState.Light);
                  },
                ),
              );
            },
          ),
          Divider(),
          StreamBuilder(
            stream: homeService.config$,
            builder: (context, r) {
              if (r.connectionState == ConnectionState.waiting || !r.hasData) {
                return Container();
              }
              return ListTile(
                leading:
                    Text(homeService.isGrid ? 'grid layout' : 'list layout'),
                trailing: IconButton(
                  onPressed: () {
                    homeService.setLayout(homeService.isGrid
                        ? HomeLayoutState.list
                        : HomeLayoutState.grid);
                  },
                  icon: Icon(
                      homeService.isGrid ? Icons.grid_on : Icons.view_list),
                  color: Theme.of(context).primaryColorLight,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
