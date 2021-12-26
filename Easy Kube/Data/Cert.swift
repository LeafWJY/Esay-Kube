////
////  Cert.swift
////  Easy Kube
////
////  Created by 王镓耀 on 2020/9/11.
////  Copyright © 2020 codewjy. All rights reserved.
////
//
//import SwiftUI
//import Security
//
//struct Cert: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//
//
//func loadCert(){
//
//    // example data from http://fm4dd.com/openssl/certexamples.htm
//    let pem = """
//        -----BEGIN CERTIFICATE-----
//        MIIC/jCCAeagAwIBAgIJAOU2AKu2m7+WMA0GCSqGSIb3DQEBCwUAMBUxEzARBgNV
//        BAMMCmt1YmVybmV0ZXMwHhcNMTkxMjExMTIzMTE5WhcNMjkxMjA4MTIzMTE5WjA0
//        MRkwFwYDVQQDDBBrdWJlcm5ldGVzLWFkbWluMRcwFQYDVQQKDA5zeXN0ZW06bWFz
//        dGVyczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMR1+gzvX+Yq0V0c
//        0yhd1qhPzEvuF2WLxAv5Oyc4tfVIuwNn3U6n6zjPf8ZwKVg3sQGxzCkbJXj4laWF
//        j8Y++/NzwgWAMLvEI5cYNhIFwD0pct1k+ouWiZSxHDAytZHFXfCTfyJb4HzSaVUc
//        e7c0xjy4ghXZ3Seac5a8UP9I8J8jrowpszHbaQImOXDPEdNtkES+akXNF9x4MHAp
//        uR7z7YISjyuN5wm8DFtG6qSd1r04RdaRk0bgar70uPvKJRdTu92cFsfACjglXb5l
//        RG9a2Vvo+qRBdMxdMrICEe2crQTUEsW/qB+44yH1RnGtIiNEkZrSfWVqfn86vI2x
//        oUEQo/sCAwEAAaMyMDAwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMCBaAwEwYDVR0l
//        BAwwCgYIKwYBBQUHAwIwDQYJKoZIhvcNAQELBQADggEBAIsleBvTjtqFZNO0snGz
//        972MSL9XeDb7uzOPc3lEHhAAtExr1PpPihWYSn84Y6yFmRPpGBYWVje1t4As+WF/
//        07cSlwJMUktaAIQLwfHiQBTT0ofL3zkio3akbN3pqZrwlnnmsSjkHpqA3LOV6N5l
//        g9Ss93nm17P6I1Jz9R3oyYD1Oggwmaxcg+j4H15J168K7p8XT8Xl2NDP0ILZzPma
//        V66sajMw6tvau0H+DEJndLkjDoNFr09n3j5aHRHAq7gEE+HvTOZ4hD5MAGHhPNhs
//        6tPtIFhClFtAEw+tLMyUOEwxoGFvdF+TcYviPA9ry7X0qXbodRjYxgdRxTW/JcuY
//        2cg=
//        -----END CERTIFICATE-----
//        """
//
//    // remove header, footer and newlines from pem string
//
//    let certData = Data(base64Encoded: pem)!
//
//    let certificate: SecCertificate = SecCertificateCreateWithData(nil,certData as CFData)!
//
//    var identity: SecIdentity?
//    let status = SecIdentityCreateWithCertificate(nil, certificate, &identity)
//
//
//
//
//
//
//    // use certificate e.g. copy the public key
////    let publicKey = SecCertificateCopyKey(certificate)!
//
//}
//
//
//
