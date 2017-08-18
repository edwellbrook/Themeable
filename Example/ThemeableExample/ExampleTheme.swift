//
//  ExampleTheme.swift
//  ThemeableExample
//
//  Created by Edward Wellbrook on 18/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit
import Themeable

// Define the theme and its properties to be used throughout your app
struct ExampleTheme: Theme {

    let identifier: String
    let labelTextColor: UIColor
    let backgroundColor: UIColor
    let tintColor: UIColor
    let statusBarStyle: UIStatusBarStyle


    static let light = ExampleTheme(
        identifier: "co.brushedtype.Themeable.light-theme",
        labelTextColor: .black,
        backgroundColor: .white,
        tintColor: .green,
        statusBarStyle: .default
    )

    static let dark = ExampleTheme(
        identifier: "co.brushedtype.Themeable.dark-theme",
        labelTextColor: .white,
        backgroundColor: .darkGray,
        tintColor: .yellow,
        statusBarStyle: .lightContent
    )


    // Expose the available theme variants
    static let variants: [ExampleTheme] = [ .light, .dark ]

    // Expose the shared theme manager
    static let manager = ThemeManager<ExampleTheme>(default: .light)

}
