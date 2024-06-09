import SwiftUI

struct SwiftUIColor {
    static let yellowColor = Color.yellow
    static let blackColor = Color.black
    static let whiteColor = Color.white
    static let greenColor = Color.green
    static let redColor = Color.red
    static let blueColor = Color.blue
    static let clearColor = Color.clear
    static let grayColor = Color.gray
    static let pinkColor = Color.pink
    static let orangeColor = Color.orange
    @available(iOS 15.0, *)
    static let mintColor = Color.mint
    @available(iOS 15.0, *)
    static let indigoColor = Color.indigo
    static let textWhite = Color.white
    static let textBlack = Color.black
    static let textGray = Color.gray
    static let textOrange = Color(
        red: Double(255) / 255.0,
        green: Double(144) / 255.0,
        blue: Double(0) / 255.0,
        opacity: 1.0
    )
}
