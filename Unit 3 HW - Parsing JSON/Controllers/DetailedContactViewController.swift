//
//  DetailedContactViewController.swift
//  Unit 3 HW - Parsing JSON
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class DetailedContactViewController: UIViewController {

    var contact: Contact? = nil
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var contactLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let contact = contact else{
            return
        }
        contactName.text = contact.name.first.capitalized + " " + contact.name.last!.capitalized
        contactEmail.text = contact.email!
        contactLocation.text = contact.location.city.capitalized + ", " + contact.location.state.capitalized
        contactImage.image = UIImage(data: contact.picture!.largToData)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
