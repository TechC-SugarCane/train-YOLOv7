def calculate_center(c1, c2):

    x = (c2[0] - c1[0]) * 0.5
    y = (c2[1] - c1[1]) * 0.5
    
    center_x = c1[0] + x
    center_y = c1[1] + y

    return center_x, center_y

