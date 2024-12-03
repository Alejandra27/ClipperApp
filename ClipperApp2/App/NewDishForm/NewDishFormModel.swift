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
        price: String,
        coverURLString: String
    ) {
        
        let dish = Dish(
            name: "Pizza",
            imageURL: URL(string: "https://www.hola.com/horizon/landscape/e9e1e82cb873-pepperoni-pizza-abob-t.jpg"),
            deliveryPerson: .init(
                name: "Juan Pérez",
                id: 557789
               
            ),
            price: 19800,
            category: .mainCourse
        )
        
        
        onAddDish(dish)
        
        windowCloser?.close()
    }
    
}
