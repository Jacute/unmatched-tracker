function draw(canvas, heroes) {
    var ctx = canvas.getContext("2d")
    ctx.clearRect(0, 0, width, height)

    var cx = width / 2
    var cy = height / 2
    var radius = Math.min(width, height) / 2 - 10

    var step = 2 * Math.PI / heroes.length
    for (var i = 0; i < heroes.length; i++) {
        var imgSrc = heroes[i].img
        if (!canvas.isImageLoaded(imgSrc))
            return

        var start = i * step
        var end = start + step
        var mid = (start + end) / 2

        ctx.save()

        // --- sector ---
        ctx.beginPath()
        ctx.moveTo(cx, cy)
        ctx.arc(cx, cy, radius, start, end)
        ctx.closePath()
        ctx.clip()

        // 1) Phone
        ctx.globalAlpha = 0.25

        ctx.drawImage(
            imgSrc,
            cx - radius * 1.2,
            cy - radius * 1.2,
            radius * 2.4,
            radius * 2.4
        )

        ctx.globalAlpha = 1.0

        // 2) Rotated text
        ctx.translate(cx, cy)
        ctx.rotate(mid)

        ctx.textAlign = "center"
        ctx.textBaseline = "middle"

        ctx.fillStyle = "white"
        ctx.font = "bold 16px sans-serif"

        ctx.fillText(heroes[i].name, radius * 0.6, 0)

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
}