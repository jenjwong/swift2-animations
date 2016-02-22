
import UIKit

// A delay function
func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController {
    
    // MARK: IB outlets
    
    @IBOutlet var picture: [UIImageView]!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var heading: UILabel!
    @IBOutlet weak var subheading: UILabel!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
   
    let messages = ["Coding is the best!", "I've been at it six months", "I used to be forest firefighter",   "Mobile is the Future!"]
    
    var statusPosition = CGPoint.zero
    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        status.hidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .Center
        status.addSubview(label)
        
        statusPosition = status.center
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        heading.center.x  -= view.bounds.width
        subheading.center.x -= view.bounds.width
    

        
        cloud1.alpha = 0.0
        cloud2.alpha = 0.0
        cloud3.alpha = 0.0
        cloud4.alpha = 0.0
        
        loginButton.center.y += 30.0
        loginButton.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, animations: {
            self.heading.center.x += self.view.bounds.width
        })
        
        UIView.animateWithDuration(0.9, animations: {
            self.subheading.center.x += self.view.bounds.width
        })
        

        
        UIView.animateWithDuration(0.5, delay: 0.5, options: [], animations: {
            self.cloud1.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, options: [], animations: {
            self.cloud1.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.7, options: [], animations: {
            self.cloud2.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.9, options: [], animations: {
            self.cloud3.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 1.1, options: [], animations: {
            self.cloud4.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y -= 30.0
            self.loginButton.alpha = 1.0
            }, completion: nil)
        
        animateCloud(cloud1)
        animateCloud(cloud2)
        animateCloud(cloud3)
        animateCloud(cloud4)
    }
    
    // MARK: further methods
    
    @IBAction func login() {
        if self.loginButton.enabled {
            self.loginButton.enabled = false
            
           
            
            UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
                self.loginButton.bounds.size.width += 80.0
                }, completion: nil)
            
            UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
                self.loginButton.center.y += 60.0
                self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
                
                self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height/2)
                self.spinner.alpha = 1.0
                
                }, completion: {_ in
                    self.showMessage(index: 0)
            })
        }
        
    }
    
    func showMessage(index index: Int) {
        label.text = messages[index]
        
        UIView.transitionWithView(status, duration: 0.33, options:
            [.CurveEaseOut, .TransitionFlipFromBottom], animations: {
                self.status.hidden = false
            }, completion: {_ in
                //transition completion
                delay(seconds: 2.0) {
                    if index < self.messages.count-1 {
                        self.removeMessage(index: index)
                    } else {
                        //reset form
                        self.resetForm()
                    }
                }
        })
    }
    
    func removeMessage(index index: Int) {
        UIView.animateWithDuration(0.33, delay: 0.0, options: [], animations: {
            self.status.center.x += self.view.frame.size.width
            }, completion: {_ in
                self.status.hidden = true
                self.status.center = self.statusPosition
                
                self.showMessage(index: index+1)
        })
    }
    
    func resetForm() {
        UIView.transitionWithView(status, duration: 0.2, options: .TransitionFlipFromTop, animations: {
            self.status.hidden = true
            self.status.center = self.statusPosition
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: [], animations: {
            self.spinner.center = CGPoint(x: -20.0, y: 16.0)
            self.spinner.alpha = 0.0
            self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
            self.loginButton.bounds.size.width -= 80.0
            self.loginButton.center.y -= 60.0
            }, completion: { _ in
                self.loginButton.enabled = true
        })
    }
    
    func animateCloud(cloud: UIImageView) {
        let cloudSpeed = 60.0 / view.frame.size.width
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
        UIView.animateWithDuration(NSTimeInterval(duration), delay: 0.0, options: .CurveLinear, animations: {
            cloud.frame.origin.x = self.view.frame.size.width
            }, completion: {_ in
                cloud.frame.origin.x = -cloud.frame.size.width
                self.animateCloud(cloud)
        })
    }
    
}

