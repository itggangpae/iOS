//
//  ViewController.swift
//  SocketIOS
//
//  Created by Adam on 2021/03/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tfMsg: UITextField!
    
    let host = "172.30.1.4"
    let port = 9999
    var client: TCPClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reachability = Reachability()
        NSLog("\(reachability.isConnectedToNetwork())")
        
        client = TCPClient(address: host, port: Int32(port))
    }
    
    private func sendRequest(string: String, using client: TCPClient) -> String? {
        appendToTextField(string: "Sending data ... ")
        
        switch client.send(string: string) {
        case .success:
            return readResponse(from: client)
        case .failure(let error):
            appendToTextField(string: String(describing: error))
            return nil
        }
    }
    private func readResponse(from client: TCPClient) -> String? {
        sleep(3)
        guard let response = client.read(1024*10)
        else { return nil }
        
        return String(bytes: response, encoding: .utf8)
    }
    
    private func appendToTextField(string: String) {
        NSLog(string)
        textView.text = textView.text.appending("\n\(string)")
    }
    
    @IBAction func send(_ sender: Any) {
        guard let client = client else { return }
        
        switch client.connect(timeout: 60) {
        case .success:
            appendToTextField(string: "Connected to host \(client.address)")
            if let response = sendRequest(string: "\(tfMsg.text!)\n\n", using: client) {
                appendToTextField(string: "Response: \(response)")
            }
        case .failure(let error):
            appendToTextField(string: String(describing: error))
        }
        
        
    }
}

