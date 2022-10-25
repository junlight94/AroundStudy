//
//  PhotoPickerViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/21.
//

import UIKit
import Photos
import Mantis

class PhotoPickerViewController: BaseViewController {

    
    //MARK: Properties
    /// 멀티 셀렉트모드
    var isSingleSelectMode: Bool = true
    /// 사진 최대 선택 개수
    let maxAllowSelectCount: Int = 20
    /// 썸네일 사이즈
    var thumbnailSize: CGSize = .zero
    
    /// 전체 사진 배열
    var allPhotos: PHFetchResult<PHAsset>?
    let imageManager = PHCachingImageManager()
    /// 선택된 사진의 배열
    var selectedPhotos: [PhotoPicker] = []
    /// 선택된 사진 인덱스
    var selectedPhotoIndex: Int = 0
    
    /// 네비게이션바 요소
    @IBOutlet weak var allowCountLabel: UILabel!
    @IBOutlet weak var selectedCountLabel: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    
    /// 제약 조건
    @IBOutlet weak var previewCollectionViewHeightConstraint: NSLayoutConstraint!
    
    /// 컬렉션뷰
    @IBOutlet weak var previewCollectionView: UICollectionView!
    @IBOutlet weak var photoPickerCollectionView: UICollectionView!
    
    /// 드롭다운
    let dropDown = DropDownView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkAuthorization()
    }
}

//MARK: - Layout & Functions
extension PhotoPickerViewController {
    /**
     초기 레이아웃 설정
     > coder : **sanghyeon**
     */
    func setupView() {
        /// 사진 미리보기 컬렉션뷰 세팅
        let previewCellNib = UINib(nibName: "PhotoPreviewCollectionViewCell", bundle: nil)
        previewCollectionView.register(previewCellNib, forCellWithReuseIdentifier: "PhotoPreviewCollectionViewCell")
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
        /// 사진선택 컬렉션뷰 세팅
        let cellNib = UINib(nibName: "PhotoPickerCollectionViewCell", bundle: nil)
        photoPickerCollectionView.register(cellNib, forCellWithReuseIdentifier: "PhotoPickerCollectionViewCell")
        photoPickerCollectionView.delegate = self
        photoPickerCollectionView.dataSource = self
        
        if isSingleSelectMode {
            allowCountLabel.isHidden = true
            selectedCountLabel.isHidden = true
        } else {
            /// 최대 선택 가능 개수 라벨 설정
            allowCountLabel.text = "/\(maxAllowSelectCount)"
            selectedCountLabel.text = "0"
        }
        
        print("VC dropDown: \(dropDown)")
        dropDown.delegate = self
    }
    /**
     포토라이브러리 권한 체크
     > coder : **sanghyeon**
     */
    func checkAuthorization() {
        /// 포토 라이브러리 권한 요청
        authorization.requestPhotoLibraryAuthorization() { result in
            self.dataManager.isAuthorizationPhotoLibrary = result
            if let result = result {
                if result {
                    print("*** ViewController.swift, 포토 라이브러리 권한: 허용")
                    self.fetchAllPhotos()
                } else {
                    print("*** ViewController.swift, 포토 라이브러리 권한: 거부")
                }
            } else {
                print("*** ViewController.swift, 포토 라이브러리 권한: 설정하지 않음")
            }
        }
    }
    /**
     포토라이브러리 사진 가져오기
     > coder : **sanghyeon**
     >> 참고 : https://rhammer.tistory.com/230
     */
    func fetchAllPhotos() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        DispatchQueue.main.async {
            self.photoPickerCollectionView.reloadData()
        }
    }
    /**
     포토라이브러리 에셋 이미지 추출
    > coder : **sanghyeon**
     */
    func fetchPhotos(index: Int, highQuality: Bool = false, completion: @escaping (UIImage?) -> ()) {
        if let asset = allPhotos?.object(at: index) {
            let photosOptions = PHImageRequestOptions()
            photosOptions.deliveryMode = .highQualityFormat
            photosOptions.isSynchronous = true
            photosOptions.isNetworkAccessAllowed = true
            let photoTargetSize: CGSize = highQuality ? PHImageManagerMaximumSize: CGSize(width: 50, height: 50)
            imageManager.requestImage(for: asset, targetSize: photoTargetSize, contentMode: .default, options: photosOptions, resultHandler: { image, info in
                completion(image)
            })
        }
    }
}

//MARK: - DropDown
extension PhotoPickerViewController: DropDownLargeDelegate {
    func tappedDropDown(item: String) {
        print("드롭다운 아이템 클릭, item: \(item)")
    }
    
    func dropDownItem() -> [Any] {
        /// 드롭다운 더미데이터
        let dummyDropDown: [DropDown] = [
            DropDown(title: "전체", subTitle: "(1000)"),
            DropDown(title: "앨범1", subTitle: "(250)"),
            DropDown(title: "앨범2", subTitle: "(100)"),
            DropDown(title: "앨범33333333", subTitle: "(500)"),
            DropDown(title: "앨범 44444", subTitle: "(150)"),
            DropDown(title: "앨범1", subTitle: "(250)"),
            DropDown(title: "앨범2", subTitle: "(100)"),
            DropDown(title: "앨범33333333", subTitle: "(500)"),
            DropDown(title: "앨범 44444", subTitle: "(150)")
        ]
        
        return dummyDropDown
    }
    
    func dropDownTargetButton() -> UIButton {
        return dropDownButton
    }
    
    func overOffset() -> Bool {
        return false
    }
    
    func changeDropDownButtonTitle() -> Bool {
        return true
    }
    
    func itemFont() -> UIFont? {
        return UIFont.setCustomFont(.medium, size: 16)
    }
    
    func dropDownHeight() -> CGFloat {
        return 54
    }
    
    func showIndicator() -> Bool {
        return false
    }
    
    func activeDropDownButtonImage() -> UIImage? {
        return UIImage(named: "navigationUp")
    }
    
    func disableDropDownButtonImage() -> UIImage? {
        return UIImage(named: "navigationDown")
    }
}

//MARK: - CollectionView
extension PhotoPickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case previewCollectionView:
            return selectedPhotos.count
        case photoPickerCollectionView:
            return allPhotos?.count ?? 0 + 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        resizePreviewCollectionView()
        return setupCell(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCell(collectionView, indexPath: indexPath)
        resizePreviewCollectionView()
    }
    
    /// 셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == photoPickerCollectionView {
            let viewWidth = view.frame.width
            let cellWidth = ceil((viewWidth - 6) / 3)
            thumbnailSize = CGSize(width: cellWidth, height: cellWidth)
            return thumbnailSize
        } else {
            return CGSize(width: 70, height: 70)
        }
    }
    
    /**
     컬렉션뷰 셀 설정 기본함수 대체
     > coder : **sanghyeon**
     */
    func setupCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case previewCollectionView:
            guard let cell = previewCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoPreviewCollectionViewCell", for: indexPath) as? PhotoPreviewCollectionViewCell else { return UICollectionViewCell() }
            cell.setImage(image: selectedPhotos[indexPath.row].data.original)
            return cell
        case photoPickerCollectionView:
            guard let cell = photoPickerCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoPickerCollectionViewCell", for: indexPath) as? PhotoPickerCollectionViewCell else { return UICollectionViewCell() }
            if indexPath.row > 0 {
                cell.setupCell(hideIcon: true, hideButton: isSingleSelectMode)
                
                if let asset = allPhotos?.object(at: indexPath.row - 1) {
                    cell.representedAssetIdentifier = asset.localIdentifier
                    fetchPhotos(index: indexPath.row - 1) { result in
                        if let image = result {
                            if cell.representedAssetIdentifier == asset.localIdentifier {
                                cell.setImage(image: image)
                            }
                        }
                    }
                }
                
                if let index = selectedPhotos.firstIndex(where: {$0.index == indexPath.row}) {
                    cell.selectCell(select: true)
                    cell.setIndex(index: index + 1)
                } else {
                    cell.selectCell(select: false)
                    cell.setIndex(index: nil)
                }
            } else {
                cell.setupCell(hideIcon: false, hideButton: true)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    /**
     컬렉션뷰 셀 선택 기본함수 대체
     > coder : **sanghyeon**
     */
    func selectCell(_ collectionView: UICollectionView, indexPath: IndexPath) {
        switch collectionView {
        case previewCollectionView:
            selectedPhotos.remove(at: indexPath.row)
        case photoPickerCollectionView:
            if indexPath.row == 0 {
                return
            }
            
            if isSingleSelectMode {
                
            } else {
                guard let cell = photoPickerCollectionView.cellForItem(at: indexPath) as? PhotoPickerCollectionViewCell else { return }
                
                if let targetIndex = selectedPhotos.firstIndex(where: {$0.index == indexPath.row}) {
                    selectedPhotos.remove(at: targetIndex)
                    cell.selectCell(select: false)
                } else {
                    if maxAllowSelectCount <= selectedPhotos.count {
                        print("최대 선택 개수를 초과함")
                        return
                    }
                    fetchPhotos(index: indexPath.row - 1, highQuality: true) { result in
                        if let image = result {
                            let selectedPhoto: PhotoPicker = .init(index: indexPath.row, data: ImageData(original: image, processed: nil))
                            if let _ = self.selectedPhotos.firstIndex(where: {$0.index == indexPath.row}) { } else {
                                /// 현재 선택된 사진의 인덱스 저장
                                self.selectedPhotoIndex = indexPath.row
                                /// Mantis CropViewController 설정
                                let cropViewController = Mantis.cropCustomizableViewController(image: selectedPhoto.data.original)
                                cropViewController.modalTransitionStyle = .crossDissolve
                                cropViewController.modalPresentationStyle = .fullScreen
                                cropViewController.delegate = self
                                cell.selectCell(select: true)
                                ///self.navigationController?.pushViewController(cropViewController, animated: true)
                                
                                self.selectedPhotos.append(selectedPhoto)
                            }
                        }
                    }
                }
            }
        default:
            return
        }
        
        DispatchQueue.main.async {
            self.selectedCountLabel.text = "\(self.selectedPhotos.count)"
            self.previewCollectionView.reloadData()
            self.photoPickerCollectionView.reloadData()
        }
    }
    
    /**
     미리보기 컬렉션뷰 높이 조정
     - 선택된 사진의 유무에 따라 미리보기 컬렉션뷰 높이를 조정합니다.
     > coder : **sanghyeon**
     */
    func resizePreviewCollectionView() {
        previewCollectionViewHeightConstraint.constant = selectedPhotos.count > 0 ? 70 : 1
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

//MARK: - MantisDelegate
extension PhotoPickerViewController: CropViewControllerDelegate {
    func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Mantis.Transformation, cropInfo: Mantis.CropInfo) {
        print("\(selectedPhotoIndex)번째 이미지가 크랍됨")
        cropViewController.navigationController?.popViewController(animated: true)
        /// 선택된 이미지 인덱스 초기화
        selectedPhotoIndex = 0
    }
    
    func cropViewControllerDidCancel(_ cropViewController: Mantis.CropViewController, original: UIImage) {
        cropViewController.navigationController?.popViewController(animated: true)
        guard let cell = photoPickerCollectionView.cellForItem(at: IndexPath(row: selectedPhotoIndex, section: 0)) as? PhotoPickerCollectionViewCell else { return }
        if let targetIndex = selectedPhotos.firstIndex(where: {$0.index == selectedPhotoIndex}) {
            selectedPhotos.remove(at: targetIndex)
            cell.selectCell(select: false)
        }
    }
    

    
    
    
}
