# Animated-Indicator

Animated Indicator For Page Tab View

# Issue

Belowing Code's minX value has Error when it's index is more than 4

<pre>
<code>

GeometryReader{proxy -> Color in

    let minX = proxy.frame(in: .global).minX
  
    // print(minX)

    DispatchQueue.main.async {
        withAnimation(.default) {

            self.offset = -minX
        }
    }

    return Color.clear
}

</code>
</pre>

# Action

https://user-images.githubusercontent.com/122873008/223861114-2abb2a80-f4e1-4164-abc3-a91ea7a78a88.mp4
