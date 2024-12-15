//
//  ClipperCollectionView.swift
//  ClipperApp2
//
//  Created by Mary on 11/12/24.
//



import AppKit

protocol ClipperCollectionViewDelegate: AnyObject {
    func collectionView(_ collectionView:NSCollectionView, menu:NSMenu?, at indexPath: IndexPath?) -> NSMenu?
}

class ClipperCollectionView: NSCollectionView {
    
    weak var clipperDelegate: ClipperCollectionViewDelegate?
    
    override func menu(for event: NSEvent) -> NSMenu? {
        var menu = super.menu(for: event)
        
        let point = convert(event.locationInWindow, from: nil)
        let selectedIndexPath = indexPathForItem(at: point)
        
        guard let selectedIndexPath else { return nil }
        
        if let clipperDelegate {
            menu = clipperDelegate
                .collectionView(self, menu: menu, at: selectedIndexPath)
        }
        
        return menu
    }
    
}
