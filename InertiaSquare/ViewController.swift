//
//  Created by Marat Nazirov on 17.11.2024.
//

import UIKit

final class ViewController: UIViewController {
        
    private lazy var squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var dynamicAnimator = UIDynamicAnimator(referenceView: view)
    private var snap: UISnapBehavior?

    override func viewDidLoad() {
        commonInit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
}

// MARK: - Private methods

private extension ViewController {
    func commonInit() {
        view.backgroundColor = .white
        setupSubviews()
        setupContraints()
        setupTapRecognizer()
    }
    
    func setupSubviews() { 
        view.addSubview(squareView)
    }
    
    func setupContraints() { 
        squareView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            squareView.heightAnchor.constraint(equalToConstant: 100),
            squareView.widthAnchor.constraint(equalToConstant: 100),
            squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupTapRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(gesture)
    }
    
    @objc
    func handleTap(_ sender: UITapGestureRecognizer) {
        if let snap {
            dynamicAnimator.removeBehavior(snap)
        }
        
        let location = sender.location(in: view)
        snap = UISnapBehavior(item: squareView, snapTo: location)
        snap?.damping = 1
        
        guard let snap else { return  }
        dynamicAnimator.addBehavior(snap)
        
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collision)
        
        let itemBehavior = UIDynamicItemBehavior(items: [squareView])
        itemBehavior.elasticity = 1
        dynamicAnimator.addBehavior(itemBehavior)
    }
}
