const cursorAngle = -Math.PI / 2

function draw(canvas, root, cursor) {
    var ctx = canvas.getContext("2d")
    ctx.clearRect(0, 0, width, height)

    const cx = width / 2
    const cy = height / 2
    const radius = Math.min(width, height) / 2 - 25
    // step is a value of one sector in degrees
    const step = 2 * Math.PI / root.heroes.length

    ctx.save()
    // rotate wheel
    ctx.translate(cx, cy)
    ctx.rotate(root.wheelAngle)
    ctx.translate(-cx, -cy)

    for (var i = 0; i < root.heroes.length; i++) {
        const imgSrc = root.heroes[i].img
        if (!canvas.isImageLoaded(imgSrc))
            return

        const start = i * step
        const end = start + step
        const mid = (start + end) / 2

        ctx.save()

        // --- sector ---
        ctx.beginPath()
        ctx.moveTo(cx, cy)
        ctx.arc(cx, cy, radius, start, end)
        ctx.closePath()
        ctx.clip()

        // 1) Background
        ctx.globalAlpha = 0.25

        const imgX = cx - radius * 1.2;
        const imgY = cy - radius * 1.2;
        const imgW = radius * 2.4;
        const imgH = imgW;
        ctx.drawImage(
            imgSrc,
            imgX, imgY,
            imgW, imgH
        )

        ctx.globalAlpha = 1.0

        // 2) Rotated text
        ctx.translate(cx, cy)
        ctx.rotate(mid)

        ctx.textAlign = "center"
        ctx.textBaseline = "middle"

        ctx.fillStyle = "white"
        ctx.font = "bold 16px sans-serif"

        ctx.fillText(root.heroes[i].name, radius * 0.6, 0)

        ctx.restore()

        // sector border
        ctx.beginPath()
        ctx.moveTo(cx, cy)
        ctx.arc(cx, cy, radius, start, end)
        ctx.closePath()

        ctx.strokeStyle = "white"
        ctx.lineWidth = 2
        ctx.stroke()
    }

    // draw wheel cursor
    ctx.restore()
    ctx.drawImage(
        cursor,
        cx - cursor.width / 64,
        0,
        cursor.width / 32,
        cursor.height / 32
    )
}

// checkWin checks that cursor is pointing at the image
function getWinHero(
    root
) {
    const angle = cursorAngle - root.wheelAngle
    const step = 2 * Math.PI / root.heroes.length
    let index = Math.floor((angle % (2 * Math.PI)) / step)
    if (index < 0) index = root.heroes.length + index
    
    return root.heroes[index]
}