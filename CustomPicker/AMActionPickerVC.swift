import UIKit

class AMActionPickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var btnCacel: UIButton!    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var btnBg: UIButton!
    @IBOutlet weak var lblPickerTitle: UILabel!
    @IBOutlet weak var viewPickerBottamConstant: NSLayoutConstraint!
    
    var selectedRow: Int = 0
    var arrPicker : [[String: Any]] = []

    var strDisplayTitle : String = ""

    
    //Completion Block
    typealias CompletionBlock = (Bool, Dictionary<String, Any>) -> Void
    var completionBlock : CompletionBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnCacel.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        self.btnDone.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)

        // Do any additional setup after loading the view.
        self.view.frame = UIScreen.main.bounds
        self.view.layoutIfNeeded()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectIndex(completion: @escaping (_ result: Bool, _ response: Dictionary<String, Any>)->()) {
        self.parent?.view.endEditing(true)
        completionBlock = completion
        
        
        self.btnBg.alpha = 0.0
        
        self.showWithAnimation()
    }
    
    //MARK: - Picker Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let title = self.arrPicker[row][strDisplayTitle]! as? String
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        let data = self.arrPicker[row][strDisplayTitle]!
        let title = NSAttributedString(string: data as! String, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightRegular)])
        label?.attributedText = title
        label?.textAlignment = .center
        return label!        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    //MARK: - IBAction
    
    @IBAction func btnBgClicked(_ sender: Any) {
        self.hideWithAnimation()

    }

    @IBAction func btnbCancelClicked(_ sender: Any) {
        self.hideWithAnimation()
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        self.hideWithAnimation()
        
        completionBlock!(true, arrPicker[selectedRow])
        
    }
    
    //MAR: - Animation
    func showWithAnimation() {
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.layoutIfNeeded()
            
            self.btnBg.alpha = 1.0
            self.viewPickerBottamConstant.constant = 0
            
            
        }) { (finished) in
            
            
        }
        
    }
    func hideWithAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            
            self.btnBg.alpha = 0.0
            self.viewPickerBottamConstant.constant = CGFloat(-264)
            self.view.layoutIfNeeded()
            
        }) { (finished) in
            
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
    }


}
