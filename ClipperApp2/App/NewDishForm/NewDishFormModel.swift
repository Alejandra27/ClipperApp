//
//  NewDishFormModel.swift
//  ClipperApp2
//
//  Created by Mary on 2/12/24.
//

import Foundation

struct NewDishFormModel {
    
    
    var dish: Dish?
    
    weak var windowCloser: WindowCloser?
    
   
    var onAddDish: (Dish) -> Void = { dish in print(dish) }
    var onEditDish: (Dish) -> Void = { dish in print(dish) }
    

    func userWantsToCancelDishCreation() {
        windowCloser?.close()
    }
    
    
    
    
    
    
    
    func userWantsToConfirmDishCreation(
        name: String,
        price: Double,
        coverURLString: String
    ) {
        
        if var dish = dish {
            let somethingChanged = dish.name != name || dish.price != price || dish.imageURL?.absoluteString != coverURLString
            
            if !somethingChanged {
                windowCloser?.close()
                return
            }
            
            dish.name = name
            dish.price = price
            dish.imageURL = URL(string: coverURLString)
            
            // We trigger the dish update
            onEditDish(dish)
            
            // Then:
            windowCloser?.close()
        } else {
            // We create the dish
            let dish = Dish(
                name: name,
                imageURL: URL(string: coverURLString),
                deliveryPerson: .init(
                    name: name,
                    id: 557789
                   
                ),
                price: price,
                category: .mainCourse
            )
            
            
            onAddDish(dish)
            
            windowCloser?.close()
        }
    }
    
}
        
        
        
        
        
        
