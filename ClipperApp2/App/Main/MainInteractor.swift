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
    

    
}
