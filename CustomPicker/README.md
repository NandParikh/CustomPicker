# CustomPicker
if(self.arrWhat.count > 0){
    let amPicker = AMActionPickerVC(nibName: "AMActionPickerVC", bundle: nil)
    amPicker.arrPicker = self.arrWhat
    amPicker.strDisplayTitle = "name"
    self.parent!.view.addSubview(amPicker.view)
    self.parent!.addChildViewController(amPicker)

    amPicker.lblPickerTitle.text = NSLocalizedString("Which category", comment: "")

    amPicker.selectIndex { (sucess, response) in
        self.txtWhat.text = response["name"]! as? String
        self.intSelectedCategoryId = (response["id"] as? Int)!
        print("Category Id is \(self.intSelectedCategoryId)")
        self.textView.becomeFirstResponder()
    }
}

# CustomPicker
