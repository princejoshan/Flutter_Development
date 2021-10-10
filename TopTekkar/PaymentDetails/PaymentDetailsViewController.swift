//
//  PaymentDetailsViewController.swift
//  TopTekkar
//
//  Created by Prince  on 30/09/21.
//

import UIKit

class PaymentDetailsViewController: UIViewController {

    @IBOutlet weak var sportImage: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    
    @IBOutlet weak var sportDate: UILabel!
    
    @IBOutlet weak var sportTimings: UILabel!
    
    @IBOutlet weak var turfFee: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var applyPromoCodeButton: UIButton!
    @IBOutlet weak var totalAmt: UILabel!
    
    @IBOutlet weak var totalAmtTitle: UILabel!
    @IBOutlet weak var advanceToPay: UILabel!
    @IBOutlet weak var conveniencePay: UILabel!
    @IBOutlet weak var amtToPayNow: UILabel!
    @IBOutlet weak var amtToPayableAtCourt: UILabel!
    @IBOutlet weak var cancellationPolicy: UILabel!
    @IBOutlet weak var termsOfService: UILabel!
    @IBOutlet weak var confirmBookButton: UIButton!
    @IBOutlet weak var amtToPayNowTitle: UILabel!
    @IBOutlet weak var AmtPayableAtCourtTitle: UILabel!
    @IBOutlet weak var SportsTitleBackgroundView: UIView!
    
    @IBOutlet weak var amountToPayNowBgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()

        // Do any additional setup after loading the view.
    }
    
    func initialSetup() {
        totalAmtTitle.textColor = UIColor.MyApp.colorPrimary
        totalAmt.textColor = UIColor.MyApp.colorPrimary
        amtToPayNowTitle.textColor = UIColor.MyApp.colorPrimary
        AmtPayableAtCourtTitle.textColor = UIColor.MyApp.colorPrimary
        self.applyPromoCodeButton.cornerRadius()
        self.applyPromoCodeButton.shadowEffect()
        self.SportsTitleBackgroundView.cornerRadius()
        self.SportsTitleBackgroundView.shadowEffect()
        self.amountToPayNowBgView.cornerRadius()
        self.amountToPayNowBgView.shadowEffect()
        self.cancellationPolicy.text = "0-3 hrs prior to slot: Cancellation not allowed.>3 hrs prior to slot:5.0% of Gross Amount will be deducted as cancellation fee from your next booking"
        self.termsOfService.text = "By continuing,you agree to our terms of service"
    }
    
    @IBAction func confirmBookAction(_ sender: UIButton) {
    }
    
    @IBAction func applyPromoCodeAction(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
