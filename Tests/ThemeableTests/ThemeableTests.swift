//
//  ThemeableTests.swift
//  ThemeableTests
//
//  Created by Edward Wellbrook on 30/12/2016.
//  Copyright © 2016-2017 Edward Wellbrook. All rights reserved.
//

import XCTest
@testable import Themeable

let manager = ThemeManager<UITheme>(default: .white, forceDefault: true)

enum TestColor {
    case white, black
}

struct UITheme: Theme {

    let identifier: String
    let backgroundColor: TestColor

    static let white = UITheme(identifier: "co.brushedtype.Themeable.white-theme", backgroundColor: TestColor.white)
    static let black = UITheme(identifier: "co.brushedtype.Themeable.black-theme", backgroundColor: TestColor.black)

    static let variants: [UITheme] = [ .white, .black ]

}

class ThemedView: Themeable {

    var backgroundColor: TestColor = .white

    let themer = Themer<UITheme>(manager: manager)

    init() {
        self.themer.addThemeable(self)
    }

    func apply(theme: UITheme) {
        self.backgroundColor = theme.backgroundColor
    }

}

class ThemeableTests: XCTestCase {

    func testExample() {
        let view1 = ThemedView()

        // view has been created with correct theme
        XCTAssertEqual(view1.backgroundColor, TestColor.white)

        // change theme
        manager.theme = .black

        // verify view has changed with theme
        XCTAssertEqual(view1.backgroundColor, TestColor.black)

        let view2 = ThemedView()

        // verify new view has been created with latest theme
        XCTAssertEqual(view2.backgroundColor, TestColor.black)

        // verify theme manager uses last used theme
        XCTAssertEqual(UITheme.black, ThemeManager(default: .white).theme)
    }


    static var allTests : [(String, (ThemeableTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }

}
