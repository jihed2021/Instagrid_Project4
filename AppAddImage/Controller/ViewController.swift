//
//  ViewController.swift
//  AppAddImage
//
//  Created by Jihed Agrebaoui on 17/05/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    @IBOutlet weak var viewForAddingImage: ArrangementView!
    
    @IBOutlet var selectedButtons: [UIButton]!
    @ IBOutlet var addImageButtons: [UIButton]!
    
    var button: UIButton!
    
    // affect choose layout to the boutton
    @IBAction func chooseLayout(_ sender: UIButton) {
        for button in selectedButtons {
            button.isSelected = false
        }
        sender.isSelected = true
        switch sender {
        case selectedButtons[0]:
            viewForAddingImage.setArrangement(.oneImageUpTwoDown)
        case selectedButtons[1]:
            viewForAddingImage.setArrangement(.fourImage)
        case selectedButtons[2]:
            viewForAddingImage.setArrangement(.twoImageUpOneDown)
        default:
            break
        }
    }
    
    //    Add image to the button
    @IBAction func addImage(_ sender: UIButton) {
        
        for ButtontoAddImage in addImageButtons {
            ButtontoAddImage.isSelected = false
        }
        sender.isSelected = true
        switch sender {
        case addImageButtons[3]:
            button = addImageButtons[3]
            addImage()
        case addImageButtons[2]:
            button = addImageButtons[2]
            addImage()
        case addImageButtons[0]:
            button = addImageButtons[0]
            addImage()
        case addImageButtons[1]:
            button = addImageButtons[1]
            addImage()
        default:
            break
        }
    }
    
    //    affect image with UIImageOickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            button.setImage(pickedImage, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    // function to add image to the button backgroud
    func addImage() {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        imageController.allowsEditing = true
        present(imageController, animated: true, completion: nil)
    }
    //    var orientation: "UIInterfaceOrientation = .landscapeLeft
    var swipeOrientation: UISwipeGestureRecognizer.Direction = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Do any additional setup after loading the view.*/
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeImage(_:)))
        viewForAddingImage.addGestureRecognizer(swipe)
        swipe.direction = swipeOrientation
    }
    
    override func didRotate (from fromInterfaceOrientation: UIInterfaceOrientation) {
        switch fromInterfaceOrientation {
        case .landscapeLeft, .landscapeRight:
            swipeOrientation = .left
        case .portrait,.portraitUpsideDown:
            swipeOrientation = .up
        default:
            break
        }
    }
    
    // add gesture to view
    @objc func swipeImage(_ sender : UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up:
            animateImagesWith(tanslation: 0, y: -view.frame.height)
        case .left:
            animateImagesWith(tanslation:  -view.frame.width, y: 0)
        default:
            break
        }
    }
    
    //    func to add gesture to View
    private func animateImagesWith(tanslation x:CGFloat, y:CGFloat) {
        UIView.animate(withDuration: 0.5, animations:{
            self.viewForAddingImage.transform = CGAffineTransform(translationX: x, y: y)
            self.ShareImage()
        }){(completed) in
            if completed {
                self.viewForAddingImage.transform = CGAffineTransform(translationX: -x, y: -y)
                self.animateBackToCenter()
            }
        }
    }
    
    // func to reset view
    private func animateBackToCenter(){
        UIView.animate(withDuration: 0.5, animations: {
            self.viewForAddingImage.transform = .identity
        }, completion: nil)
    }
    
    //  func to share Image with UIActivitycontroller
    private func ShareImage() {
        let image = image(from: viewForAddingImage)
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    private func image(from view: UIView) -> UIImage {
        let image = UIGraphicsImageRenderer(size: view.bounds.size)
        return image.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }
    
}
