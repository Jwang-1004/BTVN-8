//
//  HomeScreen.swift
//  UTH SmartTasks
//
//  Created by Giang Võ Nguyễn Trường on 6/1/26.
//


import SwiftUI

struct HomeScreen: View {
    // Dữ liệu giả định
    let tasks = [
        "Nộp bài tập iOS",
        "Đi họp nhóm UTH",
        "Chạy bộ 30 phút",
        "Đọc tài liệu Swift"
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground).ignoresSafeArea()
            
            VStack(alignment: .leading) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Xin chào,")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Sinh viên UTH")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color.white)
                
                // Danh sách Task
                Text("Công việc hôm nay")
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(tasks, id: \.self) { task in
                            HStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.blue)
                                Text(task)
                                    .font(.body)
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                        }
                        
                        // Demo nút chuyển màn hình
                        NavigationLink(value: AppRoute.textDetail) {
                            HStack {
                                Text("Xem chi tiết Text Demo")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true) // Ẩn thanh điều hướng mặc định
    }
}