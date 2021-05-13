//
//  APIHelper.swift
//  HappinScanner
//
//  Created by Cory on 2021-05-12.
//

import Foundation
import Alamofire

class APIHelper {
    //For demo purposes only. An example of a function that makes a network call passing a barcode, and returns our API data parsed into a model object, or returns an error.
    class func checkTicketStatus(_ barcode: Barcode, completion:  @escaping (SomeResponseModel?, Error?) -> Void){
        let endpoint = Constants.API.Endpoints.checkTicketStatus
        let params: [String:Any] = [
            "code": barcode.code
        ]
        
        AF.request(endpoint, method: .get, parameters: params).responseJSON() { response in
            if response.error == nil {
                if let json = response.value as? NSDictionary,
                   let status = json["status"] as? String
                {
                    if status == "success" {
                        if let data = json["data"] as? NSDictionary,
                            let date = data["date"] as? Date, //for example purpose only, JSON would typically be a string and needs conversion to Date
                            let title = data["title"] as? String,
                            let creatorID = data["creatorID"] as? String,
                            let cost = data["cost"] as? Float,
                            let ticketCode = data["ticketCode"] as? String,
                            let isValid = data["isValid"] as? Bool {
                            
                            let responseObj = SomeResponseModel(eventDate: date, eventTitle: title, eventCreatorID: creatorID, eventCost: cost, ticketCode: ticketCode, isValid: isValid)
                            completion(responseObj, nil)
                        }
                    }
                }
            }
            
            //Some error occurred, create and specify the error:
            let error = NSError(domain: "com.happin.product", code: 101, userInfo: [
                NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Please activate your account", comment: ""),
                NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: "Account not activated", comment: "")
            ])
            
            completion(nil, error)
        }
    }
}

