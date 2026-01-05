//
//  AppRoute.swift
//  UTH SmartTasks
//
//  Created by Giang Võ Nguyễn Trường on 6/1/26.
//


import SwiftUI
import Combine
// --- PHẦN 1: ROUTER (OOP) ---
// Định nghĩa các địa điểm (Màn hình) có thể đến
enum AppRoute: Hashable {
    case home
    case textDetail
    case imageDetail
    // Bạn có thể thêm các case khác: boxDetail, layoutDetail...
}

// Class quản lý ngăn xếp điều hướng (Bắt buộc là class để dùng ObservableObject)
class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    // Hàm reset về màn hình đầu tiên
    func popToRoot() {
        path = NavigationPath()
    }
}

// --- PHẦN 2: NAVIGATOR VIEW ---
struct AppNavigator: View {
    // Khởi tạo router (Object) để quản lý xuyên suốt
    @StateObject private var router = AppRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            // Màn hình gốc là HomeScreen
            HomeScreen()
                // Định nghĩa bản đồ hướng dẫn đường đi
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .home:
                        HomeScreen()
                    case .textDetail:
                        TextDetailScreen()
                    case .imageDetail:
                        ImageDetailScreen()
                    }
                }
        }
        // Truyền router xuống các màn hình con (nếu cần dùng nút Back to Root)
        .environmentObject(router)
    }
}

// --- PHẦN 3: CÁC MÀN HÌNH CON (DUMMY SCREENS) ---
// Để code không báo lỗi đỏ, ta tạo tạm các màn hình chi tiết ở đây.
// Sau này bạn tách ra file riêng thì xóa đoạn này đi.

struct TextDetailScreen: View {
    var body: some View {
        VStack {
            Text("Đây là màn hình Text Detail")
                .font(.title)
            Text("Nội dung bài học về Text...")
        }
        .navigationTitle("Text Detail")
    }
}

struct ImageDetailScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Đây là màn hình Image Detail")
        }
        .navigationTitle("Image Detail")
    }
}
