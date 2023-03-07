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

