# Time Alerter (alert timer)

The app provides a user interface for setting an alert time. The alert shows on SteelSeries device illumination or on PC screen or plays a sound.
 
## Work in progress
These features are working on the windowed application:
- Setting the alert time by typing the hours, minutes and seconds. The digits can be incremented and decremented by buttons.
- Stopping the alert timer countdown with buttons.
- Showing the time remaining and counting down the digits of hours, minutes and seconds.
- Showing a popup window at the alert time. If the app is not on the foreground, it alerts the user by e.g. flashing the window icon at the taskbar. The popup can be switched off.
- Setting the duration of the alarm with a slider (e.g. how long the popup window is visible).
- An extra window that shows time only. The window can be hidden and restored via a menu.

Different alert execution types are under consideration: playing a sound, changing [SteelSeries device illumination](https://github.com/SteelSeries/gamesense-sdk) or popping up other notification.

A preview image of the user interface when the time is running:

<img class="screenshot2"
    src="media/screen2-9.png"
    alt="Rectangle containing green rectangle with text, numbers, sliders, buttons, yellow circle">

## Instructions - development
Prerequisite for the development version is installation of [Qt 6.4 (or higher)](https://www.qt.io/get-started) for desktop application development. The components Qt Quick and Qt Network are required. Components, including Qt sources, can be installed with the maintenance tool in the Qt install directory.

1. Get the app source files,
2. start Qt Creator and open CMakeLists.txt with it,
3. build the project by clicking the hammer icon,
4. run the app by clicking the green triangle.

## License and download
An executable file for Windows or other OS may eventually be considered, if release quality is reached and the licensing requirements are met. The license will be LGPL or GPL as dictated by [open source Qt licensing](https://www.qt.io/licensing/).
