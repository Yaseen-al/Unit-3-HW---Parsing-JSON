//
//  StocksData.swift
//  Unit 3 HW - Parsing JSON
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation

class Stock {
    let date: String
    let open: Double?
    let low: Double?
    let high: Double?
    let volume: Int?
    let change: Double?
    
    init(date:String, open: Double?, low: Double?, high:Double?, volume:Int?, change:Double?) {
        self.date = date
        self.open = open
        self.low = low
        self.high = high
        self.volume = volume
        self.change = change
    }
    convenience init?(from JSONDict: [String: Any]) {
        guard let date = JSONDict["date"] as? String else{return nil}
        let open = JSONDict["open"] as? Double
        let low = JSONDict["low"] as? Double
        let high = JSONDict["high"] as? Double
        let volume = JSONDict["volume"] as? Int
        let change = JSONDict["change"] as? Double
        self.init(date: date, open: open, low: low, high: high, volume: volume, change: change)
    }
    
   static func getStocks(from data: Data) -> [Stock] {
        var stocks = [Stock]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let stocksDictionary = json as? [[String: Any]]{
                for stock in stocksDictionary{
                    if let stock = Stock(from: stock){
                        stocks.append(stock)
                    }
                }
            }
        }
        catch let error{
            print(error)
        }
         return stocks
    }
   
}













