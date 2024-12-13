clear
load('ExampleData.mat');           %        
lat=Position.latitude;
lon=Position.longitude;  
positionDatetime=Position.Timestamp;

Xacc = Acceleration.X;
Yacc = Acceleration.Y;
Zacc = Acceleration.Z;
accelDatetime=Acceleration.Timestamp;

%We use the following to obtain linear time data in seconds from a datatime
%array
positionTime=timeElapsed(positionDatetime);
accelTime=timeElapsed(accelDatetime);

earthCirc = 24901;
totaldis = 0;
for i = 1: (length(lat)-1)

    lat1 = lat(i);
    lat2 = lat(i+1);
    lon1 = lon(i);
    lon2 = lon(i+1);
 
degDis = distance(lat1, lon1, lat2, lon2);
dis = (degDis/360)*earthCirc;

totaldis = totaldis + dis;
end

stride = 2.5                     % Average Stride (ft)
totaldis_ft = totaldis*5280;     % Converting distance from miles to feet
steps = totaldis_ft/stride;

disp(['The total distance traveled is: ', num2str(totaldis),'miles'])

disp(['You took ', num2str(steps) ' steps'])

plot(accelTime,Xacc);
hold on;
plot(accelTime,Yacc);
plot(accelTime,Zacc);
xlim([0 50])
legend('X Acceleration','Acceleration','Z Acceleration');
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)');
title('Acceleration Data Vs. Time');
hold off
