//
//  MainInteractor.swift
//  ClipperApp2
//
//  Created by Mary on 30/11/24.
//

import Foundation

extension MainModel {
    
  
    mutating func userWantsToDeleteDish(position: Int) {
        
        dishes.remove(at: position)
        
        collectionUpdaterDelegate?.reloadCollection()
    }
    
    mutating func userWantsToAddPlaceholderDish() {
        let placeholderDish = Dish.HotDog
        dishes.append(placeholderDish)
        
        collectionUpdaterDelegate?.reloadCollection()
    }
    
    func userWantsToCreateNewDish() {
        windowOpener?.openNewDishWindow()
    }
    
    mutating func newDishWasCreated(dish: Dish) {
        dishes.append(dish)
        collectionUpdaterDelegate?.reloadCollection()
    }
    
    
    func userWantsToEditDish(position: Int) {
        let dish = dishes[position]
        
        windowOpener?.openEditDishWindow(dish: dish)
    }
    
    
    func viewIsReadyForData() {
        
    }
    
    
    mutating func dishWasEdited(dish: Dish) {
        let index = dishes.firstIndex(where: {
            $0.name == dish.name
        })
        
        // Precondicionales
        guard let index else {
            // TODO: Display error on UI
            return
        }
        
        dishes[index] = dish
        collectionUpdaterDelegate?.reloadCollection()
    }
    
    
    
    
    mutating func dishWasEditedV2(dish: Dish) {
    
        let index = dishes.firstIndex(where: {$0.name == dish.name
        
        })
        
        // Precondicionales
        guard let index else {
            
            return
        }
        dishes[index] = dish
        collectionUpdaterDelegate?.reloadCollection()
        
    }

   
}
