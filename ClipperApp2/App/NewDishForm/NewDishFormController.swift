//
//  NewDishFormController.swift
//  ClipperApp2
//
//  Created by Mary on 2/12/24.
//

import Cocoa

import Foundation

extension NSButton {
    
    func change(color: NSColor) {
    
    }
}

extension NSTextField {
    
    func setOutlineColor(_ color: NSColor, borderWidth: CGFloat) {
       
        self.layer?.borderColor = color.cgColor
        self.layer?.borderWidth = borderWidth
    }
    
}

class NewDishFormController: NSViewController {
    
    
    var model: NewDishFormModel
    
    @IBOutlet weak var cancelButton: NSButton!
    
    
    
    @IBAction func userDidClickCancelButton(_ sender: Any) {
        model.userWantsToCancelDishCreation()
    }
    
    @IBOutlet weak var dishImageURL: NSTextField!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var priceLabel: NSTextField!
    
    
    init(model: NewDishFormModel) {
        self.model = model
        super.init(nibName: "NewDishFormController",
                   bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.delegate = self
        priceLabel.delegate = self
        dishImageURL.delegate = self
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.title = "New Dish"
        
        cancelButton.contentTintColor = .red
        
        
        cancelButton.change(color: .red)
        
        model.windowCloser = self
        
        if let dish = model.dish {
            apply(dish: dish)
        }

    }

    
    
        
    @IBAction func userDidClickDoneButton(_ sender: NSButton) {
        if let missingField = validateForm() {
            missingField.swithToMissingInfoStyle("Required text here")
            return
        }
        
        model
            .userWantsToConfirmDishCreation(
                name: nameLabel.stringValue,
                price: priceLabel.doubleValue,
                coverURLString: dishImageURL.stringValue
            )
    }
    
    
    private func apply(dish: Dish) {
        view.window?.title = "Edit Book: \(dish.name)"
        //headingLabel.stringValue = "Edit Dish"
        nameLabel.stringValue = dish.name
        priceLabel.doubleValue = dish.price
        dishImageURL.stringValue
        = dish.imageURL?.absoluteString ?? ""
    }
    
    private func validateForm() -> NSTextField? {
        let fieldsToEvaluate: [NSTextField] = [
            nameLabel, priceLabel, dishImageURL
        ]
        
        return fieldsToEvaluate.first(where: { $0.stringValue.isEmpty })
    }
    
}

extension NewDishFormController: WindowCloser {
    
    func close() {
        view.window?.close()
    }
    
}

extension NewDishFormController: NSTextFieldDelegate {
    
    func controlTextDidChange(_ notification: Notification) {
        let textField = notification.object as! NSTextField
        if textField.stringValue.isEmpty == false {
            textField.switchToOriginalStyle()
        }
    }
    
}
