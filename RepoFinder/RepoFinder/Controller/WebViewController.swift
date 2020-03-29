import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    var url = ""
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: url) ?? URL(string: "https://iamparsa.com/api/apt_popular_repos/output.sfdb%22).responseJSON")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }}
