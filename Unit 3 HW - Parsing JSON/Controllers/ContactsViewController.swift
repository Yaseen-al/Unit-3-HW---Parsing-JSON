//
//  ContactsViewController.swift
//  Unit 3 HW - Parsing JSON
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    var myContacts = [Contact]()
    @IBOutlet weak var myContactsTableView: UITableView!
    @IBOutlet weak var myContactsSearchBar: UISearchBar!
    // Mark: Search Bar Methods and required Properties
    var filteredContacts: [Contact]{
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return myContacts.sorted{String(describing: $0.name.first.first) < String(describing: $1.name.first.first)}
        }
        
        return myContacts.filter{$0.name.first.lowercased().contains(searchTerm.lowercased())}
    }
    var searchTerm: String?{
        didSet{
            myContactsTableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }
    
    func loadContactData() {
        if let path = Bundle.main.path(forResource: "contactsRaw", ofType: "json"){
        let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL){
                let myDecoder = JSONDecoder()
                do{
                    let contacts = try myDecoder.decode(Results.self, from: data)
                    self.myContacts = contacts.results
                }
                catch let error{
                    print(error)
                }
            }
        }
//        for contact in myContacts{
//            print(contact.gender, contact.name.first.capitalized)
//        }
    }
    
    
    //Mark: tableView  RequiredMethods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactSetup = filteredContacts[indexPath.row]
        guard let cell:UITableViewCell = myContactsTableView.dequeueReusableCell(withIdentifier: "myCell") else {
            let defaultCCell = UITableViewCell()
            defaultCCell.textLabel?.text = contactSetup.name.first
            return defaultCCell
        }
        cell.textLabel?.text = contactSetup.name.first.capitalized + " " + contactSetup.name.last!.capitalized
        cell.detailTextLabel?.text = "City: \(contactSetup.location.city.capitalized)"
//        let myURL = URL(string: contactSetup.picture!.thumbnail)!
//        DispatchQueue.global().async {
//            let data = try! Data(contentsOf: myURL)
//
//            DispatchQueue.main.async {
//                cell.imageView?.image = UIImage(data: data)
//            }
//        }
        cell.imageView?.image = UIImage(data: contactSetup.picture!.thumbnailToData)
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myContactsTableView.delegate = self
        self.myContactsTableView.dataSource = self
        self.myContactsSearchBar.delegate = self
        loadContactData()
        print("you are in the contacts")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedContactViewController{
            let indexPath = myContactsTableView.indexPathForSelectedRow
            destination.contact = filteredContacts[(indexPath?.row)!]
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
