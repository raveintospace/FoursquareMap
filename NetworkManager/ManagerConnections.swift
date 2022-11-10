//
//  ManagerConnections.swift
//  FoursquareMap
//
//  Created by Uri on 10/11/22.
//

import Foundation
import UIKit
import RxSwift

class ManagerConnections {

    func getVenues() -> Single<[Venue]> {
        
        return Observable.create { observer in
            
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: "https://api.foursquare.com/v2/venues/search?ll=41.385149,2.176704&client_id=SFTEX4E45MNUAZXMABQOF4NVEBEIOYKE53ZNMIP40RX2S4CK&client_secret=5AGNN0IDYHURCDITIZX1PAGMFHEO4O0I4VEBLPKMJEPTQPH4&v=20190717")!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            session.dataTask(with: request) { (data, response, error) in    // in -> closure! // initiates the call to the server
                
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return } // exit if any of these 3 things doesn't happens
                
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(Welcome.self, from: data)    // to decode the json downloaded from our server
                        
                        observer.onNext(response.response.venues)
                    } catch let error {
                        observer.onError(error)
                        print("An error has occured: \(error.localizedDescription)")
                    }
                }
                else if response.statusCode == 401 {
                    print("error 401")
                }
                observer.onCompleted()      // to inform that the observable has been completed
            }.resume()  // end of the return {}
            
            return Disposables.create {                  // to stop the object created and invalidate any current task
                session.finishTasksAndInvalidate()
            }
            
        }.asSingle()
    }
}
