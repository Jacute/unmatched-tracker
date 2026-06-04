const cursorAngle = -Math.PI / 2

function draw(canvas, root) {
    console.debug("[RandomWheel] redraw")
    var ctx = canvas.getContext("2d")
    ctx.clearRect(0, 0, width, height)

    const cx = width / 2
    const cy = height / 2
    const radius = Math.min(width, height) / 2 - 25
    const heroes = root.enabledHeroes
    // step is a value of one sector in degrees
    const step = 2 * Math.PI / heroes.length

    for (var i = 0; i < heroes.length; i++) {
        const imgSrc = heroes[i].img_path
        if (!imgSrc) {
            return
        }

        const start = i * step
        const end = start + step
        const mid = (start + end) / 2

        ctx.save()

        // 1) Sector
        ctx.beginPath()
        ctx.moveTo(cx, cy)
        ctx.arc(cx, cy, radius, start, end)
        ctx.closePath()
        ctx.clip()

        // 2) Background
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

        // 3) Rotated text
        ctx.translate(cx, cy)
        ctx.rotate(mid)

        ctx.textAlign = "center"
        ctx.textBaseline = "middle"

        ctx.fillStyle = "white"
        ctx.font = "bold 16px sans-serif"

        ctx.fillText(heroes[i].name, radius * 0.6, 0)

        ctx.restore()

        // 4) Sector border
        ctx.beginPath()
        ctx.moveTo(cx, cy)
        ctx.arc(cx, cy, radius, start, end)
        ctx.closePath()

        ctx.strokeStyle = "white"
        ctx.lineWidth = 2
        ctx.stroke()
    }
}

// checkWin checks that cursor is pointing at the image
function getWinHero(
    wheelAngle, heroes
) {
    const angle = cursorAngle - wheelAngle
    const step = 2 * Math.PI / heroes.length
    let index = Math.floor((angle % (2 * Math.PI)) / step)
    if (index < 0) index = heroes.length + index
    
    return heroes[index]
}
