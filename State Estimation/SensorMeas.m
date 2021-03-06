function sensor = SensorMeas(pos, x_max, y_max)
	% Align x axis with magnetic north
	% Idea is to draw a line and compute the points of intersection with the dimensions of the box and then take the minimum distance as explained in report
	x = pos(1,1);
	y = pos(2,1);
	theta = pos(3,1);

	slope = tan(theta);

	if(theta == 0 || theta == 360)
	    sensor(1,1) = x_max - x;
	    sensor(2,1) = y;
	    return;
	end

	if(theta > 0 && theta < 90)
		point1_x = (y_max - y)/slope + x;
		point1_y = y_max;
		point2_x = x_max;
		point2_y = slope*(x_max - x) + y;

		point3_x = (y_max - y)/slope + x;
		point3_y = 0;

		point4_x = x_max;
		point4_y = (y_max - y)/slope + x;
	end

	if(theta == 90)
	    sensor(1,1) = y_max - y;
	    sensor(2,1) = x_max - x;
	    return;
	end

	if(theta > 90 && theta < 180)
		point1_x = (y_max - y)/slope + x;
		point1_y = y_max;

		point2_x = 0;
		point2_y = slope*(x_max - x) + y;

		point3_x = (y_max - y)/slope + x;
		point3_y = y_max;

		point4_x = x_max;
		point4_y = (y_max - y)/slope + x;
	end

	if(theta == 180)
	    sensor(1,1) = x;
	    sensor(2,1) = y_max - y;
	    return;
	end

	if(theta > 180 && theta < 270)
		point1_x = 0;
		point1_y = slope*(x_max - x) + y;

		point2_x = (y_max - y)/slope + x;
		point2_y = 0;

		point3_x = (y_max - y)/slope + x;
		point3_y = y_max;

		point4_x = 0;
		point4_y = (y_max - y)/slope + x;
	end

	if(theta == 270)
	    sensor(1,1) = y;
	    sensor(2,1) = x;
	    return;
	end

	if(theta > 270 && theta < 360)
		point1_x = x_max;
		point1_y = slope*(x_max - x) + y;

		point2_x = (y_max - y)/slope + x;
		point2_y = 0;

		point3_x = (y_max - y)/slope + x;
		point3_y = 0;

		point4_x = 0;
		point4_y = (y_max - y)/slope + x;
	end

	d1 = sqrt((point1_x - x)^2 + (point1_y - y)^2);
	d2 = sqrt((point2_x - x)^2 + (point2_y - y)^2);

	sensor(1, 1) = min(d1, d2);

	d3 = sqrt((point3_x - x)^2 + (point3_y - y)^2);
	d4 = sqrt((point4_x - x)^2 + (point4_y - y)^2);

	sensor(2, 1) = min(d3, d4);
end