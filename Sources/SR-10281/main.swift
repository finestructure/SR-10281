import Foundation

class SessionDelegate: NSObject, URLSessionDelegate {
    let validateCertificate: Bool

    init(validateCertificate: Bool = true) {
        self.validateCertificate = validateCertificate
    }

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        #if os(macOS)
        // switching off certificate validation only works on macOS for now
        if !validateCertificate {
            // trust certificate
            let cred = challenge.protectionSpace.serverTrust.map { URLCredential(trust: $0) }
            completionHandler(.useCredential, cred)
            return
        }
        #endif
        completionHandler(.performDefaultHandling, nil)
    }
}

print("Launching ...")
let url = URL(string: "https://dev.vbox.space/api/v1/contract")!

var req = URLRequest(url: url)
req.httpMethod = "POST"

let semaphore = DispatchSemaphore(value: 0)

let delegate = SessionDelegate(validateCertificate: true)
let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)

print("Sending request ...")
URLSession.shared.dataTask(with: req) { _, response,_ in
    print(response ?? "none")
    semaphore.signal()
}.resume()

_ = semaphore.wait(timeout: DispatchTime.distantFuture)
