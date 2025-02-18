import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    private var pctButtons: [UIButton] = []
    private var tip = Tip()
    private var tipBrain = TipBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pctButtons.append(contentsOf: [zeroPctButton, tenPctButton, twentyPctButton])
        // Init tip rate and split count ->
        tip.tipRate = 0.1
        tip.splitCount = 2
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        sender.isSelected = true
        // Remove other selected items
        for (index, button) in pctButtons.enumerated() {
            if button === sender {
                switch(index) {
                    case 0: tip.tipRate = 0.0
                    case 1: tip.tipRate = 0.1
                    case 2: tip.tipRate = 0.2
                    default: break
                }
            }else {
                button.isSelected = false
            }
        }
        
        // Remove focus in Textfield
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let splitCount = Int(sender.value)
        splitNumberLabel.text = String(splitCount)
        tip.splitCount = splitCount
    }
    
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        // Find the selected tip rate
        let billAmountText = billTextField.text?.replacingOccurrences(of: ",", with: ".") ?? "0"
        
        if let billAmountText = Double(billAmountText) {
            tip.amount = billAmountText
            tipBrain.calculatePeymentPerPerson(tip: tip)
            // Go to result view controller ->
            performSegue(withIdentifier: "calculatorToResult", sender: self)
            
        }else {
            // Invalid entry
            showAlert(message: "Please enter a valid bill amount")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calculatorToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.tip = tip
            destinationVC.result = tipBrain.getPeymentPerPerson()
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Entry", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
