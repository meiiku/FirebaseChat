//
//  InputContainerView.swift
//  FirebaseChat
//
//  Created by Fedor on 19.12.2022.
//

/* Login-screen and registration contain much same elements - containers with icon and tf.
 This file contains a custom class for each container*/

import UIKit

class InputContainerView: UIView {
    
    init(imageName: String, textField: UITextField) {
        super.init(frame: .zero)
        
        self.setHeight(height: 50)
        self.backgroundColor = .clear
        
        // icon
        let iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: imageName)
            imageView.tintColor = .white
            return imageView
        }()
        
        self.addSubview(iconImageView)
        iconImageView.centerY(inView: self)
        iconImageView.anchor(left: self.leftAnchor, paddingLeft: 8)
        iconImageView.setDimensions(height: 22, width: 24)
        
        // text-field
        self.addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(top: self.topAnchor, left: iconImageView.rightAnchor,
                         bottom: self.bottomAnchor, right: self.rightAnchor,
                         paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        // separator
        let separatorView: UIView = {
            let separator = UIView()
            separator.backgroundColor = .white
            return separator
        }()
        
        self.addSubview(separatorView)
        separatorView.anchor(left: self.leftAnchor, bottom: self.bottomAnchor,
                             right: self.rightAnchor, paddingLeft: 8, paddingRight: 8,
                             height: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
