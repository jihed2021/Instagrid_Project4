//
//  arrangementView.swift
//  AppAddImage
//
//  Created by Jihed Agrebaoui on 17/05/2021.
//

import UIKit

class ArrangementView: UIView, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    @IBOutlet var addImageViewUpLeft: UIButton!
    @IBOutlet var addImageViewUpRight: UIButton!
    @IBOutlet var addImageViewDownLeft: UIButton!
    @IBOutlet var addImageViewDownRight: UIButton!
    
    enum ArrangementType {
        case fourImage, twoImageUpOneDown, oneImageUpTwoDown
    }
    func setArrangement(_ style: ArrangementType) {
        switch style {
        case .fourImage:
            addImageViewUpLeft.isHidden = false
            addImageViewUpRight.isHidden = false
            addImageViewDownLeft.isHidden = false
            addImageViewDownRight.isHidden = false
            
        case .oneImageUpTwoDown:
            addImageViewUpLeft.isHidden = true
            addImageViewUpRight.isHidden = false
            addImageViewDownLeft.isHidden = false
            addImageViewDownRight.isHidden = false
        case .twoImageUpOneDown:
            addImageViewUpLeft.isHidden = false
            addImageViewUpRight.isHidden = false
            addImageViewDownLeft.isHidden = false
            addImageViewDownRight.isHidden = true
            
        }
    }
}
