module notch(size, radius, angle, offset)
{
    x = cos(angle) * radius;
    y = sin(angle) * radius;
    translate([x,y,0])
    rotate([0,0,angle])
    translate([0,offset,0])
    square(size, center= true);
}

module tile(radius, sides)
{
    segmentAngle = 360/sides;
    a = (180 - segmentAngle) /2;
    diagonal = sin(a) * radius;
    side = cos(a) * radius;
    offset = (side / 2);
    size = [offset/2, offset/2];
    difference()
    {
        union()
        {
            circle(r=radius, $fn=sides);
            for(i = [1:sides])
            {
                angle = (segmentAngle)*(i+0.5);
                notch(size, diagonal, angle, offset);
            }
        }
        for(i = [1:sides])
        {
            angle = (segmentAngle)*(i + 0.5);
            notch(size, diagonal, angle, -offset);
        }
    }   
}


dpi = 72;
inches = 1.8125;
side = inches * dpi;
tile(side,6);