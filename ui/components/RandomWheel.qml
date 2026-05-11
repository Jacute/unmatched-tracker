import QtQuick


Rectangle {
    id: root
    radius: width / 2
    color: "red"
    
    Canvas {
        anchors.fill: parent
        anchors.centerIn: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            var centerX = width / 2;
            var centerY = height / 2;
            var radius = Math.min(width, height) / 2 - 10;
            var startAngle = 0
            var endAngle = Math.PI / 3
            var angle = endAngle - startAngle
            
            ctx.beginPath()
            ctx.moveTo(centerX, centerY)
            ctx.arc(centerX, centerY, radius, startAngle, endAngle)
            ctx.closePath()
            
            ctx.fillStyle = "red"
            ctx.fill()
            
            ctx.strokeStyle = "darkred"
            ctx.lineWidth = 2
            ctx.stroke()
        }
    }
}