//
//  RestService.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/19.
//  Copyright © 2020 codewjy. All rights reserved.
//

import SwiftUI

class RestService {
    
    public static var sharedSession = URLSession(configuration: URLSessionConfiguration.default,delegate: ClientCertificateDelegate(), delegateQueue:OperationQueue.main)

}

