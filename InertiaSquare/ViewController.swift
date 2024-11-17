//
//  Created by Marat Nazirov on 17.11.2024.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        commonInit()
    }
}

// MARK: - Private methods

private extension ViewController {
    func commonInit() {
        view.backgroundColor = .white
        setupSubviews()
        setupContraints()
    }
    
    func setupSubviews() { }
    
    func setupContraints() { }
}
