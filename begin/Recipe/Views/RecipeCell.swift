/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class RecipeCell: UITableViewCell {
  @IBOutlet var roundedBackgroundView: UIView!
  @IBOutlet var foodImageView: UIImageView!
  @IBOutlet var dishNameLabel: UILabel!
  @IBOutlet var difficultyLabel: UILabel!
  var difficultyValue: RecipeDifficulty = .unknown
  
  override func awakeFromNib() {
    super.awakeFromNib()
    styleAppearance()
  }
  
  func configureCell(with recipe:Recipe) {
      dishNameLabel.text = recipe.name
      foodImageView.image = recipe.photo
      difficultyValue = recipe.difficulty
      difficultyLabel.text = difficultyString

      applyAccessibility0(recipe)
//      applyAccessibility1(recipe)
//      applyAccessibility2(recipe)
//      applyAccessibility3(recipe)
  }
  
  var difficultyString: String {
    switch difficultyValue {
    case .unknown:
      return ""
    case .rating(let value):
      var string = ""
      for _ in 0..<value {
        string.append("🍲")
      }
      return string
    }
  }
  
  func styleAppearance() {
    roundedBackgroundView.layer.cornerRadius = 3.0
    roundedBackgroundView.layer.masksToBounds = false
    roundedBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
    roundedBackgroundView.layer.shadowColor = #colorLiteral(red: 0.05439098924, green: 0.1344551742, blue: 0.1884709597, alpha: 1).cgColor
    roundedBackgroundView.layer.shadowRadius = 1.0
    roundedBackgroundView.layer.shadowOpacity = 0.3
    
    foodImageView.layer.cornerRadius = 3.0
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

// MARK: Accessibility

extension RecipeCell {

    func applyAccessibility3(_ recipe: Recipe) {

        // Action: configure the cell's contentView to be accessible and its elements
        // Result: cell as a whole is announced, elements are selectable too

        var valueStr: String = ""
        switch recipe.difficulty {
            case .unknown:
                valueStr = "Unknown"
            case .rating(let value):
                valueStr = "\(value)"
        }
        contentView.accessibilityLabel = recipe.name + recipe.photoDescription + "Difficulty Level" + valueStr
        contentView.accessibilityHint = "Double tap for more information"
        contentView.isAccessibilityElement = true

        // This part will not be executed because of a cell can't be accessibile in entirety and at the same time accessible of individual elements.
        dishNameLabel.isAccessibilityElement = true
        dishNameLabel.accessibilityTraits = .none
        dishNameLabel.accessibilityLabel = recipe.name

        foodImageView.isAccessibilityElement = true
        foodImageView.accessibilityTraits = .image
        foodImageView.accessibilityLabel = recipe.photoDescription

        difficultyLabel.isAccessibilityElement = true
        difficultyLabel.accessibilityTraits = .none
        difficultyLabel.accessibilityLabel = "Difficulty Level"
        switch recipe.difficulty {
            case .unknown:
                difficultyLabel.accessibilityValue = "Unknown"
            case .rating(let value):
                difficultyLabel.accessibilityValue = "\(value)"
        }

        self.accessibilityElements = [contentView, dishNameLabel, foodImageView, difficultyLabel]

        // Dynamic text
        dishNameLabel.font = .preferredFont(forTextStyle: .body)
        dishNameLabel.adjustsFontForContentSizeCategory = true

        difficultyLabel.font = .preferredFont(forTextStyle: .body)
        difficultyLabel.adjustsFontForContentSizeCategory = true
    }



    func applyAccessibility2(_ recipe: Recipe) {

        // Action: configue the cell to be accessible and its elements
        // Result: only cell as a whole is announced by VO, elements are overriden.

        // Entire cell VO
        self.isAccessibilityElement = true
        var valueStr: String = ""
        switch recipe.difficulty {
            case .unknown:
                valueStr = "Unknown"
            case .rating(let value):
                valueStr = "\(value)"
        }
        self.accessibilityLabel = recipe.name + recipe.photoDescription + "Difficulty Level" + valueStr
        self.accessibilityHint = "Double tap for more information"

        // Elements VO
        dishNameLabel.isAccessibilityElement = true
        dishNameLabel.accessibilityTraits = .none
        dishNameLabel.accessibilityLabel = recipe.name

        foodImageView.isAccessibilityElement = true
        foodImageView.accessibilityTraits = .image
        foodImageView.accessibilityLabel = recipe.photoDescription

        difficultyLabel.isAccessibilityElement = true
        difficultyLabel.accessibilityTraits = .none
        difficultyLabel.accessibilityLabel = "Difficulty Level"
        switch recipe.difficulty {
            case .unknown:
                difficultyLabel.accessibilityValue = "Unknown"
            case .rating(let value):
                difficultyLabel.accessibilityValue = "\(value)"
        }


        // Dynamic text
        dishNameLabel.font = .preferredFont(forTextStyle: .body)
        dishNameLabel.adjustsFontForContentSizeCategory = true

        difficultyLabel.font = .preferredFont(forTextStyle: .body)
        difficultyLabel.adjustsFontForContentSizeCategory = true
    }

    func applyAccessibility1(_ recipe: Recipe) {

        // Action: Set elements to be accessible and provide accessibilityLabel
        // Result: elements are selectable, but cell is not announced by VO.
        // Demo: control VO order X 2

        dishNameLabel.isAccessibilityElement = true
        dishNameLabel.accessibilityTraits = .none
        dishNameLabel.accessibilityLabel = recipe.name

        foodImageView.isAccessibilityElement = true
        foodImageView.accessibilityTraits = .image
        foodImageView.accessibilityLabel = recipe.photoDescription

        difficultyLabel.isAccessibilityElement = true
        difficultyLabel.accessibilityTraits = .none
        difficultyLabel.accessibilityLabel = "Difficulty Level"
        switch recipe.difficulty {
            case .unknown:
                difficultyLabel.accessibilityValue = "Unknown"
            case .rating(let value):
                difficultyLabel.accessibilityValue = "\(value)"
        }

        self.accessibilityElements = [dishNameLabel, foodImageView, difficultyLabel]
        // self.accessibilityElements = [difficultyLabel, foodImageView, dishNameLabel] // for demo 1
        // self.accessibilityElements = [dishNameLabel, foodImageView] // for demo 2

        // Dynamic text
        dishNameLabel.font = .preferredFont(forTextStyle: .body)
        dishNameLabel.adjustsFontForContentSizeCategory = true

        difficultyLabel.font = .preferredFont(forTextStyle: .body)
        difficultyLabel.adjustsFontForContentSizeCategory = true
    }

    func applyAccessibility0(_ recipe: Recipe) {
        // Action: Do nothing + turn off accessible setting in storyboard. Let Apple use its default behavior.
        // Result: no VO for table cell as a whole or by element
    }
}
