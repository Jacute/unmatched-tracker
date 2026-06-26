const cursorAngle = -Math.PI / 2

function draw(canvas, root) {
    console.debug("[RandomWheel] redraw")
    var ctx = canvas.getContext("2d")

    const size = Math.min(canvas.width, canvas.height);
    ctx.clearRect(0, 0, size, size)

    const cx = size / 2
    const cy = size / 2
    const radius = size / 2 - 10
    const heroes = root.heroes
    if (heroes.length === 0) {
        return
    }

    // step is a value of one sector in degrees
    const step = 2 * Math.PI / heroes.length

    for (var i = 0; i < heroes.length; i++) {
        const imgSrc = root.imageUrls[heroes[i].img_path]

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
        if (imgSrc) {
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
        } else {
            ctx.globalAlpha = 0.9
            ctx.beginPath()
            ctx.moveTo(cx, cy)
            ctx.arc(cx, cy, radius, start, end)
            ctx.closePath()
            ctx.fillStyle = String(root.placeholderColor)
            ctx.fill()

            ctx.globalAlpha = 0.32
            ctx.beginPath()
            ctx.arc(cx, cy, radius * 0.85, start + step * 0.12, end - step * 0.12)
            ctx.strokeStyle = String(root.placeholderSoftColor)
            ctx.lineWidth = Math.max(8, radius * 0.08)
            ctx.stroke()
        }

        ctx.globalAlpha = 1.0

        // 3) Rotated text
        ctx.translate(cx, cy)
        ctx.rotate(mid)

        ctx.textAlign = "center"
        ctx.textBaseline = "middle"

        ctx.fillStyle = String(root.sectorTextColor)
        ctx.font = `bold ${Math.ceil(root.width * 0.03)}px sans-serif`

        ctx.fillText(heroes[i].name, radius * 0.6, 0)

        ctx.restore()

        // 4) Sector border
        ctx.beginPath()
        ctx.moveTo(cx, cy)
        ctx.arc(cx, cy, radius, start, end)
        ctx.closePath()

        ctx.strokeStyle = String(root.sectorBorderColor)
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
