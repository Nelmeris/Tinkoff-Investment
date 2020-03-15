//
//  SafariView.swift
//  Kingfisher
//
//  Created by Artem Kufaev on 15.03.2020.
//

import SwiftUI
import SafariServices

@available(iOS 13.0, *)
public struct SafariView: UIViewControllerRepresentable {

    public let url: URL
    
    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}

@available(iOS 13.0, *)
public struct SafariView_Previews: PreviewProvider {
    public static var previews: some View {
        SafariView(url: URL(string: "https://www.reuters.com/article/us-facebook-privacy/facebook-acknowledges-flaw-in-messenger-kids-app-idUSKCN1VJ08X")!)
    }
}
