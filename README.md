# Circular Progress Button

A Qt Quick custom item for a circular progress button with interactive features.

## Overview

This Qt Quick project defines a custom circular progress button item that you can integrate into your Qt applications. The progress button features interactive behaviors like press-and-hold and release actions, and it can display an optional icon.

## Features

- Circular button with customizable size.
- Interactive press-and-hold and release actions.
- Configurable visual properties like colors, shadow, and stroke.
- Option to display an icon at the center of the button.

## Usage

To use this circular progress button in your Qt Quick application:

1. Include the `CircularProgressButton.qml` file in your project.
2. Add an instance of the `CircularProgressButton` item to your QML interface.
3. Configure the button's properties as needed, such as size and colors.
4. Connect to the `pressAndHold`, `pressAndHoldCustom`, `pressEnd`, and `released` signals to handle user interactions.
5. Optionally, set an icon using the `iconSource` property.

```qml
CircularProgressButton {
    id: myProgressButton
    width: 250
    height: 250
    // Customize other properties as needed
}

myProgressButton.onPressAndHold: {
    // Handle press-and-hold action
}

myProgressButton.onPressEnd: {
    // Handle press end action
}

myProgressButton.onReleased: {
    // Handle release action
}
```

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Author
[Yasin Akin](https://github.com/yasinakinn)

## Acknowledgments
We would like to acknowledge the following libraries and frameworks used in this project:

[Qt Quick](https://doc.qt.io/qt-6/qtquick-index.html): A powerful framework for developing user interfaces.
[Qt Quick Shapes](https://doc.qt.io/qt-6/qtquick-shapes-qmlmodule.html): A module for creating 2D graphics in Qt Quick.