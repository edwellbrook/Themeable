# Themeable

[![Build Status](https://travis-ci.org/edwellbrook/Themeable.svg?branch=master)](https://travis-ci.org/edwellbrook/Themeable)

Easy UIKit theming

__Please note:__ This is still a work in progress and not complete. The docs are incomplete and much will be
changing. I recommend not using this in production apps.

## Features

- Type-safe API
- Transparent memory management
- Automatically reuse last used theme
- Thread safe UI updates
- Theme Views and Controls without subclassing
- Extremely flexible (build and load your theme the way that works for you)

## Installation

Installing with [CocoaPods](https://cocoapods.org):

```ruby
# In your Podfile add the following, then
# save and run `pod install`:
pod 'Themeable'
```

## Example Usage

```swift
import UIKit
import Themeable

// Set global/singleton ThemeManager somewhere
let ThemingManager = ThemeManager<MyAppTheme>(default: .light)

// Define the theme and its properties to be used throughout your app
struct MyAppTheme: Theme {

    let identifier: String
    let seperatorColor: UIColor
    let lightBackgroundColor: UIColor
    let statusBarStyle: UIStatusBarStyle

    static let light = MyAppTheme(
        identifier: "co.brushedtype.Themeable.light-theme",
        seperatorColor: .lightGray,
        lightBackgroundColor: .white,
        statusBarStyle: .default
    )

    static let dark = MyAppTheme(
        identifier: "co.brushedtype.Themeable.dark-theme",
        seperatorColor: .black,
        lightBackgroundColor: .gray,
        statusBarStyle: .lightContent
    )

    // Expose the available theme variants
    static let variants: [MyAppTheme] = [ .light, .dark ]

}

// In your View or ViewController add a `themer` property, the `apply(theme:)` method and
// call `self.themer.addThemeable(self)` once your view has been initialised/loaded
class TableViewController: UITableViewController, Themeable {

    let themer: Themer<MyAppTheme> = Themer(manager: ThemingManager)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.themer.addThemeable(self)
    }

    // function will be called whenever the theme changes
    func apply(theme: MyAppTheme) {
        self.tableView.separatorColor = theme.seperatorColor
        self.tableView.backgroundColor = theme.lightBackgroundColor
    }

}
```

## License

The MIT License (MIT)
