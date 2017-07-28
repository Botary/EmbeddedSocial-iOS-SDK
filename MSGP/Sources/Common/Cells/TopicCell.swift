//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

protocol PostCellDelegate: class {
    func didLike(sender: UICollectionViewCell)
    func didPin(sender: UICollectionViewCell)
    func didComment(sender: UICollectionViewCell)
}

class TopicCell: UICollectionViewCell {
    
    weak var delegate: PostCellDelegate?
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var userPhoto: UIImageView! {
        didSet {
            userPhoto.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var postCreation: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postText: UITextView! {
        didSet {
            postText.textContainerInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 5)
            postText.textContainer.lineFragmentPadding = 0
        }
    }
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var likedList: UILabel!
    
    @IBAction func onTapLike(_ sender: Any) {
        delegate?.didLike(sender: self)
    }
    
    @IBAction private func onTapCommented(_ sender: Any) {
        delegate?.didComment(sender: self)
    }
    
    @IBAction private func onTapPin(_ sender: Any) {
        delegate?.didPin(sender: self)
    }
    
    @IBAction private func onTapExtra(_ sender: Any) {
        
    }
    
    @IBOutlet weak var likedCount: UILabel!
    @IBOutlet weak var commentedCount: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userPhoto.layer.cornerRadius = userPhoto.layer.bounds.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        clipsToBounds = true
    }
    
    func configure(with data: PostViewModel) {

        if data.postImageUrl == nil {
            postImage.image = postImagePlaceholder
        } else {
            postImage.setPhotoWithCaching(Photo(url: data.postImageUrl), placeholder: postImagePlaceholder)
        }
        
        if data.userImageUrl == nil {
            userPhoto.image = userImagePlaceholder
        } else {
            userPhoto.setPhotoWithCaching(Photo(url: data.userImageUrl), placeholder: postImagePlaceholder)
        }
        
        userName.text = "test"//data.userName
        postTitle.text = data.title
        postText.text = data.text
        postCreation.text = data.timeCreated
        likedCount.text = data.totalLikes
        commentedCount.text = data.totalComments
    }
    
    lazy var postImagePlaceholder: UIImage = {
        return UIImage(asset: Asset.placeholderPostNoimage)
    }()
    
    lazy var userImagePlaceholder: UIImage = {
        return UIImage(asset: Asset.userPhotoPlaceholder)
    }()
    
   override func awakeFromNib() {
        self.contentView.addSubview(container)
    }
    
}
