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
        
        collectionUpdater?.reloadCollection()
    }
    
    mutating func userWantsToAddPlaceholderDish() {
        let placeholderDish = Dish.HotDog
        dishes.append(placeholderDish)
        
        collectionUpdater?.reloadCollection()
    }
    
    func userWantsToCreateNewDish() {
        windowOpener?.openNewDishWindow()
    }
    
    mutating func newDishWasCreated(dish: Dish) {
        dishes.append(dish)
        collectionUpdater?.reloadCollection()
    }
    
    
    func viewIsReadyForData() {
        
    }
//    
//    func userWantsToEditDish(position: Int) {
//        let dish = dishes[position]
//        windowOpener?.openEditDishWindow(dish: dish))
//    }
//    
   
}
