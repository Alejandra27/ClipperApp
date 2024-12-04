//
//  NewDishFormModel.swift
//  ClipperApp2
//
//  Created by Mary on 2/12/24.
//

import Foundation

struct NewDishFormModel {
    
    
    weak var windowCloser: WindowCloser?
    
   
    var onAddDish: (Dish) -> Void = { dish in print(dish) }
    

    func userWantsToCancelDishCreation() {
        windowCloser?.close()
    }
    
    func userWantsToConfirmDishCreation(
        name: String,
        price: Double,
        coverURLString: String
    ) {
        
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
