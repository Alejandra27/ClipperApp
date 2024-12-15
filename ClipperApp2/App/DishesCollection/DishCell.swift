//
//  DishCollection.swift
//  ClipperApp2
//
//  Created by Mary on 29/11/24.
//

import Cocoa

extension NSView {
    
    var backgroundColor: NSColor? {
        get {
            guard let color = layer?.backgroundColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
    
    func getRoundedCorners() {
        wantsLayer = true
        layer?.masksToBounds = true
        layer?.cornerRadius = 10
    }
    
}


class DishImageView: NSImageView {
    
    override var image: NSImage? {
        get {
            return layer?.contents as? NSImage
        }
        set {
            layer = .init()
            layer?.contentsGravity = .resizeAspectFill
            layer?.contents = newValue
            wantsLayer = true
        }
    }
    
}




class DishCell: NSCollectionViewItem {
    

    var dish: Dish?
    
    
    
    @IBOutlet weak var coverImageView: DishImageView!
    
    @IBOutlet weak var coverImageView2: DishImageView!
    
    //@IBOutlet weak var dishImageView: NSImageView!
    
    
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var priceLabel: NSTextField!
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                view.backgroundColor = .systemBlue
                nameLabel.textColor = .white
                priceLabel.textColor = .white
            } else {
                view.backgroundColor = .clear
                nameLabel.textColor = .textColor
                priceLabel.textColor = .textColor
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.identifier = NSUserInterfaceItemIdentifier(rawValue: "dishCell")
        view.getRoundedCorners()
    }
    
   
    func setDish(_ dish: Dish) {
        self.dish = dish
        
        nameLabel.stringValue = dish.name
        priceLabel.stringValue = "$\(dish.price)"
        
        // TODO: Update Dish Image
        if let imageUrl = dish.imageURL {
            fetchDishImage(imageUrl)
        }
    }
    

    func fetchDishImage(_ url: URL) {
        print("Intentando descargar imagen del plato \(dish?.name ?? "Sin nombre") con URL: \(url.absoluteString)")
        setDishImage(image: nil)
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self else { return }
            
            
            if let error {
                
                self.setDishImage(image: nil)
                print(error.localizedDescription)
            }
            
            
            if let data {
                if let image = NSImage(data: data) {
                    
                    print(
                        "Descargamos satisfactoriamente la imagen del plato \(self.dish?.name)"
                    )
                    self.setDishImage(image: image)
                } else {
                
                    self.setDishImage(image: nil)
                }
            } else {
                
                self.setDishImage(image: nil)
            }
        }
        
        task.resume()
    }
    
    private func setDishImage(image: NSImage?) {
        DispatchQueue.main.async {
            self.coverImageView.image = image
        }
    }
    
}
