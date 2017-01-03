# Themeable

Easy UIKit theming

__Please note:__ This is still a work in progress and not complete. The docs are incomplete and much will be
changing. I recommend not using this in production apps.

## Example Usage

```swift
import UIKit
import Themeable

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
    
}

// In your View or ViewController add a `themer` property, the `apply(theme:)` method and 
// call `self.themer.theme(self)` once your view has been initialised/loaded
final class ActivityTableViewController: UITableViewController, Themeable {

    let themer: Themer<ActivityTableViewController> = Themer(manager: AppDelegate.ThemingManager)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.themer.theme(self)
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
