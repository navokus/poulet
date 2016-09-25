//
//  KQPouletRequest.swift
//  iPoulet
//
//  Created by Quoc Khai on 9/23/16.
//  Copyright © 2016 Quoc Khai. All rights reserved.
//

import UIKit


//internal let POULET_API = "http://10.0.0.95:8080"
internal let POULET_API = "http://192.168.2.169:8080"
//internal let POULET_API = "http://172.20.10.3:8080"



//http://localhost:8080/RiskSolution2016/api/hello


// Beacons

//http://10.0.0.95:8080/RiskSolution2016/api/scan/website?webname=dantri.com.vn
internal let ERROR_STATIC = "\(POULET_API)/RiskSolution2016/api/scan/website?webname={webname}&tools=nikto,w3af"


//internal let LOG_GET = "\(POULET_API)/RiskSolution2016/api/scan/website/log?webname={webname}"
internal let LOG_GET = "\(POULET_API)/RiskSolution2016/api/scan/website/log?webname=http://{webname}&typelog=nikto-csl"

//http://localhost:8080/RiskSolution2016/api/scan/website/log?webname=http://dantri.com.vn&typelog=nikto-csl
//RiskSolution2016/api/scan/website/log?webname=http://dantri.com.vn&typelog=nikto-csl




class KQPouletRequest: NSObject {

}
