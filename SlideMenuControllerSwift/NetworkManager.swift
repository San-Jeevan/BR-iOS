
//
//  RestManager.swift
//  Live
//
//  Created by Jeevan Sivagnanasuntharam on 10/08/16.
//  Copyright © 2016 gressquel. All rights reserved.
//

import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    let baseUrl = "https://broadkazt.herokuapp.com"

    
    
    func getItemByCode(_ itemId: String, onCompletion: @escaping (JSON) -> Void) {
        let route =  baseUrl + "/api/account/" + itemId;
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    
    fileprivate func makeHTTPGetRequest(_ path: String, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                if(error==nil){
                 
                onCompletion(json, nil)
                }
                else {
                    onCompletion(json, error as! NSError)
                }
                
            } else {
                onCompletion(nil, error as! NSError)
            }
        })
        task.resume()
    }
    
    
    
    fileprivate func makeHTTPPostProgressRequest(_ path: String, body: [String: AnyObject], onProgress: URLSessionDataDelegate, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        request.httpMethod = "POST"
        
        do {
            // Set the POST body for the request
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = jsonBody
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            let sessionconf = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionconf, delegate: onProgress, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error as! NSError)
                }
            })
            task.resume();
        } catch {
            
            onCompletion(nil, nil)
        }
    }
    
    fileprivate func makeHTTPPostRequest(_ path: String, body: [String: AnyObject], onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        request.httpMethod = "POST"
        
        do {
            // Set the POST body for the request
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = jsonBody
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            let session = URLSession.shared
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error as! NSError)
                }
            })
            task.resume();
        } catch {
            
            onCompletion(nil, nil)
        }
    }
}
