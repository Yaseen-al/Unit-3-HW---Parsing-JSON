//
//  StocksViewController.swift
//  Unit 3 HW - Parsing JSON
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    var myStocks = [Stock]()
    @IBOutlet weak var myStocksSearchBar: UISearchBar!
    @IBOutlet weak var myStocksTableView: UITableView!
    
    // Mark SearchBar: Methods and required properites
    var filteredStocks:[Stock]{
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return myStocks
        }
        return myStocks.filter{$0.date.lowercased().contains(searchTerm.lowercased())}
    }
    var searchTerm: String?{
        didSet{
            myStocksTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text
    }
    
    // Mark TableView: Required two methods for number of rows as well as cell and assign delegates and data source
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        return 12
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let currentSection = section + 1
        
        return "Section\(section)"
    }
 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStocks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stockSetup = filteredStocks[indexPath.row]
        guard let cell: UITableViewCell = myStocksTableView.dequeueReusableCell(withIdentifier: "myCell") else{
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = "Date: \(stockSetup.date), Open: \(String(describing: stockSetup.open))"
            return defaultCell
        }
        cell.textLabel?.text = stockSetup.date
        cell.detailTextLabel?.text = String(describing: stockSetup.open!)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myStocksTableView.delegate = self
        self.myStocksTableView.dataSource = self
        self.myStocksSearchBar.delegate = self
        loadData()
        print("you are in the stocks")
        // Do any additional setup after loading the view.
    }

    func loadData() {
        if let path = Bundle.main.path(forResource: "stocksRaw", ofType: "json"){
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL){
                let stocks = Stock.getStocks(from: data)
                self.myStocks = stocks
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedStockViewController{
            let indexPath = myStocksTableView.indexPathForSelectedRow
            destination.stock = filteredStocks[(indexPath?.row)!]
        }
        
    }

}
