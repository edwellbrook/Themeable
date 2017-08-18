//
//  ViewController.swift
//  ThemeableExample
//
//  Created by Edward Wellbrook on 18/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit
import Themeable

class ViewController: UIViewController, Themeable {

    @IBOutlet weak var textLabel: UILabel?
    @IBOutlet weak var toggle: UISwitch?


    override func viewDidLoad() {
        super.viewDidLoad()

        // register the themeable items once all the view and subviews
        // have been loaded
        ExampleTheme.manager.register(themeable: self)

        // setting the default value for the toggle
        let isInDarkTheme = ExampleTheme.manager.activeTheme == .dark
        self.toggle?.setOn(isInDarkTheme, animated: false)
    }


    // function will be called whenever the theme changes
    func apply(theme: ExampleTheme) {

        // set subview color values
        self.textLabel?.textColor = theme.labelTextColor
        self.toggle?.onTintColor = theme.tintColor

        // use values that aren't colors
        UIApplication.shared.statusBarStyle = theme.statusBarStyle

        // or animate changes
        UIView.animate(withDuration: 0.5) { 
            self.view.backgroundColor = theme.backgroundColor
        }
    }


    // change the theme when the switch is toggled
    @IBAction func toggleTheme(_ sender: AnyObject) {
        let useDarkTheme = self.toggle?.isOn == true

        if useDarkTheme {
            ExampleTheme.manager.activeTheme = .dark
        } else {
            ExampleTheme.manager.activeTheme = .light
        }
    }

}
