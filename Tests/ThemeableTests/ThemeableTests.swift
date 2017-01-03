//
//  ThemeableTests.swift
//  ThemeableTests
//
//  Created by Edward Wellbrook on 30/12/2016.
//  Copyright © 2016-2017 Edward Wellbrook. All rights reserved.
//

import XCTest
import UIKit.UIView
import UIKit.UIColor
@testable import Themeable


let manager = ThemeManager<UITheme>(default: .white, forceDefault: true)

struct UITheme: Theme {
    let identifier: String
    let backgroundColor: UIColor

    static let white = UITheme(identifier: "co.brushedtype.Themeable.white-theme", backgroundColor: .white)
    static let black = UITheme(identifier: "co.brushedtype.Themeable.black-theme", backgroundColor: .black)

    static let variants: [UITheme] = [ .white, .black ]
}

final class ThemedView: UIView, Themeable {

    typealias ThemeType = UITheme

    let themer = Themer<ThemedView>(manager: manager)


    override init(frame: CGRect) {
        super.init(frame: frame)

        self.themer.theme(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func apply(theme: UITheme) {
        self.backgroundColor = theme.backgroundColor
    }

}

class ThemeableTests: XCTestCase {

    func testExample() {
        let view1 = ThemedView()

        // view has been created with correct theme
        XCTAssertEqual(view1.backgroundColor, UIColor.white)

        // change theme
        manager.theme = .black

        // verify view has changed with theme
        XCTAssertEqual(view1.backgroundColor, UIColor.black)

        let view2 = ThemedView()

        // verify new view has been created with latest theme
        XCTAssertEqual(view2.backgroundColor, UIColor.black)

        // verify theme manager uses last used theme
        XCTAssertEqual(UITheme.black, ThemeManager(default: .white).theme)
    }


    static var allTests : [(String, (ThemeableTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
