import Foundation

print("Launching ...")
let url = URL(string: "https://dev.vbox.space/api/v1/contract")!

var req = URLRequest(url: url)
req.httpMethod = "POST"

let semaphore = DispatchSemaphore(value: 0)

print("Sending request ...")
URLSession.shared.dataTask(with: req) { _, response,_ in
    print(response ?? "none")
    semaphore.signal()
}.resume()

_ = semaphore.wait(timeout: DispatchTime.distantFuture)
