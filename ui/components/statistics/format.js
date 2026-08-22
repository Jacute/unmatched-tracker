function percent(value) {
    if (value === undefined || value === null || value === "") {
        return "-"
    }
    const number = Number(value)
    return (isNaN(number) ? 0 : number).toFixed(1) + "%"
}