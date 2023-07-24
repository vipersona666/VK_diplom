//
//  CustomButton.swift
//  VK
//
//  Created by Andrei on 15.07.2023.
//

import UIKit

class CustomButton: UIButton {

    var addTarget = {}
    
    init(title:String,
         textColor: UIColor,
         backgroundColorButton: UIColor,
         clipsToBoundsOfButton: Bool,
         cornerRadius: CGFloat,
         shadowOpacity: Float,
         shadowOffset: CGSize,
         translatesAutoresizingMask: Bool) {
        
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        tintColor = textColor
        backgroundColor = backgroundColorButton
        clipsToBounds = clipsToBoundsOfButton
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMask
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed(){
        addTarget()
    }
    
}

