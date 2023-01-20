//
//  TwitterBluePlus.swift
//  SwiftUI Demos
//
//  Created by Morten Just on 1/19/23.
//

import SwiftUI


// MARK: Main

struct TwitterBluePlus: View {
    @State var topMenuItems : [MenuItem] = [MenuItem(title: "For you", icon: nil), MenuItem(title: "Following", icon: nil)]
    @State var selectedIdx = 0
    
    var selected : MenuItem { topMenuItems[selectedIdx] }
    
    let twitterColor = Color(hue:0.585, saturation:0.502, brightness:0.165)

    var body: some View {
        ZStack {
            VStack(spacing:0) {
                // Time bar
                CropImage("Following", fRect: CGRect(x: 0, y: 0.0, width: 1, height: 0.06))
                
                // Profile photo
                CropImage("For you", fRect: CGRect(x: 0, y: 0.06, width: 1, height: 0.060))
                
                // Menu
                TopMenu(items: $topMenuItems)
                
                // Tweets
                CropImage(selected.title, fRect: CGRect(x: 0, y: 0.153, width: 1, height: 0.8))
                    .transition(.move(edge: .leading))
                    .animation(.default, value: selected)
                
                Spacer()
            }
            .frame(width: 500, height: 1000)
            .background(twitterColor)
        }.padding(50)
    }
}

// MARK: Top menu item
struct TopMenuItemView : View {
    let item: MenuItem
    let isEditing : Bool
    @Binding var items : [MenuItem]
    @State var isDown = false
    
    func remove(_ item : MenuItem) {
        withAnimation {
            items.removeAll { $0.title == item.title }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                if isEditing && items.count > 1{
                    Button {
                        remove(item)
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .offset(y: -5)
                    }
                    .contentShape(Rectangle())
                    .buttonStyle(.plain)
                    .transition(.scale
                        .combined(with: .opacity)
                    )
                    
                }
                Text(item.title)
                    .font(.title.bold())
                    .fixedSize(horizontal: true, vertical: true)
                    .opacity(isDown ? 0.8 : 1)
            }
            
            ZStack {
                if item == items.first { // should be Selected
                    Capsule()
                        .fill(Color(hue:0.566, saturation:0.889, brightness:0.936))
                }
            }
            .frame(height: 4)
        }.onHover { h in
            isDown = h
        }
        
    }
}



// MARK: Top menu

struct TopMenu : View {
    @State var isEditing = false
    @Binding var items : [MenuItem]
    @State var draggingItem : MenuItem?
    @State var dragItemLocation : CGPoint?
    @State var hasChangedLocation = false
    
    var body: some View {
        VStack(spacing:0) {
            HStack {
                Group {
                    HStack(spacing: 17) {
                        ForEach(items) { item in
                            TopMenuItemView(item: item, isEditing: isEditing, items: $items)
                                .frame(maxWidth: 100)
                                .transition(.smoke)
                                .wiggle(isEditing)
                                .padding(.leading, 17)
                                .onDrag {
                                    return .init(object: NSString(string: item.id))
                                } preview: {
                                    Rectangle().frame(width: .zero)
                                }
                                .onDrop(of: [.utf8PlainText], delegate: MenuDropDelegate(item: item, current: $draggingItem, items: $items, hasChangedLocation: $hasChangedLocation, itemLocation: $dragItemLocation))
                        }
                        Spacer()
                    }
                    .animation(.default, value: items)
                    .contentShape(Rectangle())
                    
                    .simultaneousGesture(
                        LongPressGesture()
                            .onEnded({ ended in
                                withAnimation(.interactiveSpring()) {
                                    isEditing = true
                                }
                            })
                            .onChanged({ changed in
                                print("longpressiez", changed)
                            })
                    )
                    .frame(maxWidth: .infinity)
                    .clipped()
                }
                if isEditing {
                    Button {
                        withAnimation(.default)  {
                            isEditing = false
                            
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.title.bold())
                    }.buttonStyle(.plain)
                        .padding()
                }
            }
            // Hairline
            Rectangle().fill(.white.opacity(0.2)).frame(height: 0.5)
            
        }
    }
}


// MARK: Preview

struct TwitterBluePlus_Previews: PreviewProvider {
    static var previews: some View {
        TwitterBluePlus()
    }
}



// MARK: Model

struct MenuItem : Identifiable, Equatable {
    var id = UUID().uuidString
    let title : String
    let icon : Image?
}




// MARK: View Modifier

extension View {
    func wiggle(_ active : Bool) -> some View {
        self.modifier(WiggleMode(active: active))
    }
}

struct WiggleMode : ViewModifier {
    let active : Bool
    @State var go = false
    let rota = 2.0

    func body(content: Content) -> some View {
        let a = Animation.linear(duration: 0.15)

        content
            .rotationEffect(.degrees(active ? (go ? rota : -rota) : 0))
            .onChange(of: active) { newValue in
                withAnimation(active
                              ? a
                              : a.repeatForever(autoreverses: true).delay(0.5 * Double.random(in: 0...1))) {
                    print("turning on:", newValue)
                    go = newValue
                }
            }
    }
}


struct MenuDropDelegate : DropDelegate {
    let item : MenuItem
    @Binding var current: MenuItem?
    @Binding var items: [MenuItem]
    @Binding var hasChangedLocation : Bool
    @Binding var itemLocation : CGPoint?
    
    func dropEntered(info: DropInfo) {
        if current == nil {
            current = item
            itemLocation = info.location
        }
        
        guard item != current, let current, let from = items.firstIndex(of: current), let toIndex = items.firstIndex(of: item) else { return }
        
        hasChangedLocation = true
        itemLocation = info.location
        
        if items[toIndex] != current {
            items.move(fromOffsets: IndexSet(integer: from), toOffset: toIndex > from ? toIndex + 1 : toIndex)
        }
    }
    
    func dropExited(info: DropInfo) {
        itemLocation = nil
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }
    func performDrop(info: DropInfo) -> Bool {
        hasChangedLocation = false
        itemLocation = nil
        current = nil
        return true
    }
}


// MARK: Crop image
struct CropImage : View {
    let image : CGImage
    
    init(_ name : String, fRect rect: CGRect) {
        let image = NSImage(named: name)!
        let cg = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        
        let w = CGFloat(cg.width)
        let h = CGFloat(cg.height)
        
        let origin = CGPoint(x: rect.origin.x * w, y: rect.origin.y * h)
        let size = CGSize(width: rect.width * w, height: rect.height * h)
        
        let cropped = cg.cropping(to: CGRect(origin: origin, size: size))!
        
        self.image = cropped
    }
    
    var body: some View {
        Image(image, scale: 1, label: Text("Image"))
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}









struct SmokeView : View {
    var body: some View {
        ZStack {
            Rectangle()
                .padding()
                .blur(radius: 100)
                .scaleEffect(0.4)
                .offset(y: -10)
        }.frame(width: 200, height: 200)
    }
}

struct SmokeTestView: View {
    @State var items = ["one", "two", "three"]
    
    var body: some View {
        VStack {
            ForEach(items, id: \.self) {
                Text("\($0) me now")
                    .transition(.smoke)
            }
            
        }
        .animation(.linear(duration: 3), value: items)
        .onAppear {
            items.remove(at: 0)
            items.append("four")
        }
    }
}


struct SmokeView_Previews : PreviewProvider {
    static var previews: some View {
        SmokeTestView()
    }
}

struct SmokeActive : ViewModifier {
    let i : Double
    
    @State var blur : CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .opacity(1 - i)
            .offset(y: i == 1 ? 100 : 0)
            
    }
}

extension AnyTransition {
    static var smoke: AnyTransition {
        .modifier(active: SmokeActive(i:1),
                  identity: SmokeActive(i:0))
    }
}
