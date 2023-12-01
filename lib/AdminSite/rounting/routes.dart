const rootRoute = "/";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const driversPageDisplayName = "Daily Presenty";
const driversPageRoute = "/daily_presenty";

const clientsPageDisplayName = "Students";
const clientsPageRoute = "/students";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";
const homePageRoute='/home';
class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}



List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(driversPageDisplayName, driversPageRoute),
  MenuItem(clientsPageDisplayName, clientsPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];