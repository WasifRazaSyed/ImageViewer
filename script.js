function ifHovered(obj) {
    if(obj.area.containsMouse)
    {
        obj.img.scale=1.2
    }
    else
    {
        obj.img.scale=1.0
    }
}
