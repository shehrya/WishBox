//
//  ItemsDetailsVC.swift
//  WishBox
//
//  Created by Shehryar Khan on 27.11.17.
//  Copyright © 2017 Shehryar Khan. All rights reserved.
//

import UIKit
import CoreData

class ItemsDetailsVC: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet var storePicker: UIPickerView!
    @IBOutlet var titleField: CustomTextField!
    @IBOutlet var priceField: CustomTextField!
    @IBOutlet var detailsField: CustomTextField!
    @IBOutlet var thumgImg: UIImageView!
    
    var stores = [Store]()
    var itemTypes = [ItemType]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        storePicker.delegate = self
        storePicker.dataSource = self
        titleField.delegate = self
        priceField.delegate = self
        detailsField.delegate = self
      

        
//        collectionView?.keyboardDismissMode = .interactive
        
        
        getItemTypes()
        generateTestData()
        generateItemTypeData()

        getStores()
        
        if itemToEdit != nil  {
            loadItemData()
        }
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when   'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        titleField.resignFirstResponder()
        detailsField.resignFirstResponder()
        priceField.resignFirstResponder()
        
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let store = stores[row]
            return store.name
        } else if component == 1 {
            let itemType = itemTypes[row]
            return itemType.type
        } else {
            return "tttttt" //error
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return stores.count
        } else if component == 1 {
            return itemTypes.count
        } else {
            return -1 //throw error
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // update when seelcted
    }
    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
            
        } catch {
            
            // handle the error
        }
    }
    
    func getItemTypes() {
        
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        
        do {
            self.itemTypes = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            
            //handle the error
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumgImg.image
        
        if itemToEdit == nil {
            
            item = Item(context: context)
            
        } else {
            
            item = itemToEdit
            
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            
            item.title = title
            
        }
        
        if let price = priceField.text {
            
            item.price = (price as NSString).doubleValue
            
        }
        
        if let details = detailsField.text {
            
            item.details = details
            
        }
     
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        item.toItemType = itemTypes[storePicker.selectedRow(inComponent: 1)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            thumgImg.image = item.toImage?.image as? UIImage
            
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
            
            if let itemType = item.toItemType {
                var index = 0
                repeat {
                    let iT = itemTypes[index]
                    if iT.type == itemType.type {
                        storePicker.selectRow(index, inComponent: 1, animated: false)
                    }
                    index += 1
                } while (index < itemTypes.count)
            }
        }
        
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
            if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
                
                thumgImg.image = img
            }
            
            imagePicker.dismiss(animated: true, completion: nil)
        }
    func generateTestData() {
        generateStoreData()
//        generateItemTypeData()
        ad.saveContext()
    }
    
    func generateStoreData() {
        let store = Store(context: context)
        store.name = "Edeka"
        let store2 = Store(context: context)
        store2.name = "Tesla Dealership"
        let store3 = Store(context: context)
        store3.name = "BMW carrier"
        let store4 = Store(context: context)
        store4.name = "REWE"
        let store5 = Store(context: context)
        store5.name = "Amazon"
        let store6 = Store(context: context)
        store6.name = "Media Markt"
    }
    
    func generateItemTypeData() {
        let itemType = ItemType(context: context)
        itemType.type = "Art"
        
        let itemType2 = ItemType(context: context)
        itemType2.type = "Fashion"
        
        let itemType3 = ItemType(context: context)
        itemType3.type = "Electronics"
        
        let itemType4 = ItemType(context: context)
        itemType4.type = "Entertainment"
        
        let itemType5 = ItemType(context: context)
        itemType5.type = "Home and Garden"
        
        let itemType6 = ItemType(context: context)
        itemType6.type = "Motors"
        
        let itemType7 = ItemType(context: context)
        itemType7.type = "Sporting Goods"
        
        let itemType8 = ItemType(context: context)
        itemType8.type = "Books"
        
        let itemType9 = ItemType(context: context)
        itemType9.type = "Toys"
        
        let itemType10 = ItemType(context: context)
        itemType10.type = "Others"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
