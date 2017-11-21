//
//  DetailedStockViewController.swift
//  Unit 3 HW - Parsing JSON
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class DetailedStockViewController: UIViewController {


    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var lowPrice: UILabel!
    var stock: Stock? = nil

    @IBOutlet weak var highPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let stock = stock{
            if stock.change! > 0{
                stockImage.image = #imageLiteral(resourceName: "bullish-1")
            }
            else{
                stockImage.image = #imageLiteral(resourceName: "bearish")
            }
            highPrice.text = "High price:" + (stock.high?.description)!
            lowPrice.text = "Low price:" + (stock.low?.description)!
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
