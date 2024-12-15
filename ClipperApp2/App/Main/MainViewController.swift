


import AppKit
import Foundation


protocol CollectionUpdater: AnyObject {
    func reloadCollection()
}

protocol DishWindowOpener: AnyObject {
    
    func openNewDishWindow()
    
    func openEditDishWindow(dish: Dish)
}


//protocol NewDisheWindowOpener: AnyObject {
//    func openNewDishWindow()
//}



class MainViewController: NSViewController {
    
    var lastSelectedIndexPath: IndexPath?
    
    
    var model = MainModel()
    
    
    @IBOutlet weak var dishesScrollView: NSScrollView!
    
    
    
    @IBOutlet weak var dishesClipView: NSClipView!
    
   
    @IBOutlet weak var dishesCollectionView: ClipperCollectionView!
    
 
    @IBAction func userDidClickDeleteButton(_ sender: NSButton) {
        let selectedIndexes = dishesCollectionView.selectionIndexes
        let singleSelectedIndex = selectedIndexes.first
        
        guard let singleSelectedIndex else { return }
        
        model.userWantsToDeleteDish(position: singleSelectedIndex)
        
    }
    
    @IBAction func userDidClickAddPlaceholderButton(_ sender: Any) {
        model.userWantsToAddPlaceholderDish()
    }
    
    
    @IBAction func userDidClickAddNewButton(_ sender: NSButton) {
        model.userWantsToCreateNewDish()
    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishesCollectionView.register(DishCell.self, forItemWithIdentifier: .init("dishCell"))
        dishesCollectionView.dataSource = self
        dishesCollectionView.isSelectable = true
        
        model.collectionUpdaterDelegate = self
        
       model.windowOpener = self
        
        model.viewIsReadyForData()
    }

    override var representedObject: Any? {
        didSet {
            
        }
    }

    // Implementación de DataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return model.dishes.count
    }
    
    enum DishColumn {
        static let name: NSUserInterfaceItemIdentifier = .init("name")
        static let deliveryPerson = NSUserInterfaceItemIdentifier("deliveryPerson")
    }
}

extension MainViewController: NSCollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: NSCollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let prueba = model.dishes.count
        return prueba
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // 1. Construimos o reciclamos item
        let item = collectionView.makeItem(
            withIdentifier: .init(rawValue: "dishCell"),
            for: indexPath
        )
        
        guard let dishCell = item as? DishCell else {
            return item
        }
        
       
        let dish = model.dishes[indexPath.item]
        
    
        dishCell.setDish(dish)
        
        return dishCell
    }
}


extension MainViewController: NSCollectionViewDelegate {
}

extension MainViewController: CollectionUpdater {
    
    func reloadCollection() {
        dishesCollectionView.reloadData()
    }
}





extension MainViewController: DishWindowOpener {
    
        func openNewDishWindow() {
    
            let newDishModel = NewDishFormModel(onAddDish: { newDish in
                self.model.newDishWasCreated(dish: newDish)
            })
    
    
            let newDishViewController = NewDishFormController(
                model: newDishModel
            )
    
            let window = NSWindow(contentViewController: newDishViewController)
    
            let windowController = NSWindowController(window: window)
    
            windowController.showWindow(nil)
        }
    
    
    func openEditDishWindow(dish: Dish) {
        
        let newDishModel = NewDishFormModel(
            dish: dish,
            onEditDish: { editedDish in
                self.model.dishWasEdited(dish: editedDish)
            }
        )
        
       
        let newDishViewController = NewDishFormController(
            model: newDishModel
        )
      
        let window = NSWindow(contentViewController: newDishViewController)
        
        let windowController = NSWindowController(window: window)
    
        windowController.showWindow(nil)
    }

}



extension MainViewController: ClipperCollectionViewDelegate {
    

    
    func collectionView(_ collectionView:NSCollectionView, menu:NSMenu?, at indexPath: IndexPath?) -> NSMenu? {
        lastSelectedIndexPath = indexPath
        let menu = NSMenu()
        menu
            .addItem(
                withTitle: "Edit",
                action: #selector(userDidClickEditOnContextualMenu),
                keyEquivalent: "e"
            )
        
        menu
            .addItem(
                withTitle: "Delete",
                action: #selector(userDidClickDeleteOnContextualMenu),
                keyEquivalent: "d"
            )
        
        return menu
    }
    
    @objc private func userDidClickEditOnContextualMenu() {
        guard let lastSelectedIndexPath else { return }
        
        //model.userWantsToEditBook(position: lastSelectedIndexPath.item)
        
        model.userWantsToEditDish(position: lastSelectedIndexPath.item)
    }
    
    @objc private func userDidClickDeleteOnContextualMenu() {
        guard let lastSelectedIndexPath else { return }
        
        //model.userWantsToDeleteBook(position: lastSelectedIndexPath.item)
        
        model.userWantsToDeleteDish(position: lastSelectedIndexPath.item)
    }
    
    
    

    
}

