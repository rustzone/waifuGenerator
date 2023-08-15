//
//  WaifuManager.swift
//  waifuGenerator
//
//  Created by vladislav bek on 14.08.23.
//

import Foundation

protocol sendWaifuDelegate {
    func sendWaifu(_ waifu: Waifu)
}

class WaifuManager {
    
    var delegate: sendWaifuDelegate?
    
    func getWaifu() {
        let urlString = "https://api.waifu.im/search"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if error != nil {
                    print("networing error")
                } else {
                    if let safeData = data {
                        let waifu = self.parseJSON(safeData)
                        self.delegate?.sendWaifu(waifu)
                    }
                }
            })
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Waifu {
        let decoder = JSONDecoder()
        do {
            let waifu = try decoder.decode(Waifu.self, from: data)
            return waifu
        }
        catch {
            print("decoding error")
            return Waifu(images: nil)
        }
        
    }
    
}

