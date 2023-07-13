//
//  ExtentionColor.swift
//  VK
//
//  Created by Andrei on 12.07.2023.
//

import Foundation
import UIKit

extension UIColor{
    static func createColor(ligthMode: UIColor, darkMode: UIColor) -> UIColor{
        guard #available(iOS 13.0, *) else { return ligthMode }
        return UIColor { (traitCollection) in
            return traitCollection.userInterfaceStyle == .light ? ligthMode : darkMode
        }
    }
    
}
