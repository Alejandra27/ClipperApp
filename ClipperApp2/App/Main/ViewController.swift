


import AppKit


protocol CollectionUpdater: AnyObject {
    func reloadCollection()
}

protocol WindowOpener: AnyObject {
    
    func openNewDishWindow()
}


protocol NewDisheWindowOpener: AnyObject {
    func openNewDishWindow()
}



class ViewController: NSViewController {
    
   
    var model = MainModel()
    
   
    @IBOutlet weak var dishesCollectionView: NSCollectionView!
    
 
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
        
        model.collectionUpdater = self
        
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

extension ViewController: NSCollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: NSCollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return model.dishes.count
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

extension ViewController: CollectionUpdater {
    
    func reloadCollection() {
        dishesCollectionView.reloadData()
    }
}


extension ViewController: WindowOpener {
    
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
    

    
}

