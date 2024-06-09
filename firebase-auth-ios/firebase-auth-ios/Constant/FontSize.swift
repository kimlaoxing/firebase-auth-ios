import SwiftUI

enum FontSize: CGFloat {
    case largeTitle = 34
    case title = 28
    case headline = 22
    case subheadline = 20
    case body = 17
    case callout = 16
    case subtext = 15
    case footnote = 13
    case tabBarItem = 10
    
    func font(weight: Font.Weight = .regular) -> Font {
        return Font.system(size: self.rawValue, weight: weight)
    }
}
