//
//  CustomTextField.swift
//  FirebaseChat
//
//  Created by Fedor on 19.12.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [.foregroundColor : UIColor.white])
        
        self.font = UIFont.systemFont(ofSize: 16)
        self.placeholder = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
